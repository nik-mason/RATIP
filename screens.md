# 📱 Ratip 전체 화면 & 디자인 프롬프트 명세서

Ratip 앱의 모든 화면 리스트와 **Stitch / AI 디자인 툴**에 사용할 초정밀 디자인 프롬프트입니다.

---

## 🎨 디자인 시스템 가이드
- **핵심 스타일**: **Premium White Glassmorphism** (밝고 깨끗한 투명도 효과)
- **기본 배경**: 초경량 그레이와 화이트의 미세한 그라데이션 (`#F9FAFB` to `#FFFFFF`)
- **퍼스널 컬러 (Primary)**: **#0087ff**
- **포인트 컬러 (Accent)**: **#5f00ff**
- **공통 속성**: 
  - `Background Blur: 20px~40px`
  - `Border Radius: 24px`
  - `Border: 1px solid rgba(255, 255, 255, 0.4)`
  - `Shadow: Soft, floating shadows`

---

## 1. 🔑 인증 및 초기 진입
- **[S] 스플래시 화면**
  - **Prompt**: `Design a Flutter splash screen for a map app named 'Ratip'. Minimalist white background with a subtle animated logo of a stylized compass and a mouse. Use a soft glow effect. Premium, clean, and modern vibe.`
- **[S] 로그인 화면**
  - **Prompt**: `Design a premium login screen with white glassmorphism. Central card with blurred background, Indigo (#6366F1) primary button, and social login icons (Google, Apple) at the bottom. Typography should be bold and modern.`
- **[S] 회원가입 화면**
  - **Prompt**: `Design a user registration screen. Multiple input fields (Nickname, Email, Password) with soft frosted glass effect backgrounds. Progress indicator at the top using Indigo color. Floating 'Next' button.`
- **[P] 생체 인증 안내 팝업**
  - **Prompt**: `Design a system-style biometric auth popup. Semi-transparent white frosted glass card with a Face ID icon in Indigo. 'Use Biometrics' and 'Cancel' buttons with clean sans-serif typography.`

## 2. 🗺️ 지도 및 메인 탐험
- **[S] 메인 지도 화면**
  - **Prompt**: `Design a main map interface. The map fills the background. At the bottom, a floating glassmorphic navigation bar with icons for Map, List, Shop, and Profile. Floating action button for 'Record' in the center with Indigo glow.`
- **[S] 장소 검색 화면**
  - **Prompt**: `Design a search result list overlay. A top search bar with glassmorphism, and a list of cards below. Each card shows place name, category icon, and distance. High-end white theme with soft shadows.`
- **[P] 위치 권한 안내 팝업**
  - **Prompt**: `Design a location permission request popup. Illustration of a map pin, clear explanation text, and a prominent 'Allow' button in Indigo. White glassmorphism card style.`

## 3. 📸 리뷰 및 위치 기록
- **[S] 리뷰 작성 화면**
  - **Prompt**: `Design a review writing screen. Large image upload placeholder with dashed border, horizontal star rating widget, and a text input area with frosted glass effect. Primary action button 'Save Record' at the bottom.`
- **[P] 거리 경고 팝업**
  - **Prompt**: `Design an error popup for 'Distance Too Far'. A soft red warning icon, friendly but clear text, and a button to 'Try Again'. Glassmorphic card with subtle red tint in the border.`
- **[P] 보상 획득 팝업**
  - **Prompt**: `Design a celebration popup for 'Reward Earned'. Confetti animation, a large Gold icon in the center, and '+50 G' text in bold Indigo. Floating effect for the card.`
- **[B] 리뷰 상세 보기 (Bottom Sheet)**
  - **Prompt**: `Design a bottom sheet for place details. Rounded top corners, frosted glass background, place name in large bold type, and quick action buttons (Navigate, Save, Share). Slide-up animation feel.`

## 4. 🏆 게임화 및 보상
- **[S] 랭크 상점**
  - **Prompt**: `Design a gamified shop screen. Top section shows user's current Gold with Indigo background. Below, a list of Rank upgrade cards from Beginner to Legend. Each card has a unique badge icon and a price tag.`
- **[S] 업적 목록**
  - **Prompt**: `Design an achievements list screen. Grid of 50 achievement icons. Locked icons are greyed out, unlocked icons are vibrant. Progress bar at the top showing overall completion percentage.`
- **[P] 랭크 업 축하 (Fullscreen)**
  - **Prompt**: `Design a full-screen rank-up celebration. Exploding fireworks animation, a large gold crown icon, and 'CONGRATULATIONS! YOU ARE NOW A VETERAN' text in premium typography.`
- **[P] 업적 달성 노티 (Top)**
  - **Prompt**: `Design a top notification banner for 'Achievement Unlocked'. Slim glassmorphic bar that slides from the top, featuring an icon and short achievement name. Minimalist and non-intrusive.`

## 5. 📅 프로필 및 이벤트
- **[S] 내 프로필**
  - **Prompt**: `Design a profile screen. Large circular avatar with Indigo border, user stats (Distance, Reviews, Rank) displayed in a 3-column grid of glassmorphic cards. Clean and data-rich UI.`
- **[U] 이벤트 배너**
  - **Prompt**: `Design a small floating event banner for the map. A pill-shaped Indigo glassmorphic widget with 'TODAY'S EVENT' text and a countdown timer.`

## 6. 🚗 네비게이션
- **[U] 주행 오버레이**
  - **Prompt**: `Design a navigation HUD overlay. Top bar shows next turn instruction, bottom bar shows ETA and distance. Transparent glassmorphism that doesn't block the map view.`

---
**범례**: `[S]` = Full Screen, `[P]` = Popup/Dialog, `[B]` = Bottom Sheet, `[U]` = UI Overlay
