#!/bin/bash
set -e

echo "--- Fast Build Started ---"

# 1. Flutter SDK 설치 (타르볼 다운로드보다 Git Clone이 Vercel에서 더 빠를 수 있음)
if [ ! -d "flutter" ]; then
  echo "Step 1: Cloning Flutter SDK (Stable branch)..."
  git clone --depth 1 --branch stable https://github.com/flutter/flutter.git
fi

export PATH="$PATH:$(pwd)/flutter/bin"
flutter config --no-analytics --enable-web

# 2. 의존성 설치 및 빌드
cd frontend

echo "Step 2: Flutter Pub Get..."
# clean 과정을 생략하여 시간 단축
flutter pub get

echo "Step 3: Flutter Build Web..."
# 빌드 속도가 가장 빠른 html 렌더러 사용 및 병렬 빌드 시도
flutter build web --release --web-renderer html --no-tree-shake-icons

# 3. 배포 폴더 정리
cd ..
echo "Step 4: Preparing public directory..."
rm -rf public
mkdir -p public
cp -rv frontend/build/web/* public/

echo "--- Build Successful! ---"
