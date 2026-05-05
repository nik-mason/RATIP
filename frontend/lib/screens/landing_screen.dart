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
    _floatController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    _entranceController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..forward();
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
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 24),
              const Text('📈 전체 랭크 시스템 (30단계)', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1E1E24))),
              const SizedBox(height: 8),
              const Text('획득한 골드로 랭크를 구매하여 당신의 위상을 높이세요.', style: TextStyle(color: Colors.grey)),
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
              decoration: BoxDecoration(color: const Color(0xFFEEF0FF), borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  Text('Lv.${index + 1}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey)),
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

  final List<Map<String, dynamic>> _allAchievements = [
    {'id': 1, 'title': '라팁과의 첫 만남', 'desc': '앱 설치 후 첫 로그인 성공', 'reward': '5G'},
    {'id': 2, 'title': '동네 산책', 'desc': '누적 이동 거리 300m 달성', 'reward': '5G'},
    {'id': 3, 'title': '지도 쳐다보기', 'desc': '지도 화면 10초 이상 유지', 'reward': '5G'},
    {'id': 4, 'title': '영토 확장', 'desc': '새로운 시/도 첫 방문 및 기록', 'reward': '20G'},
    {'id': 5, 'title': '전국 일주', 'desc': '대한민국 모든 시/도(17개) 방문', 'reward': '1,000G', 'special': true},
    {'id': 6, 'title': '나침반(동)', 'desc': '대한민국 동쪽 끝단 지역 방문', 'reward': '1,500G', 'special': true},
    {'id': 7, 'title': '나침반(서)', 'desc': '대한민국 서쪽 끝단 지역 방문', 'reward': '1,500G', 'special': true},
    {'id': 8, 'title': '나침반(남)', 'desc': '대한민국 남쪽 끝단 지역 방문', 'reward': '1,500G', 'special': true},
    {'id': 9, 'title': '나침반(북)', 'desc': '대한민국 북쪽 끝단 지역 방문', 'reward': '1,500G', 'special': true},
    {'id': 10, 'title': '지구 한 바퀴', 'desc': '누적 이동 거리 40,000km 달성', 'reward': '5,000G', 'special': true},
    {'id': 11, 'title': '산악인', 'desc': '고도 100m 이상의 고지대에서 기록', 'reward': '30G'},
    {'id': 12, 'title': '바다의 아들', 'desc': '해변 또는 해안가에서 기록', 'reward': '100G'},
    {'id': 13, 'title': '미식가 1', 'desc': '식당 카테고리 리뷰 1개 작성', 'reward': '5G'},
    {'id': 14, 'title': '미식가 2', 'desc': '식당 카테고리 리뷰 5개 작성', 'reward': '30G'},
    {'id': 15, 'title': '미식가 3', 'desc': '식당 카테고리 리뷰 10개 작성', 'reward': '100G'},
    {'id': 16, 'title': '카페인 중독 1', 'desc': '카페 카테고리 리뷰 1개 작성', 'reward': '5G'},
    {'id': 17, 'title': '카페인 중독 2', 'desc': '카페 카테고리 리뷰 5개 작성', 'reward': '100G'},
    {'id': 18, 'title': '심야의 식객', 'desc': '밤 11시 이후 식당 리뷰 작성', 'reward': '10G'},
    {'id': 19, 'title': '조식의 제왕', 'desc': '오전 7시 이전 식당 리뷰 작성', 'reward': '40G'},
    {'id': 20, 'title': '고독한 미식가', 'desc': '\'나만 보기\'로 식당 리뷰 5개 작성', 'reward': '80G'},
    {'id': 21, 'title': '열차의 낭만', 'desc': '기차역에서 위치 기록 및 리뷰', 'reward': '15G'},
    {'id': 22, 'title': '날개를 펴고', 'desc': '공항에서 위치 기록 및 리뷰', 'reward': '30G'},
    {'id': 23, 'title': '휴게소 매니아', 'desc': '고속도로 휴게소 2곳 기록', 'reward': '25G'},
    {'id': 24, 'title': '뚜벅이의 승리', 'desc': '오직 도보로만 1km 누적 이동', 'reward': '50G'},
    {'id': 25, 'title': '지식의 전당', 'desc': '도서관 또는 서점에서 기록', 'reward': '20G'},
    {'id': 26, 'title': '예술혼', 'desc': '미술관 또는 박물관에서 기록', 'reward': '20G'},
    {'id': 27, 'title': '운동 매니아', 'desc': '헬스장 또는 체육관에서 기록', 'reward': '20G'},
    {'id': 28, 'title': '동심의 세계', 'desc': '놀이공원 또는 동물원에서 기록', 'reward': '30G'},
    {'id': 29, 'title': '쇼핑 중독', 'desc': '백화점 또는 대형마트에서 기록', 'reward': '20G'},
    {'id': 30, 'title': '전통의 맛', 'desc': '전통시장에서 기록', 'reward': '20G'},
    {'id': 31, 'title': '첫 발자국', 'desc': '앱 설치 후 첫 번째 위치 기록', 'reward': '5G'},
    {'id': 32, 'title': '기록의 습관', 'desc': '3일 연속으로 위치 기록 성공', 'reward': '20G'},
    {'id': 33, 'title': '라팁과 한 달', 'desc': '10일 연속으로 위치 기록 성공', 'reward': '100G'},
    {'id': 34, 'title': '라팁의 고인물', 'desc': '100일 연속으로 위치 기록 성공', 'reward': '2,000G', 'special': true},
    {'id': 35, 'title': '사진 작가 1', 'desc': '사진이 포함된 리뷰 10개 작성', 'reward': '100G'},
    {'id': 36, 'title': '사진 작가 2', 'desc': '사진이 포함된 리뷰 30개 작성', 'reward': '500G'},
    {'id': 37, 'title': '정성 가득', 'desc': '300자 이상의 정성 리뷰 5개 작성', 'reward': '150G'},
    {'id': 38, 'title': '밤의 여왕', 'desc': '밤 10시 이후 기록 5개 달성', 'reward': '30G'},
    {'id': 39, 'title': '일요일의 산책', 'desc': '일요일에만 누적 3번 기록', 'reward': '20G'},
    {'id': 40, 'title': '비 오는 날의 추억', 'desc': '비 오는 날 리뷰 2개 작성', 'reward': '30G'},
    {'id': 41, 'title': '눈 오는 날의 낭만', 'desc': '눈 오는 날 리뷰 2개 작성', 'reward': '30G'},
    {'id': 42, 'title': '대중교통 매니아', 'desc': '버스 터미널 2곳 기록', 'reward': '25G'},
    {'id': 43, 'title': '빵순이/빵돌이', 'desc': '베이커리/빵집 5곳 기록', 'reward': '40G'},
    {'id': 44, 'title': '술 한 잔의 여유', 'desc': '주점/술집 3곳 기록', 'reward': '30G'},
    {'id': 45, 'title': '영화 광', 'desc': '영화관 2곳 기록', 'reward': '30G'},
    {'id': 46, 'title': '역사의 숨결', 'desc': '유적지/문화재 2곳 기록', 'reward': '40G'},
    {'id': 47, 'title': '호텔 스테이', 'desc': '호텔/숙박시설 2곳 기록', 'reward': '50G'},
    {'id': 48, 'title': '공원 한 바퀴', 'desc': '공원 3곳 기록', 'reward': '30G'},
    {'id': 49, 'title': '우정의 증표', 'desc': '공개 설정 리뷰 5개 작성', 'reward': '50G'},
    {'id': 50, 'title': '라팁 마스터', 'desc': '누적 전체 리뷰 200개 달성', 'reward': '3,000G', 'special': true},
  ];

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
          decoration: const BoxDecoration(color: Color(0xFF1A1A2E), borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(2)))),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('🏅 라팁 업적 리스트 (50개)', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(20)),
                    child: const Text('ALL CLEAR 보상: Grand Master', style: TextStyle(color: Colors.orange, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text('모든 이동과 기록이 당신의 커리어가 됩니다.', style: TextStyle(color: Colors.white54)),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: _allAchievements.length,
                  itemBuilder: (context, index) {
                    final ach = _allAchievements[index];
                    return _buildAchievementTile(
                      ach['title'] as String,
                      ach['desc'] as String,
                      ach['reward'] as String,
                      isSpecial: ach['special'] == true,
                      id: ach['id'] as int,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAchievementTile(String title, String condition, String reward, {bool isSpecial = false, int id = 0}) {
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
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(color: isSpecial ? Colors.orange : Colors.white10, shape: BoxShape.circle),
            child: Text('$id', style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
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
        backgroundColor: Colors.white.withOpacity(0.85),
        elevation: 0,
        title: const Row(
          children: [
            Icon(Icons.map_rounded, color: Color(0xFF3F3BF0)),
            SizedBox(width: 8),
            Text('Ratip', style: TextStyle(color: Color(0xFF3F3BF0), fontWeight: FontWeight.w900, fontSize: 24, letterSpacing: -1)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ElevatedButton(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3F3BF0),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              child: const Text('Log In', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            _buildHero(context),
            _buildPhilosophySection(),
            _buildCoreFeaturesGrid(context),
            _buildEventSection(),
            _buildTechSpecSection(),
            _buildGrandMasterSection(),
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
        gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFFF0F2FF), Color(0xFFE5E8FF)]),
      ),
      padding: const EdgeInsets.only(top: 140, bottom: 80, left: 24, right: 24),
      child: Column(
        children: [
          FadeTransition(
            opacity: _entranceController,
            child: const Column(
              children: [
                Text('✦ PERSONALIZED LOCATION RPG', style: TextStyle(color: Color(0xFF3F3BF0), fontWeight: FontWeight.bold, letterSpacing: 1.5, fontSize: 12)),
                SizedBox(height: 24),
                Text('세상에 단 하나뿐인\n나만의 지도를 완성하다', textAlign: TextAlign.center, style: TextStyle(fontSize: 44, fontWeight: FontWeight.w900, color: Color(0xFF1E1E24), height: 1.1, letterSpacing: -1.5)),
                SizedBox(height: 24),
                Text('Ratip은 당신의 모든 발자국을\n가치 있는 데이터와 재미있는 성취로 전환합니다.', textAlign: TextAlign.center, style: TextStyle(fontSize: 18, color: Color(0xFF6B7280), height: 1.6)),
              ],
            ),
          ),
          const SizedBox(height: 60),
          AnimatedBuilder(
            animation: _floatController,
            builder: (context, child) => Transform.translate(offset: Offset(0, 18 * _floatController.value - 9), child: child),
            child: Container(
              width: 300,
              height: 600,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(45),
                boxShadow: [BoxShadow(color: const Color(0xFF3F3BF0).withOpacity(0.2), blurRadius: 40, offset: const Offset(0, 20))],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(38),
                child: Image.network(
                  'https://images.unsplash.com/photo-1618044733300-9472054094ee?auto=format&fit=crop&w=600&q=80',
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(color: const Color(0xFF1A1A2E), child: const Center(child: Icon(Icons.location_searching, color: Colors.white24, size: 50))),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhilosophySection() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      child: Column(
        children: [
          const Text('OUR PHILOSOPHY', style: TextStyle(color: Color(0xFF3F3BF0), fontWeight: FontWeight.w900, letterSpacing: 2)),
          const SizedBox(height: 16),
          const Text('진실성, 주관성, 그리고 성취감', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Color(0xFF1E1E24))),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildPhilIcon(Icons.verified_user, '진실성'),
              _buildPhilIcon(Icons.person_pin, '주관성'),
              _buildPhilIcon(Icons.emoji_events, '성취감'),
              _buildPhilIcon(Icons.psychology, '지능형'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPhilIcon(IconData icon, String label) {
    return Column(
      children: [
        Container(padding: const EdgeInsets.all(16), decoration: BoxDecoration(color: const Color(0xFFF0F2FF), shape: BoxShape.circle), child: Icon(icon, color: const Color(0xFF3F3BF0))),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
      ],
    );
  }

  Widget _buildCoreFeaturesGrid(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          _buildDetailCard(
            icon: Icons.gps_fixed,
            title: '진실한 기록 (Verification)',
            desc: '반드시 장소 반경 50m 이내에 있어야 리뷰 작성이 가능합니다. 허위 기록 없는 투명한 위치 데이터를 수집합니다.',
            badge: '인증 반경 50m',
          ),
          const SizedBox(height: 24),
          _buildDetailCard(
            icon: Icons.lock_person,
            title: '나만의 기준 (Privacy)',
            desc: '모든 기록은 \'나만 보기\'가 기본값입니다. 타인의 평가가 아닌 오직 나의 경험이 최상단에 노출됩니다.',
            badge: 'Privacy Default',
            isDark: true,
          ),
          const SizedBox(height: 24),
          _buildDetailCard(
            icon: Icons.stars,
            title: '성장의 재미 (RPG System)',
            desc: '업적 달성 ➔ 골드 획득 ➔ 랭크 업그레이드! 총 30단계의 랭크와 50개의 독특한 업적이 당신을 기다립니다.',
            child: Column(
              children: [
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(child: _buildActionButton('전체 랭크 보기', _showRanksPopup)),
                    const SizedBox(width: 12),
                    Expanded(child: _buildActionButton('모든 업적 보기', _showAchievementsPopup, isAlt: true)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildDetailCard(
            icon: Icons.near_me,
            title: '지능형 네비게이션',
            desc: '실시간 경로 안내는 물론, 당신의 패턴을 분석하여 최적의 경로와 장소를 AI가 추천합니다.',
            badge: 'Naver Map SDK',
          ),
        ],
      ),
    );
  }

  Widget _buildDetailCard({required IconData icon, required String title, required String desc, String? badge, bool isDark = false, Widget? child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E24) : Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: const Color(0xFF3F3BF0), size: 36),
              if (badge != null) Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: const Color(0xFF3F3BF0).withOpacity(0.1), borderRadius: BorderRadius.circular(20)), child: Text(badge, style: const TextStyle(color: Color(0xFF3F3BF0), fontWeight: FontWeight.bold, fontSize: 11))),
            ],
          ),
          const SizedBox(height: 24),
          Text(title, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
          const SizedBox(height: 12),
          Text(desc, style: TextStyle(fontSize: 16, height: 1.5, color: isDark ? Colors.white70 : Colors.grey[600])),
          if (child != null) child,
        ],
      ),
    );
  }

  Widget _buildActionButton(String text, VoidCallback onPressed, {bool isAlt = false}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isAlt ? Colors.orange.withOpacity(0.1) : const Color(0xFF3F3BF0).withOpacity(0.1),
        foregroundColor: isAlt ? Colors.orange : const Color(0xFF3F3BF0),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildEventSection() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 80),
      padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 24),
      decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFFFF8A65), Color(0xFFFF5252)])),
      child: Column(
        children: [
          const Icon(Icons.celebration, color: Colors.white, size: 48),
          const SizedBox(height: 24),
          const Text('축제의 연속 (Regular Auto-Event)', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.white)),
          const SizedBox(height: 12),
          const Text('매월 1일과 15일, 24시간 한정 특별 이벤트가 활성화됩니다.', textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 40),
          _buildEventItem('💰 골드 2배 데이', '모든 보상 골드 2배 적용'),
          _buildEventItem('💸 승급 할인 데이', '모든 랭크 승급 비용 30% 할인'),
          _buildEventItem('🐭 숨바꼭질 데이', '랜덤 좌표에 \'황금 쥐\' 출현 (500G)'),
          _buildEventItem('🚶‍♂️ 뚜벅이 챌린지', '도보 이동 시 모든 보상 3배'),
        ],
      ),
    );
  }

  Widget _buildEventItem(String title, String desc) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white24)),
      child: Row(
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
          const Spacer(),
          Text(desc, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildTechSpecSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Column(
        children: [
          const Text('TECHNICAL SPECIFICATION', style: TextStyle(color: Color(0xFF3F3BF0), fontWeight: FontWeight.w900, letterSpacing: 2)),
          const SizedBox(height: 40),
          Row(
            children: [
              _buildTechSpecItem('Flutter', 'Cross-Platform'),
              _buildTechSpecItem('Riverpod', 'State Management'),
              _buildTechSpecItem('Supabase', 'Backend & Auth'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTechSpecItem(String name, String role) {
    return Expanded(
      child: Column(
        children: [
          Text(name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Color(0xFF1E1E24))),
          const SizedBox(height: 4),
          Text(role, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildGrandMasterSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 24),
      decoration: const BoxDecoration(color: Color(0xFF0F0F1A)),
      child: Column(
        children: [
          const Icon(Icons.workspace_premium, color: Colors.orange, size: 64),
          const SizedBox(height: 24),
          const Text('올 업적 달성: Grand Master', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white)),
          const SizedBox(height: 16),
          const Text('모든 여정을 마친 자에게 주어지는 최고의 영예', style: TextStyle(color: Colors.white54, fontSize: 18)),
          const SizedBox(height: 40),
          _buildRewardChip('\'라팁의 신\' 칭호'),
          _buildRewardChip('전용 골드 테마'),
          _buildRewardChip('무제한 광고 제거'),
          _buildRewardChip('5,000 Gold 즉시 지급'),
          const SizedBox(height: 60),
          ElevatedButton(
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen())),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: const Color(0xFF3F3BF0), padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40))),
            child: const Text('지금 여정을 시작하세요', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
          ),
        ],
      ),
    );
  }

  Widget _buildRewardChip(String text) {
    return Container(margin: const EdgeInsets.only(bottom: 8), padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12), decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(15)), child: Text(text, style: const TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)));
  }

  Widget _buildFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(40),
      color: const Color(0xFF05050A),
      child: const Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.map, color: Colors.white24), SizedBox(width: 8), Text('Ratip', style: TextStyle(color: Colors.white24, fontWeight: FontWeight.bold, fontSize: 20))]),
          SizedBox(height: 20),
          Text('© 2024 Ratip Project. Designed for your journey.', style: TextStyle(color: Colors.white10, fontSize: 12)),
        ],
      ),
    );
  }
}
