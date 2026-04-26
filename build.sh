#!/bin/bash
set -ex

# Git 보안 경고 해결
git config --global --add safe.directory "*"

echo "--- System Info ---"
pwd
ls -la

# 1. Flutter SDK 다운로드 및 설치 (3.24.3 버전 사용)
FLUTTER_VERSION="3.24.3"
if [ ! -d "flutter" ]; then
  echo "Downloading Flutter SDK ${FLUTTER_VERSION}..."
  curl -L -o flutter.tar.xz "https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_${FLUTTER_VERSION}-stable.tar.xz"
  echo "Extracting Flutter SDK..."
  tar -xf flutter.tar.xz
  rm flutter.tar.xz
fi

export PATH="$PATH:$(pwd)/flutter/bin"
flutter config --no-analytics
flutter config --enable-web

# 2. 의존성 설치 및 빌드
cd frontend
echo "Flutter Pub Get..."
flutter pub get

echo "Flutter Build Web (HTML renderer for better compatibility)..."
# canvaskit 대신 html 렌더러를 사용하여 빌드 부하를 줄임
flutter build web --release --web-renderer html --no-tree-shake-icons

# 3. 배포 폴더 정리
cd ..
echo "Cleaning and copying to public..."
rm -rf public
mkdir -p public
cp -rv frontend/build/web/* public/

echo "Build successful!"
ls -la public
