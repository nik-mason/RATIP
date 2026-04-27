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
        ..style.position = 'relative';

      // 지연 실행: div가 DOM에 붙은 후 카카오맵 초기화
      Future.delayed(const Duration(milliseconds: 500), () {
        try {
          final kakao = js.context['kakao'];
          if (kakao == null) {
            div.text = 'Kakao SDK가 로드되지 않았습니다.';
            return;
          }

          final maps = kakao['maps'];
          final latLng = js.JsObject(
            maps['LatLng'] as js.JsFunction,
            [37.5665, 126.9780],
          );
          final options = js.JsObject.jsify({
            'center': latLng,
            'level': 3,
          });

          // div 요소를 직접 전달
          js.JsObject(
            maps['Map'] as js.JsFunction,
            [div, options],
          );
        } catch (e) {
          div.text = '지도 로드 실패: $e';
        }
      });

      return div;
    });
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
          // Main Content (Map or other screens)
          _buildBody(),

          // Custom Bottom Navigation Bar
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
