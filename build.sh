#!/bin/bash
set -e

echo "--- Build Attempt with Standard Options ---"

# 1. Flutter SDK 설치
if [ ! -d "flutter" ]; then
  echo "Step 1: Cloning Flutter SDK..."
  git clone --depth 1 --branch stable https://github.com/flutter/flutter.git
fi

export PATH="$PATH:$(pwd)/flutter/bin"
# 처음 실행 시 도구 다운로드를 위해 프리레퀴짓 실행
flutter doctor -v

flutter config --no-analytics --enable-web

# 2. 의존성 설치 및 빌드
cd frontend

echo "Step 2: Flutter Pub Get..."
flutter pub get

echo "Step 3: Flutter Build Web..."
# 가장 표준적인 빌드 명령어로 변경 (옵션 최소화)
flutter build web --release --web-renderer html

# 3. 배포 폴더 정리
cd ..
echo "Step 4: Preparing public directory..."
rm -rf public
mkdir -p public
cp -rv frontend/build/web/* public/

echo "--- Build Successful! ---"
