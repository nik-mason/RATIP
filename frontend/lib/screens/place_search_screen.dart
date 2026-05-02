import 'dart:async';
import 'dart:js' as js;
import 'package:flutter/material.dart';
import 'package:ratip/theme/app_theme.dart';

class PlaceSearchScreen extends StatefulWidget {
  const PlaceSearchScreen({super.key});

  @override
  State<PlaceSearchScreen> createState() => _PlaceSearchScreenState();
}

class _PlaceSearchScreenState extends State<PlaceSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  Timer? _debounce;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _performSearch(_searchController.text);
    });
  }

  void _performSearch(String query) {
    if (query.trim().isEmpty) {
      setState(() {
        _searchResults = [];
        _isLoading = false;
      });
      return;
    }

    setState(() { _isLoading = true; });

    try {
      final kakao = js.context['kakao'];
      if (kakao == null || 
          kakao['maps'] == null || 
          kakao['maps']['services'] == null || 
          kakao['maps']['services']['Places'] == null) {
        debugPrint('[Ratip] Kakao Maps Services library not loaded');
        setState(() { _isLoading = false; });
        return;
      }

      final ps = js.JsObject(kakao['maps']['services']['Places'] as js.JsFunction);
      
      ps.callMethod('keywordSearch', [
        query,
        js.allowInterop((result, status, pagination) {
          if (status == 'OK') {
            final List<dynamic> list = result as List<dynamic>;
            setState(() {
              _searchResults = list.map((item) {
                final jsItem = item as js.JsObject;
                return {
                  'place_name': jsItem['place_name'],
                  'address_name': jsItem['address_name'],
                  'road_address_name': jsItem['road_address_name'],
                  'x': jsItem['x'],
                  'y': jsItem['y'],
                };
              }).toList();
              _isLoading = false;
            });
          } else {
            setState(() {
              _searchResults = [];
              _isLoading = false;
            });
          }
        })
      ]);
    } catch (e) {
      debugPrint('[Ratip] Search error: $e');
      setState(() { _isLoading = false; });
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF3C4043)),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: InputDecoration(
            hintText: '장소, 주소 검색',
            hintStyle: const TextStyle(color: Color(0xFF9AA0A6)),
            border: InputBorder.none,
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear, color: Color(0xFF5F6368)),
                    onPressed: () {
                      _searchController.clear();
                    },
                  )
                : null,
          ),
          style: const TextStyle(color: Color(0xFF3C4043), fontSize: 16),
        ),
      ),
      body: Column(
        children: [
          if (_isLoading)
            const LinearProgressIndicator(
              backgroundColor: Colors.transparent,
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryColor),
            ),
          Expanded(
            child: _searchResults.isEmpty && !_isLoading
                ? _buildEmptyState()
                : ListView.separated(
                    itemCount: _searchResults.length,
                    separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF1F3F4)),
                    itemBuilder: (context, index) {
                      final place = _searchResults[index];
                      return ListTile(
                        leading: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F3F4),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.location_on, color: Color(0xFF5F6368), size: 20),
                        ),
                        title: Text(
                          place['place_name'] ?? '',
                          style: const TextStyle(fontSize: 16, color: Color(0xFF3C4043), fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          place['road_address_name']?.isNotEmpty == true 
                              ? place['road_address_name'] 
                              : (place['address_name'] ?? ''),
                          style: const TextStyle(fontSize: 13, color: Color(0xFF5F6368)),
                        ),
                        onTap: () {
                          Navigator.pop(context, place);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            _searchController.text.isEmpty ? '검색어를 입력해주세요' : '검색 결과가 없습니다',
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
        ],
      ),
    );
  }
}
