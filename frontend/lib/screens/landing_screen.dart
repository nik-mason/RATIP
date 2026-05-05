import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ratip/screens/login_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _floatController;
  late AnimationController _entranceController;

  @override
  void initState() {
    super.initState();
    _floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _entranceController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _scrollController.dispose();
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
        builder: (_, controller) => Container(
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
                '📈 전체 랭크 시스템 (30단계)',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E1E24)),
              ),
              const SizedBox(height: 8),
              const Text('골드를 모아 당신의 랭크를 업그레이드하세요.', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  controller: controller,
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
        builder: (_, controller) => Container(
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
                '🏅 라팁 업적 리스트 (50개)',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 8),
              const Text('모든 이동과 기록이 당신의 커리어가 됩니다.', style: TextStyle(color: Colors.white54)),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    _buildAchievementTile('라팁과의 첫 만남', '첫 로그인 성공', '5G'),
                    _buildAchievementTile('동네 산책', '누적 300m 달성', '5G'),
                    _buildAchievementTile('전국 일주', '17개 시/도 방문', '1,000G', isSpecial: true),
                    _buildAchievementTile('지구 한 바퀴', '누적 40,000km 달성', '5,000G', isSpecial: true),
                    _buildAchievementTile('나침반(동/서/남/북)', '대한민국 끝단 방문', '1,500G/각'),
                    _buildAchievementTile('라팁의 고인물', '100일 연속 기록', '2,000G', isSpecial: true),
                    _buildAchievementTile('미식가 시리즈', '식당 리뷰 작성', '최대 100G'),
                    _buildAchievementTile('고독한 미식가', '나만 보기 리뷰 5개', '80G'),
                    _buildAchievementTile('조식의 제왕', '오전 7시 이전 기록', '40G'),
                    _buildAchievementTile('산악인 / 바다의 아들', '지형 기반 기록', '30~100G'),
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
        border: Border.all(color: isSpecial ? const Color(0xFF3F3BF0) : Colors.white10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isSpecial ? Colors.orange : Colors.white12,
              shape: BoxShape.circle,
            ),
            child: Icon(isSpecial ? Icons.star : Icons.check, color: Colors.white, size: 20),
          ),
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
        physics: const BouncingScrollPhysics(), // Smoother scrolling feel
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
          height: 850,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFFEEF0FF), Color(0xFFD8DAFE)],
            ),
          ),
        ),
        // Glow effects with initial entrance animation
        FadeTransition(
          opacity: _entranceController,
          child: Stack(
            children: [
              Positioned(
                top: -100,
                left: -100,
                child: Container(
                  width: 500,
                  height: 500,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF8C80F8).withOpacity(0.3),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
                    child: Container(),
                  ),
                ),
              ),
              Positioned(
                bottom: 200,
                right: -100,
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF3F3BF0).withOpacity(0.1),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 80, sigmaY: 80),
                    child: Container(),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Content
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                SlideTransition(
                  position: Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero).animate(CurvedAnimation(parent: _entranceController, curve: Curves.easeOutCubic)),
                  child: FadeTransition(
                    opacity: _entranceController,
                    child: Column(
                      children: [
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
                            fontSize: 48,
                            height: 1.1,
                            fontWeight: FontWeight.w900,
                            color: Color(0xFF1E1E24),
                            letterSpacing: -1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Ratip은 \'남들이 좋다는 곳\'이 아니라\n\'내가 가본 곳, 내가 좋아할 곳\'에 집중하는\n혁신적인 개인화 위치 기록 플랫폼입니다.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            height: 1.6,
                            color: Color(0xFF6B7280),
                          ),
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
                            backgroundColor: const Color(0xFF3F3BF0),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 15,
                            shadowColor: const Color(0xFF3F3BF0).withOpacity(0.6),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Log In', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                              SizedBox(width: 8),
                              Icon(Icons.arrow_forward, size: 22),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 60),
                // Mockup Image representation with Floating Animation
                AnimatedBuilder(
                  animation: _floatController,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(0, 15 * _floatController.value - 7.5),
                      child: child,
                    );
                  },
                  child: Container(
                    width: 300,
                    height: 600,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(45),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 40,
                          offset: const Offset(0, 20),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: Image.asset(
                              'assets/images/screen.png',
                              width: double.infinity,
                              height: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                color: const Color(0xFF1A1A2E),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.map, color: Colors.white30, size: 48),
                                      const SizedBox(height: 12),
                                      Text('Map UI', style: TextStyle(color: Colors.white.withOpacity(0.3), fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topCenter,
                          child: Container(
                            width: 140,
                            height: 30,
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: Color(0xFF3F3BF0),
              letterSpacing: -0.5,
            ),
          ),
          SizedBox(height: 16),
          Text(
            '우리는 단순한 기록을 넘어,\n당신의 삶이 하나의 지도가 되는 과정을 함께합니다.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              height: 1.5,
              fontWeight: FontWeight.w700,
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
          _HoverCard(
            child: _buildGlassFeatureCard(
              icon: Icons.shield_outlined,
              title: '진실한 기록',
              description: '[인증 반경: 50m]\n반드시 해당 장소 반경 50m 이내에 있어야만 리뷰를 작성할 수 있습니다. 허위 기록 없는 투명한 위치 데이터를 수집합니다.',
            ),
          ),
          const SizedBox(height: 24),
          _HoverCard(
            child: _buildSolidFeatureCard(
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
          ),
          const SizedBox(height: 24),
          _HoverCard(
            child: _buildGlassFeatureCard(
              icon: Icons.trending_up,
              title: '성장의 재미',
              description: '업적 달성을 통해 골드를 획득하고, 30단계의 RPG 랭크를 올려보세요. 50개 이상의 독특한 업적이 당신을 기다립니다.',
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _showRanksPopup,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3F3BF0).withOpacity(0.1),
                            foregroundColor: const Color(0xFF3F3BF0),
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('전체 랭크 보기', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _showAchievementsPopup,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange.withOpacity(0.1),
                            foregroundColor: Colors.orange,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          child: const Text('모든 업적 보기', style: TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          _HoverCard(
            child: _buildSolidFeatureCard(
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
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Column(
                      children: [
                        Text('1 & 15', style: TextStyle(fontSize: 40, fontWeight: FontWeight.w900, color: Colors.white)),
                        Text('NEXT EVENT', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white70, letterSpacing: 3)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRankBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFF3F3BF0).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF3F3BF0),
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildGlassFeatureCard({required IconData icon, required String title, required String description, Widget? child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(32),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: Colors.white.withOpacity(0.8)),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF1F2687).withOpacity(0.08),
                blurRadius: 25,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: const Color(0xFFEEF0FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(icon, color: const Color(0xFF3F3BF0), size: 32),
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1E1E24)),
              ),
              const SizedBox(height: 12),
              Text(
                description,
                style: const TextStyle(fontSize: 16, height: 1.6, color: Color(0xFF6B7280)),
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
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: gradient.colors.first.withOpacity(0.4),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: textColor, size: 32),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textColor),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: TextStyle(fontSize: 16, height: 1.6, color: textColor.withOpacity(0.9)),
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
              letterSpacing: 2.0,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            '압도적인 기술력의 집약',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1E1E24),
              letterSpacing: -1,
            ),
          ),
          const SizedBox(height: 40),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            childAspectRatio: 0.85,
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
    return _HoverCard(
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: Colors.white),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: iconColor),
            const SizedBox(height: 20),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 18, color: Color(0xFF1E1E24))),
            const SizedBox(height: 12),
            Text(desc, textAlign: TextAlign.center, style: const TextStyle(fontSize: 14, color: Colors.grey, height: 1.4)),
          ],
        ),
      ),
    );
  }

  Widget _buildGrandMasterSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFAFAFA), Color(0xFFEEF0FF)],
        ),
      ),
      child: Column(
        children: [
          _HoverCard(
            child: const Icon(Icons.workspace_premium, size: 80, color: Color(0xFF3F3BF0)),
          ),
          const SizedBox(height: 32),
          const Text(
            '올 업적 달성, Grand Master',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Color(0xFF1E1E24), letterSpacing: -0.5),
          ),
          const SizedBox(height: 20),
          const Text(
            '모든 여정을 마친 자에게 주어지는 최고의 영예.\n\'라팁의 신\' 칭호와 전용 골드 테마, 무제한 광고 제거 혜택을 누리세요.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, height: 1.7, color: Color(0xFF6B7280)),
          ),
        ],
      ),
    );
  }

  Widget _buildCtaSection(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      decoration: const BoxDecoration(
        color: Color(0xFF3F3BF0),
        image: DecorationImage(
          image: NetworkImage('https://www.transparenttextures.com/patterns/cubes.png'),
          opacity: 0.1,
          repeat: ImageRepeat.repeat,
        ),
      ),
      child: Column(
        children: [
          const Text(
            '지금 당신만의 지도를 그려보세요',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: -0.5),
          ),
          const SizedBox(height: 20),
          const Text(
            'Ratip은 단순한 앱이 아닙니다.\n당신의 모든 여정을 하나의 작품으로 만들어줄 파트너입니다.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 17, height: 1.6, color: Colors.white70),
          ),
          const SizedBox(height: 50),
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
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
              elevation: 20,
              shadowColor: Colors.black.withOpacity(0.5),
            ),
            child: const Text('Ratip 로그인', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
          ),
          const SizedBox(height: 20),
          OutlinedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white60, width: 2),
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            child: const Text('둘러보기 (Log In)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 40),
      color: const Color(0xFF0F0F1A),
      child: const Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, color: Colors.white, size: 24),
              SizedBox(width: 10),
              Text('Ratip', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900)),
            ],
          ),
          const SizedBox(height: 24),
          Text('© 2024 Ratip. All rights reserved.', style: TextStyle(color: Colors.white30, fontSize: 13)),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Terms', style: TextStyle(color: Colors.white30, fontSize: 12)),
              SizedBox(width: 16),
              Text('Privacy', style: TextStyle(color: Colors.white30, fontSize: 12)),
              SizedBox(width: 16),
              Text('Support', style: TextStyle(color: Colors.white30, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

class _HoverCard extends StatefulWidget {
  final Widget child;
  const _HoverCard({required this.child});

  @override
  State<_HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<_HoverCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: _isHovered ? (Matrix4.identity()..translate(0, -12, 0)..scale(1.02)) : Matrix4.identity(),
        child: widget.child,
      ),
    );
  }
}
