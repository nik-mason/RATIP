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

  @override
  void initState() {
    super.initState();
    _registerMapViewFactory();
  }

  // SDK를 동적으로 로드하는 함수
  static Future<void> _loadKakaoSdk() async {
    if (_isSdkLoaded) return;

    final completer = html.ScriptElement()
      ..src = 'https://dapi.kakao.com/v2/maps/sdk.js?appkey=3862fe77936849cf63911211b069af51&autoload=false'
      ..type = 'text/javascript';
    
    html.document.head!.append(completer);

    // 스크립트가 로드될 때까지 대기
    await completer.onLoad.first;
    _isSdkLoaded = true;
    print('Kakao Map SDK dynamically loaded');
  }

  void _registerMapViewFactory() {
    if (_isViewFactoryRegistered) return;
    _isViewFactoryRegistered = true;

    ui_web.platformViewRegistry.registerViewFactory('kakao-map-view', (int viewId) {
      final div = html.DivElement()
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.position = 'relative'
        ..style.backgroundColor = '#F8F9FF';

      _startInitialization(div);

      return div;
    });
  }

  static Future<void> _startInitialization(html.DivElement div) async {
    await _loadKakaoSdk();
    _initializeMapWithRetry(div);
  }

  static Future<void> _initializeMapWithRetry(html.DivElement div, {int retryCount = 0}) async {
    if (retryCount > 20) {
      div.text = '지도 로딩 실패. 카카오 도메인 설정을 확인해주세요.';
      return;
    }

    try {
      final kakao = js.context['kakao'];
      if (kakao != null && kakao['maps'] != null) {
        final maps = kakao['maps'];
        
        maps.callMethod('load', [js.allowInterop(() {
          final latLng = js.JsObject(
            maps['LatLng'] as js.JsFunction,
            [37.5665, 126.9780],
          );
          final options = js.JsObject.jsify({
            'center': latLng,
            'level': 3,
          });

          js.JsObject(
            maps['Map'] as js.JsFunction,
            [div, options],
          );
        })]);
      } else {
        await Future.delayed(const Duration(milliseconds: 500));
        _initializeMapWithRetry(div, retryCount: retryCount + 1);
      }
    } catch (e) {
      await Future.delayed(const Duration(milliseconds: 500));
      _initializeMapWithRetry(div, retryCount: retryCount + 1);
    }
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
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBody(),
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
                    BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'Map'),
                    BottomNavigationBarItem(icon: Icon(Icons.search_outlined), label: 'Search'),
                    BottomNavigationBarItem(icon: Icon(Icons.rate_review_outlined), label: 'Reviews'),
                    BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
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
