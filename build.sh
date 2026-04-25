#!/bin/bash
set -ex

# Git 보안 경고 해결 (모든 경로 허용)
git config --global --add safe.directory "*"

echo "--- System Info ---"
pwd
ls -la

# 1. Flutter SDK 다운로드 및 설치
if [ ! -d "flutter" ]; then
  echo "Downloading Flutter SDK..."
  curl -L -o flutter.tar.xz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.19.6-stable.tar.xz
  echo "Extracting Flutter SDK..."
  tar -xf flutter.tar.xz
  rm flutter.tar.xz
fi

# 추출 후 한 번 더 설정 (혹시 모를 상황 대비)
git config --global --add safe.directory "$(pwd)/flutter"
git config --global --add safe.directory "$(pwd)"

export PATH="$PATH:$(pwd)/flutter/bin"
flutter config --no-analytics
flutter doctor -v

# 2. 의존성 설치 및 빌드
cd frontend
echo "Flutter Pub Get..."
flutter pub get

echo "Flutter Build Web..."
flutter build web --release

# 3. 배포 폴더 정리
cd ..
echo "Cleaning and copying to public..."
rm -rf public
mkdir -p public
cp -rv frontend/build/web/* public/

echo "Build successful!"
ls -la public
