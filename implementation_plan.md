# 🛠️ Ratip 초정밀 구현 로드맵 (UI & 기능 통합형)

이 로드맵은 모든 화면(Screen)과 팝업(Popup)을 개별 작업 단위로 쪼갠 초정밀 가이드입니다. 각 단계마다 최적의 AI 모델이 배정되어 있습니다.

---

## 🏗️ Phase 1: 기반 시스템 & 초기 UI
1. **[EASY]** 프로젝트 초기화 (Flutter + GitHub)
   - 🤖 **AI**: Gemini 3 Flash
2. **[MEDIUM]** Supabase DB 스키마 설계 (profiles, reviews, achievements 등)
   - 🤖 **AI**: Claude Opus 4.6 (Thinking)
3. **[EASY]** 환경 변수(.env) 및 Vercel 배포 세팅
   - 🤖 **AI**: Gemini 3.1 Pro (Low)
4. **[EASY]** **[UI]** 스플래시 화면 (Splash Screen) 구현
   - 🤖 **AI**: Gemini 3 Flash

## 🔑 Phase 2: 인증 & 보안 시스템
5. **[MEDIUM]** **[UI]** 로그인 화면 & Supabase Auth 연동
   - 🤖 **AI**: Claude Sonnet 4.6 (Thinking)
6. **[MEDIUM]** **[UI]** 회원가입 화면 (닉네임, 이메일, 비번)
   - 🤖 **AI**: Claude Sonnet 4.6 (Thinking)
7. **[HARD]** **[UI]** 생체 인증(Face ID/지문) 연동 및 시스템 팝업 처리
   - 🤖 **AI**: Claude Sonnet 4.6 (Thinking)

## 🗺️ Phase 3: 지도 & 탐험 시스템
8. **[MEDIUM]** **[UI]** 메인 지도 화면 레이아웃 & 하단 네비게이션 바
   - 🤖 **AI**: Gemini 3 Flash
9. **[MEDIUM]** Kakao Map SDK 연동 및 기본 설정
   - 🤖 **AI**: Gemini 3.1 Pro (High)
10. **[EASY]** 실시간 내 위치 추적 마커 구현
    - 🤖 **AI**: Gemini 3.1 Pro (Low)
11. **[EASY]** **[UI]** GPS 권한 요청 안내 팝업
    - 🤖 **AI**: Gemini 3 Flash
12. **[MEDIUM]** **[UI]** 장소 검색바 및 검색 결과 리스트 화면
    - 🤖 **AI**: Claude Sonnet 4.6 (Thinking)
13. **[EASY]** **[UI]** 지도 필터 설정 팝업 (내 장소/친구 장소 등)
    - 🤖 **AI**: Gemini 3 Flash

## 📸 Phase 4: 리뷰 기록 시스템 (Core Loop)
14. **[MEDIUM]** 50m 거리 검증 로직 구현 (GPS 기반)
    - 🤖 **AI**: Claude Opus 4.6 (Thinking)
15. **[EASY]** **[UI]** "너무 멀어요!" 거리 경고 팝업
    - 🤖 **AI**: Gemini 3 Flash
16. **[MEDIUM]** **[UI]** 리뷰 작성 화면 (사진 촬영, 별점, 텍스트)
    - 🤖 **AI**: Claude Sonnet 4.6 (Thinking)
17. **[MEDIUM]** Supabase Storage 이미지 업로드 연동
    - 🤖 **AI**: Gemini 3.1 Pro (Low)
18. **[EASY]** **[UI]** "기록 완료!" 보상 확인 팝업
    - 🤖 **AI**: Gemini 3 Flash
19. **[MEDIUM]** **[UI]** 리뷰 상세 보기 (Bottom Sheet 스타일)
    - 🤖 **AI**: Claude Sonnet 4.6 (Thinking)
20. **[EASY]** **[UI]** 사진 전체 화면 보기 (ImageViewer)
    - 🤖 **AI**: Gemini 3 Flash

## 🏆 Phase 5: 게이미피케이션 시스템
21. **[MEDIUM]** Riverpod 기반 전역 상태 관리 (Gold, Rank)
    - 🤖 **AI**: Claude Sonnet 4.6 (Thinking)
22. **[MEDIUM]** **[UI]** 랭크 상점 화면 (승급 구매 목록)
    - 🤖 **AI**: Gemini 3 Flash
23. **[MEDIUM]** 승급 로직 및 골드 차감 시스템
    - 🤖 **AI**: Claude Sonnet 4.6 (Thinking)
24. **[HARD]** **[UI]** "랭크 업!" 축하 전체 화면 애니메이션 연출
    - 🤖 **AI**: Gemini 3 Flash
25. **[MEDIUM]** **[UI]** 50개 업적 목록 화면 (달성률 표시)
    - 🤖 **AI**: Claude Sonnet 4.6 (Thinking)
26. **[HARD]** 실시간 업적 추적 엔진 (백그라운드 로직)
    - 🤖 **AI**: Claude Opus 4.6 (Thinking)
27. **[EASY]** **[UI]** "업적 달성!" 상단 노티 팝업
    - 🤖 **AI**: Gemini 3 Flash

## 📅 Phase 6: 프로필 & 설정 & 이벤트
28. **[MEDIUM]** **[UI]** 내 프로필 및 개인 통계 화면
    - 🤖 **AI**: Gemini 3 Flash
29. **[EASY]** **[UI]** 환경 설정 화면 (알림, 탈퇴 등)
    - 🤖 **AI**: Gemini 3.1 Pro (Low)
30. **[HARD]** Supabase Edge Functions (이벤트 스케줄러)
    - 🤖 **AI**: Claude Opus 4.6 (Thinking)
31. **[EASY]** **[UI]** 메인 지도 위 이벤트 배너 UI
    - 🤖 **AI**: Gemini 3 Flash
32. **[MEDIUM]** **[UI]** 오늘의 이벤트 규칙 안내 팝업
    - 🤖 **AI**: Gemini 3 Flash
33. **[MEDIUM]** **[UI]** "황금 쥐 발견!" 이벤트 보상 팝업
    - 🤖 **AI**: Gemini 3 Flash

## 🚗 Phase 7: 네비게이션 & 폴리싱
34. **[HARD]** Kakao Map Navigation 연동 (또는 외부 앱 연결)
    - 🤖 **AI**: Gemini 3.1 Pro (High)
35. **[MEDIUM]** **[UI]** 주행 정보 오버레이 (시간, 거리 표시)
    - 🤖 **AI**: Gemini 3 Flash
36. **[EASY]** **[UI]** 네비게이션 종료 확인 팝업
    - 🤖 **AI**: Gemini 3.1 Pro (Low)

---
*모든 페이지와 팝업이 개별 작업으로 분리되었습니다.* 🚀
