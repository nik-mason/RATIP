#!/bin/bash
set -ex

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

export PATH="$PATH:$(pwd)/flutter/bin"
flutter config --no-analytics

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
