import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ratip/screens/login_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final ScrollController _scrollController = ScrollController();
  
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.6),
        elevation: 0,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),
        ),
        title: Row(
          children: [
            const Icon(Icons.location_on, color: Color(0xFF3F3BF0)),
            const SizedBox(width: 8),
            Text(
              'Ratip',
              style: const TextStyle(
                color: Color(0xFF3F3BF0),
                fontWeight: FontWeight.w900,
                fontSize: 22,
                letterSpacing: -0.5,
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: const Text('Log In', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            _buildHeroSection(context),
            const SizedBox(height: 80),
            _buildIntroSection(),
            const SizedBox(height: 60),
            _buildFeaturesSection(context),
            const SizedBox(height: 80),
            _buildTechStackSection(),
            const SizedBox(height: 80),
            _buildGrandMasterSection(),
            _buildCtaSection(context),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Stack(
      children: [
        // Background Gradient
        Container(
          width: double.infinity,
          height: 800,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFEEF0FF), Color(0xFFD8DAFE)],
            ),
          ),
        ),
        // Glow effects
        Positioned(
          top: -100,
          left: -100,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF8C80F8).withOpacity(0.4),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
              child: Container(),
            ),
          ),
        ),
        // Content
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white.withOpacity(0.8)),
                  ),
                  child: const Text(
                    '✦ PREMIUM LOCATION DISCOVERY',
                    style: TextStyle(
                      color: Color(0xFF3F3BF0),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                const Text(
                  '나만의 지도를 그리는\n진실한 여정',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 42,
                    height: 1.2,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFF1E1E24),
                    letterSpacing: -1,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Ratip은 \'남들이 좋다는 곳\'이 아니라\n\'내가 가본 곳, 내가 좋아할 곳\'에 집중하는\n혁신적인 개인화 위치 기록 플랫폼입니다.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.6,
                    color: Color(0xFF6B7280),
                  ),
                ),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3F3BF0),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 10,
                        shadowColor: const Color(0xFF3F3BF0).withOpacity(0.5),
                      ),
                      child: const Row(
                        children: [
                          Text('Log In', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 20),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60),
                // Mockup Image representation
                Container(
                  width: 280,
                  height: 550,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(40),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 30,
                        offset: const Offset(0, 15),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            'assets/images/screen.png', // User must ensure asset is registered in pubspec.yaml
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: const Color(0xFF1A1A2E),
                              child: const Center(
                                child: Text('Map UI', style: TextStyle(color: Colors.white54)),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          width: 120,
                          height: 25,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(15),
                              bottomRight: Radius.circular(15),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIntroSection() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          Text(
            '어디서나 경험할 수 없는 Ratip만의 가치',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF3F3BF0),
            ),
          ),
          SizedBox(height: 12),
          Text(
            '우리는 단순한 기록을 넘어,\n당신의 삶이 하나의 지도가 되는 과정을 함께합니다.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              height: 1.5,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E1E24),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          _buildGlassFeatureCard(
            icon: Icons.shield_outlined,
            title: '진실한 기록',
            description: '[인증 반경: 50m]\n반드시 해당 장소 반경 50m 이내에 있어야만 리뷰를 작성할 수 있습니다. 허위 기록 없는 투명한 위치 데이터를 수집합니다.',
          ),
          const SizedBox(height: 24),
          _buildSolidFeatureCard(
            icon: Icons.lock_outline,
            title: '나만의 기준',
            description: 'Privacy by Default.\n모든 기록은 \'나만 보기\'가 기본입니다. 타인의 시선에서 벗어나 오직 나만을 위한 지도를 그려보세요.',
            gradient: const LinearGradient(
              colors: [Color(0xFF3F3BF0), Color(0xFF8C80F8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            textColor: Colors.white,
          ),
          const SizedBox(height: 24),
          _buildGlassFeatureCard(
            icon: Icons.trending_up,
            title: '성장의 재미',
            description: '업적 달성을 통해 골드를 획득하고, 30단계의 RPG 랭크를 올려보세요. 50개 이상의 독특한 업적이 당신을 기다립니다.',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    _buildRankBadge('🌱 비기너'),
                    const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
                    _buildRankBadge('👟 트래블러'),
                    const Icon(Icons.chevron_right, size: 16, color: Colors.grey),
                    _buildRankBadge('👑 마스터'),
                  ],
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('🇰🇷 전국 일주', style: TextStyle(fontWeight: FontWeight.bold)), Text('1,000G', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold))],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text('🌏 지구 한 바퀴', style: TextStyle(fontWeight: FontWeight.bold)), Text('5,000G', style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold))],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSolidFeatureCard(
            icon: Icons.event,
            title: '축제의 연속',
            description: '매월 1일과 15일, 24시간 한정 특별 이벤트가 열립니다. 한정판 아이템과 골드를 획득할 기회를 놓치지 마세요.',
            gradient: const LinearGradient(
              colors: [Color(0xFFFF8A65), Color(0xFFFF5252)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            textColor: Colors.white,
            child: Column(
              children: [
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Column(
                    children: [
                      Text('1 & 15', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white)),
                      Text('NEXT EVENT', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white70, letterSpacing: 2)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRankBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFF3F3BF0).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF3F3BF0),
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildGlassFeatureCard({required IconData icon, required String title, required String description, Widget? child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.8)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1F2687).withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF0FF),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, color: const Color(0xFF3F3BF0), size: 28),
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E1E24)),
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: const TextStyle(fontSize: 15, height: 1.6, color: Color(0xFF6B7280)),
              ),
              if (child != null) child,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSolidFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required Gradient gradient,
    required Color textColor,
    Widget? child,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: gradient,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: gradient.colors.first.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: textColor, size: 28),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(fontSize: 15, height: 1.6, color: textColor.withOpacity(0.9)),
          ),
          if (child != null) child,
        ],
      ),
    );
  }

  Widget _buildTechStackSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const Text(
            'RELIABLE TECHNOLOGY',
            style: TextStyle(
              color: Color(0xFF3F3BF0),
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '압도적인 기술력의 집약',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1E1E24),
            ),
          ),
          const SizedBox(height: 32),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.9,
            children: [
              _buildTechCard(Icons.smartphone, 'Flutter', '멀티플랫폼\n지원 앱', Colors.blue),
              _buildTechCard(Icons.storage, 'Supabase', '빠르고 안전한\n백엔드', Colors.green),
              _buildTechCard(Icons.map, 'Map SDK', '정확한 위치\n기반 서비스', Colors.purple),
              _buildTechCard(Icons.fingerprint, 'Biometrics', '생체 인식 기반\n보안 인증', Colors.grey.shade800),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTechCard(IconData icon, String title, String desc, Color iconColor) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 36, color: iconColor),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Text(desc, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildGrandMasterSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFAFAFA), Color(0xFFEEF0FF)],
        ),
      ),
      child: Column(
        children: [
          const Icon(Icons.workspace_premium, size: 64, color: Color(0xFF3F3BF0)),
          const SizedBox(height: 24),
          const Text(
            '올 업적 달성, Grand Master',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Color(0xFF1E1E24)),
          ),
          const SizedBox(height: 16),
          const Text(
            '모든 여정을 마친 자에게 주어지는 최고의 영예.\n\'라팁의 신\' 칭호와 전용 골드 테마, 무제한 광고 제거 혜택을 누리세요.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, height: 1.6, color: Color(0xFF6B7280)),
          ),
        ],
      ),
    );
  }

  Widget _buildCtaSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      color: const Color(0xFF3F3BF0),
      child: Column(
        children: [
          const Text(
            '지금 당신만의 지도를 그려보세요',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: Colors.white),
          ),
          const SizedBox(height: 16),
          const Text(
            'Ratip은 단순한 앱이 아닙니다.\n당신의 모든 여정을 하나의 작품으로 만들어줄 파트너입니다.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 15, height: 1.6, color: Colors.white70),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: const Color(0xFF3F3BF0),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text('Ratip 로그인', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white70),
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text('둘러보기 (Log In)', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      color: const Color(0xFF111111),
      child: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, color: Colors.white, size: 20),
              SizedBox(width: 8),
              Text('Ratip', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          SizedBox(height: 16),
          Text('© 2024 Ratip. All rights reserved.', style: TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }
}
