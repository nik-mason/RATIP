import 'package:flutter/material.dart';
import 'package:ratip/theme/app_theme.dart';
import 'dart:ui_web' as ui_web;
import 'dart:html' as html;

class MainMapScreen extends StatefulWidget {
  const MainMapScreen({super.key});

  @override
  State<MainMapScreen> createState() => _MainMapScreenState();
}

class _MainMapScreenState extends State<MainMapScreen> {
  int _selectedIndex = 0;
  final String _viewTypeId = 'kakao-map-view';

  @override
  void initState() {
    super.initState();
    // Kakao Map View Factory 등록
    ui_web.platformViewRegistry.registerViewFactory(_viewTypeId, (int viewId) {
      final html.DivElement div = html.DivElement()
        ..id = 'map'
        ..style.width = '100%'
        ..style.height = '100%';

      // JS를 통한 지도 초기화 (지연 실행)
      html.window.animationFrame.then((_) {
        html.window.console.log('Initializing Kakao Map...');
        final script = html.ScriptElement()
          ..text = '''
            var container = document.getElementById('map');
            var options = {
              center: new kakao.maps.LatLng(37.5665, 126.9780), // 서울 시청 기준
              level: 3
            };
            var map = new kakao.maps.Map(container, options);
          ''';
        div.append(script);
      });

      return div;
    });
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return const KakaoMapWidget(viewTypeId: 'kakao-map-view');
      case 1:
        return const Center(child: Text('Search Placeholder'));
      case 2:
        return const Center(child: Text('Reviews Placeholder'));
      case 3:
        return const Center(child: Text('Profile Placeholder'));
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

class KakaoMapWidget extends StatelessWidget {
  final String viewTypeId;
  const KakaoMapWidget({super.key, required this.viewTypeId});

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: viewTypeId);
  }
}
