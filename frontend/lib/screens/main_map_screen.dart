import 'dart:async';
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
  int _selectedIndex = 0;
  static bool _isViewFactoryRegistered = false;
  static bool _isSdkLoaded = false;
  static Completer<void>? _sdkCompleter;

  @override
  void initState() {
    super.initState();
    _registerMapViewFactory();
  }

  /// Kakao Map SDK를 로드합니다.
  /// 웹: index.html에서 이미 로드된 SDK를 감지하거나, 없으면 동적으로 로드합니다.
  static Future<void> _loadKakaoSdk() async {
    if (_isSdkLoaded) return;
    if (_sdkCompleter != null) {
      return _sdkCompleter!.future;
    }

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

      // Step 2: 네트워크 지연 등으로 아직 로드 안 된 경우 대기 (최대 3초)
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

      // Step 3: index.html에서 못 찾았으면 동적으로 스크립트 삽입 (fallback)
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

      // 로드 후 kakao 객체 존재 확인
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

  /// HtmlElementView 뷰 팩토리를 단 한 번만 등록합니다.
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
          ..style.left = '0'
          ..style.backgroundColor = '#F8F9FF';

        // 비동기로 SDK 로드 후 지도 초기화
        _initMap(container);
        return container;
      },
    );
  }

  /// SDK 로드 완료 후 kakao.maps.load() 콜백 안에서 Map 객체를 생성합니다.
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

  /// DOM API로 에러 메시지를 표시합니다.
  /// innerHtml 대신 createElement를 사용하여 sanitizer 문제를 회피합니다.
  static void _showError(html.DivElement container, String message) {
    // 기존 내용 제거
    container.children.clear();

    final wrapper = html.DivElement()
      ..style.display = 'flex'
      ..style.flexDirection = 'column'
      ..style.alignItems = 'center'
      ..style.justifyContent = 'center'
      ..style.height = '100%'
      ..style.fontFamily = 'sans-serif'
      ..style.fontSize = '14px'
      ..style.color = '#464554'
      ..style.textAlign = 'center'
      ..style.padding = '24px';

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

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return const HtmlElementView(viewType: 'kakao-map-view');
      case 1:
        return const Center(child: Text('Search'));
      case 2:
        return const Center(child: Text('Reviews'));
      case 3:
        return const Center(child: Text('Profile'));
      default:
        return const SizedBox.shrink();
    }
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand, // Stack이 화면 전체를 차지
        children: [
          // 지도(또는 다른 탭 콘텐츠)가 전체를 꽉 채우도록
          Positioned.fill(
            child: _buildBody(),
          ),

          // 플로팅 하단 네비게이션 바
          Positioned(
            bottom: 24,
            left: 24,
            right: 24,
            child: Container(
              height: 72,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: BottomNavigationBar(
                  items: const <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Icon(Icons.map_outlined),
                      label: 'Map',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search_outlined),
                      label: 'Search',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.rate_review_outlined),
                      label: 'Reviews',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline),
                      label: 'Profile',
                    ),
                  ],
                  currentIndex: _selectedIndex,
                  selectedItemColor: AppTheme.primaryColor,
                  unselectedItemColor: AppTheme.outline,
                  onTap: _onItemTapped,
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

