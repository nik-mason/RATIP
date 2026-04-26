#!/bin/bash
set -ex

# 1. Flutter SDK 설치
FLUTTER_VERSION="3.24.3"
if [ ! -d "flutter" ]; then
  curl -L -o flutter.tar.xz "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"
  tar -xf flutter.tar.xz
  rm flutter.tar.xz
fi

export PATH="$PATH:$(pwd)/flutter/bin"
flutter config --no-analytics
flutter config --enable-web

# 2. 빌드 전 정리 및 의존성 설치
cd frontend
echo "Cleaning Flutter project..."
flutter clean
rm -rf .dart_tool
rm -f pubspec.lock

echo "Getting dependencies..."
flutter pub get

echo "Building for Web..."
# --no-tree-shake-icons 를 빼서 표준 빌드로 시도 (가끔 이 옵션이 문제를 일으킴)
flutter build web --release --web-renderer html

# 3. 배포
cd ..
rm -rf public
mkdir -p public
cp -rv frontend/build/web/* public/

echo "Build complete!"
