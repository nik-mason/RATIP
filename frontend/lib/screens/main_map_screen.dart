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

  @override
  void initState() {
    super.initState();
    _registerMapViewFactory();
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

      _initializeMapWithRetry(div);

      return div;
    });
  }

  // SDK가 로드될 때까지 재시도하는 로직
  Future<void> _initializeMapWithRetry(html.DivElement div, {int retryCount = 0}) async {
    if (retryCount > 10) {
      div.text = 'Kakao SDK 로드 실패 (최대 재시도 초과). 개발자 콘솔의 도메인 설정을 확인해주세요.';
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
        // 아직 로드되지 않았으면 500ms 후 재시도
        print('Kakao SDK not ready yet, retrying... ($retryCount)');
        await Future.delayed(const Duration(milliseconds: 500));
        return _initializeMapWithRetry(div, retryCount: retryCount + 1);
      }
    } catch (e) {
      print('Map init error: $e');
      await Future.delayed(const Duration(milliseconds: 500));
      return _initializeMapWithRetry(div, retryCount: retryCount + 1);
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
                    BottomNavigationBarItem(
                      icon: Icon(Icons.map_outlined),
                      activeIcon: Icon(Icons.map),
                      label: 'Map',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search_outlined),
                      activeIcon: Icon(Icons.search),
                      label: 'Search',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.rate_review_outlined),
                      activeIcon: Icon(Icons.rate_review),
                      label: 'Reviews',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.person_outline),
                      activeIcon: Icon(Icons.person),
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
