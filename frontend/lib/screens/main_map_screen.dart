import 'dart:async';
import 'dart:ui';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:ratip/theme/app_theme.dart';
import 'dart:ui_web' as ui_web;
import 'dart:html' as html;
import 'dart:js' as js;
import 'package:geolocator/geolocator.dart';
import 'package:ratip/screens/place_search_screen.dart';

class MainMapScreen extends StatefulWidget {
  const MainMapScreen({super.key});

  @override
  State<MainMapScreen> createState() => _MainMapScreenState();
}

class _MainMapScreenState extends State<MainMapScreen> {
  static bool _isViewFactoryRegistered = false;
  static bool _isSdkLoaded = false;
  static Completer<void>? _sdkCompleter;

  static js.JsObject? _mapInstance;
  static js.JsObject? _myLocationMarker;
  StreamSubscription<Position>? _positionStream;

  static final List<js.JsObject> _searchMarkers = [];
  static js.JsObject? _activeInfoWindow;
  Map<String, dynamic>? _selectedPlaceDetails;
  
  static _MainMapScreenState? _activeState;

  @override
  void initState() {
    super.initState();
    _activeState = this;
    _registerMapViewFactory();
    // Delay permission check slightly to ensure UI is ready
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _checkLocationPermissionAndTrack();
      }
    });
  }

  @override
  void dispose() {
    _positionStream?.cancel();
    super.dispose();
  }

  // ─── Location & Permission ──────────────────────────────────────

  Future<void> _checkLocationPermissionAndTrack() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showPermissionDialog('위치 서비스가 비활성화되어 있습니다. 설정에서 켜주세요.');
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      // 권한 요청 안내 팝업 (Task 11)
      final bool? shouldRequest = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Text('GPS 권한 요청', style: TextStyle(fontWeight: FontWeight.bold)),
          content: const Text('현재 위치를 확인하고 주변 리뷰를 탐색하기 위해 위치 권한이 필요합니다.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('취소', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () => Navigator.pop(context, true),
              child: const Text('권한 허용', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );

      if (shouldRequest != true) return;

      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      _showPermissionDialog('위치 권한이 영구적으로 거부되었습니다. 설정에서 허용해주세요.');
      return;
    }

    // Permission granted, start tracking (Task 10)
    _startLocationTracking();
  }

  void _showPermissionDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('확인', style: TextStyle(color: AppTheme.primaryColor)),
          ),
        ],
      ),
    );
  }

  void _startLocationTracking() {
    _positionStream?.cancel();
    _positionStream = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) {
      _updateMyLocationMarker(position.latitude, position.longitude);
    });

    // Get current position immediately and move map when map is ready
    _moveToCurrentLocation(showFeedback: false);
  }

  Future<void> _moveToCurrentLocation({bool showFeedback = true}) async {
    try {
      if (showFeedback && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('현재 위치를 찾는 중...'), duration: Duration(seconds: 1)),
        );
      }

      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Wait up to 5 seconds for map to be ready if it's not yet
      int attempts = 0;
      while (_mapInstance == null && attempts < 10) {
        await Future.delayed(const Duration(milliseconds: 500));
        attempts++;
      }

      if (_mapInstance != null) {
        _moveToLocation(pos.latitude, pos.longitude);
        _updateMyLocationMarker(pos.latitude, pos.longitude);
      } else {
        if (showFeedback && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('지도를 불러오는 중입니다. 잠시 후 다시 시도해주세요.')),
          );
        }
      }
    } catch (e) {
      debugPrint('[Ratip] _moveToCurrentLocation error: $e');
      if (showFeedback && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('위치를 가져오지 못했습니다: $e')),
        );
      }
    }
  }

  void _updateMyLocationMarker(double lat, double lng) {
    if (_mapInstance == null) return;
    try {
      final kakaoMaps = js.context['kakao']['maps'];
      final latLng = js.JsObject(kakaoMaps['LatLng'] as js.JsFunction, [lat, lng]);

      if (_myLocationMarker == null) {
        // Use custom here.gif from web/assets
        final imageSrc = 'assets/here.gif';
        // Original size: 1122 x 1589. Ratio is ~1:1.416
        // Setting width 60, height 85 to preserve ratio and avoid distortion
        final imageSize = js.JsObject(kakaoMaps['Size'] as js.JsFunction, [60, 85]);
        final markerImage = js.JsObject(kakaoMaps['MarkerImage'] as js.JsFunction, [imageSrc, imageSize]);

        final markerOptions = js.JsObject.jsify({
          'position': latLng,
          'image': markerImage,
          'map': _mapInstance,
          'zIndex': 10, // Ensure it's on top
        });
        _myLocationMarker = js.JsObject(kakaoMaps['Marker'] as js.JsFunction, [markerOptions]);
      } else {
        _myLocationMarker!.callMethod('setPosition', [latLng]);
      }
    } catch (e) {
      debugPrint('[Ratip] Marker update error: $e');
    }
  }

  void _showSearchPulse(double lat, double lng) {
    if (_mapInstance == null) return;
    try {
      final kakaoMaps = js.context['kakao']['maps'];
      final latLng = js.JsObject(kakaoMaps['LatLng'] as js.JsFunction, [lat, lng]);
      
      final content = html.DivElement()..className = 'search-pulse';
      final overlayOptions = js.JsObject.jsify({
        'content': content,
        'position': latLng,
        'zIndex': 5,
      });
      
      final pulseOverlay = js.JsObject(kakaoMaps['CustomOverlay'] as js.JsFunction, [overlayOptions]);
      pulseOverlay.callMethod('setMap', [_mapInstance]);
      
      // Remove after 4 seconds
      Future.delayed(const Duration(seconds: 4), () {
        pulseOverlay.callMethod('setMap', [null]);
      });
    } catch (e) {
      debugPrint('[Ratip] Pulse error: $e');
    }
  }

  void _addSearchResultMarker(double lat, double lng, String placeName, String address, {bool isOpen = false, String? phone, String? category, String? placeUrl}) {
    if (_mapInstance == null) return;
    try {
      final kakaoMaps = js.context['kakao']['maps'];
      final latLng = js.JsObject(kakaoMaps['LatLng'] as js.JsFunction, [lat, lng]);

      // 1. Create Enhanced Custom Marker (Icon + Name)
      final markerContainer = html.DivElement()..className = 'ratip-marker-container';
      
      final markerIcon = html.DivElement()..className = 'ratip-marker-icon';
      // If it's a specific category, we could change the icon color/content here
      
      final markerLabel = html.DivElement()
        ..className = 'ratip-marker-label'
        ..text = placeName;

      markerContainer.append(markerIcon);
      markerContainer.append(markerLabel);

      final markerOverlayOptions = js.JsObject.jsify({
        'position': latLng,
        'content': markerContainer,
        'yAnchor': 0.8,
      });
      final markerOverlay = js.JsObject(kakaoMaps['CustomOverlay'] as js.JsFunction, [markerOverlayOptions]);
      markerOverlay.callMethod('setMap', [_mapInstance]);
      _searchMarkers.add(markerOverlay);

      // 2. Interaction: Marker Click -> Directly Show Left Panel
      markerContainer.onClick.listen((_) {
        if (mounted) {
          setState(() {
            _selectedPlaceDetails = {
              'place_name': placeName,
              'road_address_name': address,
              'lat': lat,
              'lng': lng,
              'phone': phone ?? '',
              'category': category ?? '',
              'placeUrl': placeUrl ?? '',
            };
          });
          _moveToLocation(lat, lng);
        }
      });

    } catch (e) {
      debugPrint('[Ratip] Add enhanced marker error: $e');
    }
  }

  void _moveToLocation(double lat, double lng) {
    if (_mapInstance == null) return;
    try {
      final kakaoMaps = js.context['kakao']['maps'];
      final latLng = js.JsObject(kakaoMaps['LatLng'] as js.JsFunction, [lat, lng]);
      _mapInstance!.callMethod('panTo', [latLng]);
    } catch (e) {
      debugPrint('[Ratip] Move map error: $e');
    }
  }

  void _zoomIn() {
    if (_mapInstance == null) return;
    try {
      final int level = _mapInstance!.callMethod('getLevel');
      if (level > 1) {
        _mapInstance!.callMethod('setLevel', [level - 1]);
      }
    } catch (e) {
      debugPrint('[Ratip] Zoom in error: $e');
    }
  }

  void _zoomOut() {
    if (_mapInstance == null) return;
    try {
      final int level = _mapInstance!.callMethod('getLevel');
      _mapInstance!.callMethod('setLevel', [level + 1]);
    } catch (e) {
      debugPrint('[Ratip] Zoom out error: $e');
    }
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
        ..src = 'https://dapi.kakao.com/v2/maps/sdk.js?appkey=$kakaoKey&autoload=false&libraries=services';

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
              'level': 2, // Default zoom level closer (Task: zoom in more)
            });
            _mapInstance = js.JsObject(
              js.context['kakao']['maps']['Map'] as js.JsFunction,
              [container, options],
            );
            debugPrint('[Ratip] ✅ Kakao Map 렌더링 성공!');

            // Inject Custom Styles for Animated Enhanced Markers
            final style = html.StyleElement()
              ..text = '''
                .ratip-marker-container {
                  display: flex;
                  flex-direction: column;
                  align-items: center;
                  cursor: pointer;
                  transition: transform 0.2s cubic-bezier(0.175, 0.885, 0.32, 1.275);
                  pointer-events: auto;
                }
                .ratip-marker-container:hover {
                  transform: scale(1.25);
                  z-index: 1000;
                }
                .ratip-marker-icon {
                  width: 22px;
                  height: 22px;
                  background-color: #6c757d;
                  border: 3px solid white;
                  border-radius: 50%;
                  box-shadow: 0 2px 8px rgba(0,0,0,0.2);
                  position: relative;
                }
                .ratip-marker-icon::after {
                  content: '';
                  position: absolute;
                  top: 50%;
                  left: 50%;
                  transform: translate(-50%, -50%);
                  width: 6px;
                  height: 6px;
                  background-color: white;
                  border-radius: 1px;
                }
                .ratip-marker-label {
                  margin-top: 4px;
                  background-color: white;
                  padding: 3px 8px;
                  border-radius: 6px;
                  font-size: 13px;
                  font-weight: 600;
                  color: #333;
                  box-shadow: 0 2px 6px rgba(0,0,0,0.1);
                  white-space: nowrap;
                  border: 1px solid rgba(0,0,0,0.05);
                }
                .ratip-marker-container:hover .ratip-marker-label {
                  background-color: #4285F4;
                  color: white;
                }
              ''';
            html.document.head!.append(style);

            // Add map click listener for POI-like behavior
            final kakaoEvent = js.context['kakao']['maps']['event'];
            kakaoEvent.callMethod('addListener', [
              _mapInstance,
              'click',
              js.allowInterop((mouseEvent) {
                if (_activeState == null) return;
                
                final latLng = mouseEvent['latLng'];
                final lat = latLng.callMethod('getLat');
                final lng = latLng.callMethod('getLng');
                
                // Clear existing markers and details
                for (final marker in _searchMarkers) {
                  marker.callMethod('setMap', [null]);
                }
                _searchMarkers.clear();
                if (_activeInfoWindow != null) {
                  _activeInfoWindow!.callMethod('close');
                }
                _activeState!.setState(() {
                  _activeState!._selectedPlaceDetails = null;
                });
                
                // Reverse geocoding & Places search
                final geocoder = js.JsObject(js.context['kakao']['maps']['services']['Geocoder'] as js.JsFunction);
                final places = js.JsObject(js.context['kakao']['maps']['services']['Places'] as js.JsFunction);

                geocoder.callMethod('coord2Address', [lng, lat, js.allowInterop((result, status) {
                  if (status == 'OK') {
                    final list = result as List<dynamic>;
                    if (list.isNotEmpty) {
                      final item = list[0] as js.JsObject;
                      final roadAddress = item['road_address'];
                      final address = item['address'];
                      
                      String fallbackPlaceName = '선택된 위치';
                      String addrName = '';
                      String keyword = '';
                      
                      if (roadAddress != null) {
                        final jsRoadAddress = roadAddress as js.JsObject;
                        final buildingName = jsRoadAddress['building_name'];
                        if (buildingName != null && buildingName.toString().trim().isNotEmpty) {
                          fallbackPlaceName = buildingName.toString();
                        }
                        addrName = jsRoadAddress['address_name']?.toString() ?? '';
                      } else if (address != null) {
                        final jsAddress = address as js.JsObject;
                        addrName = jsAddress['address_name']?.toString() ?? '';
                      }

                      keyword = fallbackPlaceName != '선택된 위치' ? fallbackPlaceName : addrName;

                      if (keyword.isNotEmpty) {
                         final searchOptions = js.JsObject.jsify({
                           'x': lng,
                           'y': lat,
                           'radius': 50,
                           'sort': js.context['kakao']['maps']['services']['SortBy']['DISTANCE']
                         });
                         places.callMethod('keywordSearch', [keyword, js.allowInterop((placeResult, placeStatus, pagination) {
                             if (placeStatus == 'OK') {
                                 final pList = placeResult as List<dynamic>;
                                 if (pList.isNotEmpty) {
                                     final place = pList[0] as js.JsObject;
                                     final realName = place['place_name']?.toString() ?? fallbackPlaceName;
                                     final phone = place['phone']?.toString() ?? '';
                                     final category = place['category_group_name']?.toString() ?? '';
                                     final placeUrl = place['place_url']?.toString() ?? '';
                                     
                                     _activeState!._addSearchResultMarker(lat as double, lng as double, realName, addrName, isOpen: true, phone: phone, category: category, placeUrl: placeUrl);
                                     
                                     // Directly show side panel
                                     _activeState!.setState(() {
                                       _activeState!._selectedPlaceDetails = {
                                         'place_name': realName,
                                         'road_address_name': addrName,
                                         'lat': lat,
                                         'lng': lng,
                                         'phone': phone,
                                         'category': category,
                                         'placeUrl': placeUrl,
                                       };
                                     });
                                     return;
                                 }
                             }
                             // Fallback
                             _activeState!._addSearchResultMarker(lat as double, lng as double, fallbackPlaceName, addrName, isOpen: true);
                             _activeState!.setState(() {
                               _activeState!._selectedPlaceDetails = {
                                 'place_name': fallbackPlaceName,
                                 'road_address_name': addrName,
                                 'lat': lat,
                                 'lng': lng,
                               };
                             });
                         }), searchOptions]);
                      } else {
                         // Fallback
                         _activeState!._addSearchResultMarker(lat as double, lng as double, fallbackPlaceName, addrName, isOpen: true);
                         _activeState!.setState(() {
                           _activeState!._selectedPlaceDetails = {
                             'place_name': fallbackPlaceName,
                             'road_address_name': addrName,
                             'lat': lat,
                             'lng': lng,
                           };
                         });
                      }
                    }
                  }
                })]);
              })
            ]);

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
            child: PointerInterceptor(child: _buildSearchBar()),
          ),
          
          // ── 3) Left sidebar navigation (Google Maps style vertical icons)
          if (_selectedPlaceDetails == null)
            Positioned(
              left: 16,
              top: topPadding + 80,
              child: PointerInterceptor(child: _buildSideNav()),
            )
          else
            Positioned(
              left: 16,
              top: topPadding + 80,
              bottom: 100, // Leave space for map controls
              child: PointerInterceptor(child: _buildLeftDetailPanel()),
            ),

          // ── 4) Right-side controls (zoom, my location)
          Positioned(
            right: 16,
            bottom: 100,
            child: PointerInterceptor(child: _buildMapControls()),
          ),

          // ── 5) Bottom-left "Layers" chip
          Positioned(
            left: 16,
            bottom: 24,
            child: PointerInterceptor(child: _buildLayersChip()),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PlaceSearchScreen()),
                ).then((result) {
                  if (result != null && result is Map<String, dynamic>) {
                    try {
                      final selectedPlace = result['selected'];
                      final allResults = result['results'] as List<dynamic>? ?? [];

                      // clear existing markers
                      for (final marker in _searchMarkers) {
                        marker.callMethod('setMap', [null]);
                      }
                      _searchMarkers.clear();

                      if (_activeInfoWindow != null) {
                        _activeInfoWindow!.callMethod('close');
                      }

                      // plot all results
                      for (var p in allResults) {
                        final lat = double.parse(p['y'].toString());
                        final lng = double.parse(p['x'].toString());
                        final name = p['place_name']?.toString() ?? '';
                        final addr = p['road_address_name']?.toString().isNotEmpty == true 
                                     ? p['road_address_name'].toString() 
                                     : (p['address_name']?.toString() ?? '');
                        _addSearchResultMarker(lat, lng, name, addr, isOpen: p == selectedPlace);
                      }

                      // move to selected place
                      final selectedLat = double.parse(selectedPlace['y'].toString());
                      final selectedLng = double.parse(selectedPlace['x'].toString());
                      _moveToLocation(selectedLat, selectedLng);
                      _showSearchPulse(selectedLat, selectedLng); // Trigger pulse effect
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${selectedPlace['place_name']}(으)로 이동합니다.'),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    } catch (e) {
                      debugPrint('[Ratip] Parse coordinates error: $e');
                    }
                  }
                });
              },
              child: Text(
                'Ratip 에서 검색',
                style: const TextStyle(
                  color: Color(0xFF5F6368),
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

  /// Left detail panel when a place is selected
  Widget _buildLeftDetailPanel() {
    if (_selectedPlaceDetails == null) return const SizedBox.shrink();
    
    final placeName = _selectedPlaceDetails!['place_name'] as String;
    final address = _selectedPlaceDetails!['road_address_name'] as String;
    final category = _selectedPlaceDetails!['category'] as String? ?? '';
    final phone = _selectedPlaceDetails!['phone'] as String? ?? '';
    final placeUrl = _selectedPlaceDetails!['placeUrl'] as String? ?? '';

    // Helper to get a relevant image keyword
    String getImgKeyword() {
      final name = placeName.toLowerCase();
      final cat = category.toLowerCase();
      
      if (cat.contains('카페') || name.contains('카페') || name.contains('cafe') || name.contains('커피')) return 'cafe,coffee';
      if (cat.contains('음식점') || cat.contains('식당') || name.contains('맛집') || name.contains('푸드')) return 'restaurant,food';
      if (cat.contains('병원')) return 'hospital,medical';
      if (cat.contains('약국')) return 'pharmacy';
      if (cat.contains('학교') || cat.contains('대학') || cat.contains('학원')) return 'school,university';
      if (cat.contains('은행')) return 'bank';
      if (cat.contains('편의점') || cat.contains('마트') || cat.contains('백화점')) return 'shop,store';
      if (cat.contains('공원') || cat.contains('산') || cat.contains('숲')) return 'park,nature';
      if (cat.contains('지하철') || cat.contains('역') || cat.contains('터미널')) return 'subway,station';
      if (cat.contains('숙박') || cat.contains('호텔') || cat.contains('모텔')) return 'hotel,room';
      if (cat.contains('주차장')) return 'parking,car';
      if (cat.contains('문화') || cat.contains('영화') || cat.contains('극장')) return 'culture,cinema';
      
      return 'building,city';
    }

    final imageUrl = 'https://loremflickr.com/400/300/${getImgKeyword()}';

    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Dynamic Header image
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F3F4),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
              image: DecorationImage(
                image: NetworkImage('$imageUrl?lock=${placeName.hashCode}'),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.topRight,
            padding: const EdgeInsets.all(8),
            child: Material(
              color: Colors.white.withOpacity(0.8),
              shape: const CircleBorder(),
              child: IconButton(
                icon: const Icon(Icons.close, size: 20, color: Color(0xFF3C4043)),
                onPressed: () {
                  setState(() {
                    _selectedPlaceDetails = null;
                  });
                },
                constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                padding: EdgeInsets.zero,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  placeName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3C4043),
                  ),
                ),
                if (category.isNotEmpty) ...[
                  const SizedBox(height: 4),
                  Text(
                    category,
                    style: const TextStyle(
                      fontSize: 13,
                      color: Color(0xFF4285F4),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                const SizedBox(height: 12),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.location_on, size: 16, color: Color(0xFF5F6368)),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        address,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF5F6368),
                          height: 1.3,
                        ),
                      ),
                    ),
                  ],
                ),
                if (phone.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.phone, size: 16, color: Color(0xFF5F6368)),
                      const SizedBox(width: 4),
                      Text(
                        phone,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF5F6368),
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 0,
                        ),
                        onPressed: () {
                          if (placeUrl.isNotEmpty) {
                            html.window.open(placeUrl, '_blank');
                          }
                        },
                        icon: const Icon(Icons.info_outline, size: 18),
                        label: const Text('카카오맵', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF3C4043),
                          side: const BorderSide(color: Color(0xFFE8EAED)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.bookmark_border, size: 18),
                        label: const Text('저장', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ],
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
          onTap: () => _moveToCurrentLocation(),
          isPrimary: true,
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
              _zoomButton(Icons.add, _zoomIn),
              Container(
                width: 28,
                height: 1,
                color: const Color(0xFFE0E0E0),
              ),
              _zoomButton(Icons.remove, _zoomOut),
            ],
          ),
        ),
      ],
    );
  }

  Widget _controlButton({
    required IconData icon,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isPrimary ? AppTheme.primaryColor : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Container(
            width: 52,
            height: 52,
            alignment: Alignment.center,
            child: Icon(
              icon,
              size: 24,
              color: isPrimary ? Colors.white : const Color(0xFF5F6368),
            ),
          ),
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
          _showMapFilterBottomSheet();
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

  void _showMapFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '지도 필터 설정',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF3C4043)),
              ),
              const SizedBox(height: 24),
              _filterOption('내 장소', '내가 기록한 장소만 봅니다.', true),
              const SizedBox(height: 16),
              _filterOption('친구 장소', '친구들이 기록한 장소도 함께 봅니다.', false),
              const SizedBox(height: 16),
              _filterOption('이벤트 장소', '현재 진행 중인 이벤트 장소를 표시합니다.', true),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () => Navigator.pop(context),
                  child: const Text('적용하기', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _filterOption(String title, String subtitle, bool isSelected) {
    return StatefulBuilder(
      builder: (context, setState) {
        return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF3C4043))),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(fontSize: 13, color: Color(0xFF5F6368))),
                ],
              ),
            ),
            Switch(
              value: isSelected,
              onChanged: (val) {
                setState(() {
                  isSelected = val;
                });
              },
              activeColor: AppTheme.primaryColor,
            ),
          ],
        );
      }
    );
  }
}
