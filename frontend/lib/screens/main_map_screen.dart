import 'dart:async';
import 'dart:ui';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ratip/theme/app_theme.dart';
import 'dart:ui_web' as ui_web;
import 'dart:html' as html;
import 'dart:js' as js;

class MainMapScreen extends StatefulWidget {
  const MainMapScreen({super.key});

  @override
  State<MainMapScreen> createState() => _MainMapScreenState();
}

class _MainMapScreenState extends State<MainMapScreen> {
  static bool _isViewFactoryRegistered = false;
  static bool _isSdkLoaded = false;
  static Completer<void>? _sdkCompleter;

  @override
  void initState() {
    super.initState();
    _registerMapViewFactory();
  }

  // ─── SDK Loading ───────────────────────────────────────────────

  static Future<void> _loadKakaoSdk() async {
    if (_isSdkLoaded) return;
    if (_sdkCompleter != null) return _sdkCompleter!.future;

    _sdkCompleter = Completer<void>();

    try {
      debugPrint('[Ratip] _loadKakaoSdk() 시작...');

      // Step 1: index.html에서 이미 로드된 kakao 객체 확인
      if (js.context.hasProperty('kakao')) {
        _isSdkLoaded = true;
        _sdkCompleter!.complete();
        debugPrint('[Ratip] ✅ kakao 객체 발견 (index.html에서 로드됨)');
        return;
      }

      debugPrint('[Ratip] kakao 객체 아직 없음. 잠시 대기...');

      // Step 2: 대기 (최대 3초)
      for (int i = 0; i < 12; i++) {
        await Future.delayed(const Duration(milliseconds: 250));
        if (js.context.hasProperty('kakao')) {
          _isSdkLoaded = true;
          _sdkCompleter!.complete();
          debugPrint('[Ratip] ✅ kakao 객체 발견 (대기 후, ${(i + 1) * 250}ms)');
          return;
        }
      }

      debugPrint('[Ratip] index.html에서 SDK 로드 실패. 동적 로드 시도...');

      // Step 3: 동적 로드 fallback
      final kakaoKey = kIsWeb
          ? (dotenv.env['KAKAO_MAP_WEB_KEY'] ?? '')
          : (dotenv.env['KAKAO_MAP_APP_KEY'] ?? '');

      if (kakaoKey.isEmpty) {
        throw Exception('Kakao API key가 비어있습니다. .env 파일을 확인해주세요.');
      }

      debugPrint('[Ratip] 동적 로드 키: ${kakaoKey.substring(0, 6)}... (${kIsWeb ? "Web" : "App"})');

      final script = html.ScriptElement()
        ..type = 'text/javascript'
        ..src = 'https://dapi.kakao.com/v2/maps/sdk.js?appkey=$kakaoKey&autoload=false';

      script.onError.listen((event) {
        debugPrint('[Ratip] ❌ SDK 스크립트 로드 네트워크 에러: $event');
      });

      html.document.head!.append(script);

      await script.onLoad.first.timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw TimeoutException('SDK 스크립트 로드 타임아웃 (10초)');
        },
      );

      if (!js.context.hasProperty('kakao')) {
        throw Exception('스크립트 로드됐으나 kakao 객체가 없음. API 키를 확인해주세요.');
      }

      _isSdkLoaded = true;
      _sdkCompleter!.complete();
      debugPrint('[Ratip] ✅ SDK 동적 로드 완료');
    } catch (e) {
      debugPrint('[Ratip] ❌ SDK 로드 실패: $e');
      _sdkCompleter!.completeError(e);
      rethrow;
    }
  }

  // ─── View Factory ──────────────────────────────────────────────

  void _registerMapViewFactory() {
    if (_isViewFactoryRegistered) return;
    _isViewFactoryRegistered = true;

    ui_web.platformViewRegistry.registerViewFactory(
      'kakao-map-view',
      (int viewId) {
        final container = html.DivElement()
          ..id = 'kakao-map-$viewId'
          ..style.width = '100%'
          ..style.height = '100%'
          ..style.position = 'absolute'
          ..style.top = '0'
          ..style.left = '0';

        _initMap(container);
        return container;
      },
    );
  }

  // ─── Map Initialization ────────────────────────────────────────

  static Future<void> _initMap(html.DivElement container) async {
    try {
      await _loadKakaoSdk();

      debugPrint('[Ratip] kakao.maps.load() 호출 중...');
      final kakaoMaps = js.context['kakao']['maps'];

      kakaoMaps.callMethod('load', [
        js.allowInterop(() {
          try {
            debugPrint('[Ratip] maps.load 콜백 실행. Map 객체 생성 중...');
            final latLng = js.JsObject(
              js.context['kakao']['maps']['LatLng'] as js.JsFunction,
              [37.5665, 126.9780],
            );
            final options = js.JsObject.jsify({
              'center': latLng,
              'level': 3,
            });
            js.JsObject(
              js.context['kakao']['maps']['Map'] as js.JsFunction,
              [container, options],
            );
            debugPrint('[Ratip] ✅ Kakao Map 렌더링 성공!');
          } catch (e) {
            debugPrint('[Ratip] ❌ Map 생성 에러: $e');
            _showError(container, '지도 생성에 실패했습니다.\n카카오 플랫폼 도메인 설정을 확인해주세요.');
          }
        })
      ]);
    } catch (e) {
      debugPrint('[Ratip] ❌ SDK load/init 에러: $e');
      _showError(container, '카카오 지도 SDK를 불러오지 못했습니다.\n$e');
    }
  }

  static void _showError(html.DivElement container, String message) {
    container.children.clear();

    final wrapper = html.DivElement()
      ..style.display = 'flex'
      ..style.flexDirection = 'column'
      ..style.alignItems = 'center'
      ..style.justifyContent = 'center'
      ..style.height = '100%'
      ..style.fontFamily = 'Inter, sans-serif'
      ..style.fontSize = '14px'
      ..style.color = '#464554'
      ..style.textAlign = 'center'
      ..style.padding = '24px'
      ..style.backgroundColor = '#F8F9FF';

    final icon = html.SpanElement()
      ..text = '🗺️'
      ..style.fontSize = '32px'
      ..style.marginBottom = '16px';

    final text = html.ParagraphElement()
      ..text = message
      ..style.margin = '0'
      ..style.whiteSpace = 'pre-line';

    wrapper.append(icon);
    wrapper.append(text);
    container.append(wrapper);
  }

  // ─── UI Build ──────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── 1) Full-screen Kakao Map
          const Positioned.fill(
            child: HtmlElementView(viewType: 'kakao-map-view'),
          ),

          // ── 2) Top Search Bar (Google Maps style)
          Positioned(
            top: topPadding + 12,
            left: 16,
            right: 16,
            child: _buildSearchBar(),
          ),

          // ── 3) Left sidebar nav icons
          Positioned(
            left: 16,
            top: topPadding + 80,
            child: _buildSideNav(),
          ),

          // ── 4) Right-side controls (zoom, my location)
          Positioned(
            right: 16,
            bottom: 100,
            child: _buildMapControls(),
          ),

          // ── 5) Bottom-left "Layers" chip
          Positioned(
            left: 16,
            bottom: 24,
            child: _buildLayersChip(),
          ),
        ],
      ),
    );
  }

  /// Google Maps style floating search bar
  Widget _buildSearchBar() {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          // Hamburger menu
          Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(28),
            child: InkWell(
              borderRadius: BorderRadius.circular(28),
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.menu, color: Color(0xFF5F6368), size: 24),
              ),
            ),
          ),
          // Search text
          Expanded(
            child: GestureDetector(
              onTap: () {
                // TODO: navigate to search screen
              },
              child: Text(
                'Ratip 에서 검색',
                style: TextStyle(
                  color: const Color(0xFF5F6368),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
          // Profile avatar
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: AppTheme.primaryColor,
              child: const Icon(Icons.person, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }

  /// Left sidebar navigation (Google Maps style vertical icons)
  Widget _buildSideNav() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _sideNavItem(Icons.bookmark_outline, 'Saved', false),
          _sideNavItem(Icons.history, 'Recents', false),
          _sideNavItem(Icons.star_outline, 'Reviews', false),
        ],
      ),
    );
  }

  Widget _sideNavItem(IconData icon, String label, bool isActive) {
    return Tooltip(
      message: label,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {},
          child: Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: 22,
              color: isActive
                  ? AppTheme.primaryColor
                  : const Color(0xFF5F6368),
            ),
          ),
        ),
      ),
    );
  }

  /// Right-side map controls (zoom + my location)
  Widget _buildMapControls() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // My Location button
        _controlButton(
          icon: Icons.my_location,
          onTap: () {
            // TODO: move to current location
          },
        ),
        const SizedBox(height: 12),
        // Zoom controls
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _zoomButton(Icons.add, () {}),
              Container(
                width: 28,
                height: 1,
                color: const Color(0xFFE0E0E0),
              ),
              _zoomButton(Icons.remove, () {}),
            ],
          ),
        ),
      ],
    );
  }

  Widget _controlButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.15),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          child: Icon(icon, size: 22, color: const Color(0xFF5F6368)),
        ),
      ),
    );
  }

  Widget _zoomButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        width: 44,
        height: 40,
        alignment: Alignment.center,
        child: Icon(icon, size: 20, color: const Color(0xFF5F6368)),
      ),
    );
  }

  /// Bottom-left "Layers" chip (like Google Maps)
  Widget _buildLayersChip() {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24),
      elevation: 2,
      shadowColor: Colors.black.withOpacity(0.15),
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          // TODO: show map type selector
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.layers_outlined, size: 20, color: const Color(0xFF5F6368)),
              const SizedBox(width: 6),
              Text(
                '레이어',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF3C4043),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
