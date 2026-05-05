import 'package:flutter/material.dart';
import 'package:ratip/screens/login_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> with TickerProviderStateMixin {
  late AnimationController _floatController;
  late AnimationController _entranceController;

  @override
  void initState() {
    super.initState();
    debugPrint("LandingScreen: initState started");
    
    _floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _floatController.repeat(reverse: true);

    _entranceController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _entranceController.forward();
    
    debugPrint("LandingScreen: initState finished");
  }

  @override
  void dispose() {
    _floatController.dispose();
    _entranceController.dispose();
    super.dispose();
  }

  void _showRanksPopup() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.8,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                '📈 전체 랭크 시스템',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E1E24)),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    _buildRankGroup('🌱 비기너', ['10G', '20G', '30G', '40G', '50G']),
                    _buildRankGroup('👟 트래블러', ['80G', '100G', '120G', '140G', '160G']),
                    _buildRankGroup('🧭 익스플로러', ['250G', '300G', '350G', '400G', '450G']),
                    _buildRankGroup('🏆 베테랑', ['600G', '700G', '800G', '900G', '1,000G']),
                    _buildRankGroup('👑 마스터', ['1,500G', '1,800G', '2,100G', '2,400G', '2,700G']),
                    _buildRankGroup('✨ 레전드', ['4,000G', '5,000G', '6,500G', '8,000G', '10,000G']),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRankGroup(String title, List<String> costs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF3F3BF0))),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(costs.length, (index) => Container(
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFEEF0FF),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text('Lv.${index + 1}', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey)),
                  const SizedBox(height: 4),
                  Text(costs[index], style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF3F3BF0))),
                ],
              ),
            )),
          ),
        ),
      ],
    );
  }

  void _showAchievementsPopup() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.85,
        maxChildSize: 0.95,
        minChildSize: 0.6,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(
            color: Color(0xFF1A1A2E),
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                '🏅 라팁 업적 리스트',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    _buildAchievementTile('라팁과의 첫 만남', '첫 로그인 성공', '5G'),
                    _buildAchievementTile('동네 산책', '누적 300m 달성', '5G'),
                    _buildAchievementTile('전국 일주', '17개 시/도 방문', '1,000G', isSpecial: true),
                    _buildAchievementTile('지구 한 바퀴', '누적 40,000km 달성', '5,000G', isSpecial: true),
                    _buildAchievementTile('라팁 마스터', '누적 리뷰 200개 달성', '3,000G', isSpecial: true),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAchievementTile(String title, String condition, String reward, {bool isSpecial = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSpecial ? const Color(0xFF3F3BF0).withOpacity(0.3) : Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(isSpecial ? Icons.star : Icons.check, color: isSpecial ? Colors.orange : Colors.white, size: 20),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                Text(condition, style: const TextStyle(color: Colors.white54, fontSize: 13)),
              ],
            ),
          ),
          Text(reward, style: TextStyle(color: isSpecial ? Colors.orange : const Color(0xFF3F3BF0), fontWeight: FontWeight.w900, fontSize: 16)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("LandingScreen: build started");
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.location_on, color: Color(0xFF3F3BF0)),
            SizedBox(width: 8),
            Text(
              'Ratip',
              style: TextStyle(
                color: Color(0xFF3F3BF0),
                fontWeight: FontWeight.w900,
                fontSize: 22,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8, bottom: 8),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3F3BF0),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text('Log In'),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildHero(context),
            const SizedBox(height: 80),
            _buildSection('성장의 재미', '업적과 랭크를 통한 즐거운 탐험', 
              child: Row(
                children: [
                  Expanded(child: _buildButton('랭크 보기', _showRanksPopup, isOrange: false)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildButton('업적 보기', _showAchievementsPopup, isOrange: true)),
                ],
              )
            ),
            const SizedBox(height: 80),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHero(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFEEF0FF), Color(0xFFD8DAFE)],
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 120),
      child: Column(
        children: [
          FadeTransition(
            opacity: _entranceController,
            child: const Text(
              '나만의 지도를 그리는\n진실한 여정',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 42, fontWeight: FontWeight.w900, color: Color(0xFF1E1E24)),
            ),
          ),
          const SizedBox(height: 40),
          AnimatedBuilder(
            animation: _floatController,
            builder: (context, child) => Transform.translate(
              offset: Offset(0, 20 * _floatController.value - 10),
              child: child,
            ),
            child: Container(
              width: 280,
              height: 500,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 30, offset: const Offset(0, 15))],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.network(
                  'https://lxpfgfufzybqitqzndnb.supabase.co/storage/v1/object/public/assets/screen.png',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFF1A1A2E),
                    child: const Center(child: Icon(Icons.map, color: Colors.white30, size: 48)),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String desc, {required Widget child}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(desc, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 20),
          child,
        ],
      ),
    );
  }

  Widget _buildButton(String text, VoidCallback onPressed, {required bool isOrange}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isOrange ? Colors.orange.withOpacity(0.1) : const Color(0xFF3F3BF0).withOpacity(0.1),
        foregroundColor: isOrange ? Colors.orange : const Color(0xFF3F3BF0),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Text(text),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      color: const Color(0xFF0F0F1A),
      child: const Center(child: Text('© 2024 Ratip', style: TextStyle(color: Colors.white30))),
    );
  }
}
