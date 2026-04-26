#!/bin/bash
set -e

echo "--- Absolute Minimal Build ---"

# 1. Flutter SDK 설치 (특정 버전 태그로 고정)
if [ ! -d "flutter" ]; then
  echo "Step 1: Cloning Flutter 3.24.3..."
  git clone --depth 1 --branch 3.24.3 https://github.com/flutter/flutter.git
fi

export PATH="$PATH:$(pwd)/flutter/bin"
flutter config --no-analytics --enable-web

# 2. 의존성 및 자산 설정
cd frontend

# .env 파일이 없으면 빌드 에러가 나므로 예제 파일 복사
mkdir -p assets
if [ ! -f "assets/.env" ]; then
  echo "Step 2: Creating placeholder .env..."
  cp ../.env.example assets/.env
fi

echo "Step 3: Flutter Pub Get..."
flutter pub get

echo "Step 4: Flutter Build Web..."
# 가장 인자가 적고 안전한 릴리즈 빌드
flutter build web --release

# 3. 배포 폴더 정리
cd ..
echo "Step 5: Deploying to public..."
rm -rf public
mkdir -p public
cp -r frontend/build/web/* public/

echo "--- Build Successful! ---"
