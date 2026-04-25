#!/bin/bash
echo "Starting Vercel build script for Flutter..."
set -e

# 1. Flutter SDK 설치 (최소 깊이로 빠르게 클론)
if [ ! -d "flutter" ]; then
  echo "Cloning Flutter stable branch..."
  git clone https://github.com/flutter/flutter.git -b stable --depth 1
fi

export PATH="$PATH:$(pwd)/flutter/bin"
echo "Flutter version:"
flutter --version

flutter config --enable-web

# 2. Frontend 빌드
cd frontend
echo "Running flutter pub get..."
flutter pub get

echo "Building Flutter Web..."
flutter build web --release

# 3. 루트 public 폴더로 복사
cd ..
echo "Copying build output to public folder..."
rm -rf public
mkdir -p public
cp -rv frontend/build/web/* public/

echo "Build complete."
