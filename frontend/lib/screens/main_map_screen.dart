import 'dart:async';
import 'package:flutter/material.dart';
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

  /// Kakao Map SDK를 동적으로 한 번만 로드합니다.
  static Future<void> _loadKakaoSdk() async {
    // 이미 로드 완료
    if (_isSdkLoaded) return;
    // 이미 로딩 중이면 완료될 때까지 대기
    if (_sdkCompleter != null) {
      return _sdkCompleter!.future;
    }

    _sdkCompleter = Completer<void>();

    final script = html.ScriptElement()
      ..type = 'text/javascript'
      ..src =
          'https://dapi.kakao.com/v2/maps/sdk.js?appkey=3862fe77936849cf63911211b069af51&autoload=false';

    html.document.head!.append(script);

    try {
      await script.onLoad.first;
      _isSdkLoaded = true;
      _sdkCompleter!.complete();
      debugPrint('[Ratip] Kakao Map SDK loaded.');
    } catch (e) {
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

      final kakaoMaps = js.context['kakao']['maps'];

      kakaoMaps.callMethod('load', [
        js.allowInterop(() {
          try {
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
            debugPrint('[Ratip] Kakao Map rendered successfully.');
          } catch (e) {
            debugPrint('[Ratip] Map creation error: $e');
            _showError(container, '지도 생성에 실패했습니다.\n카카오 플랫폼 도메인 설정을 확인해주세요.');
          }
        })
      ]);
    } catch (e) {
      debugPrint('[Ratip] SDK load error: $e');
      _showError(container, '카카오 지도 SDK를 불러오지 못했습니다.\n네트워크 연결을 확인해주세요.');
    }
  }

  static void _showError(html.DivElement container, String message) {
    container.innerHtml = '''
      <div style="
        display:flex;
        flex-direction:column;
        align-items:center;
        justify-content:center;
        height:100%;
        font-family:sans-serif;
        font-size:14px;
        color:#464554;
        text-align:center;
        padding:24px;
      ">
        🗺️<br><br>$message
      </div>
    ''';
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
