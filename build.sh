#!/bin/bash
# 에러 발생 시 즉시 중단 및 모든 명령어 출력
set -ex

echo "--- Build Started ---"

# 1. Flutter SDK 설치
FLUTTER_VERSION="3.24.3"
FLUTTER_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"

if [ ! -d "flutter" ]; then
  echo "Step 1: Downloading Flutter SDK..."
  # -f 옵션을 추가하여 다운로드 실패 시 에러 발생시킴
  curl -fL -o flutter.tar.xz "$FLUTTER_URL" || { echo "Failed to download Flutter"; exit 1; }
  
  echo "Step 2: Extracting Flutter SDK..."
  tar -xf flutter.tar.xz || { echo "Failed to extract Flutter"; exit 1; }
  rm flutter.tar.xz
fi

echo "Step 3: Setting PATH and Config..."
export PATH="$PATH:$(pwd)/flutter/bin"
flutter config --no-analytics
flutter config --enable-web

# 2. 빌드 전 정리 및 의존성 설치
cd frontend
echo "Step 4: Flutter Clean..."
flutter clean

echo "Step 5: Flutter Pub Get..."
flutter pub get || { echo "Pub get failed"; exit 1; }

echo "Step 6: Flutter Build Web..."
# 메모리 절약을 위해 더 안전한 옵션 사용
flutter build web --release --web-renderer html --no-tree-shake-icons || { echo "Build failed"; exit 1; }

# 3. 배포
cd ..
echo "Step 7: Preparing public directory..."
rm -rf public
mkdir -p public
cp -rv frontend/build/web/* public/

echo "--- Build Successful! ---"
