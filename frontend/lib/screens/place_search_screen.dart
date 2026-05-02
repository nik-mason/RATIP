import 'package:flutter/material.dart';
import 'package:ratip/theme/app_theme.dart';

class PlaceSearchScreen extends StatefulWidget {
  const PlaceSearchScreen({super.key});

  @override
  State<PlaceSearchScreen> createState() => _PlaceSearchScreenState();
}

class _PlaceSearchScreenState extends State<PlaceSearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _dummyResults = [
    '서울역',
    '강남역',
    '홍대입구역',
    '광화문광장',
    '남산서울타워',
  ];
  List<String> _filteredResults = [];

  @override
  void initState() {
    super.initState();
    _filteredResults = _dummyResults;
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredResults = _dummyResults.where((place) {
        return place.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
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
      body: ListView.separated(
        itemCount: _filteredResults.length,
        separatorBuilder: (context, index) => const Divider(height: 1, color: Color(0xFFF1F3F4)),
        itemBuilder: (context, index) {
          final place = _filteredResults[index];
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
              place,
              style: const TextStyle(fontSize: 16, color: Color(0xFF3C4043), fontWeight: FontWeight.w500),
            ),
            subtitle: const Text('대한민국 서울특별시', style: TextStyle(fontSize: 13, color: Color(0xFF5F6368))),
            onTap: () {
              // TODO: Return selected location to map screen
              Navigator.pop(context, place);
            },
          );
        },
      ),
    );
  }
}
