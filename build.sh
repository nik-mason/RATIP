#!/bin/bash
echo "Starting Vercel build script for Flutter..."

# 1. Flutter SDK 설치
if [ ! -d "flutter" ]; then
  echo "Cloning Flutter stable branch..."
  git clone https://github.com/flutter/flutter.git -b stable
fi

export PATH="$PATH:`pwd`/flutter/bin"
echo "Flutter version:"
flutter --version

flutter config --enable-web

# 2. Frontend 폴더로 이동 및 빌드
cd frontend
echo "Running flutter pub get..."
flutter pub get

echo "Building Flutter Web..."
flutter build web --release

# 3. 루트 디렉토리에 public 폴더 생성 및 결과물 복사
cd ..
echo "Copying build output to public folder..."
rm -rf public
mkdir public
cp -r frontend/build/web/* public/

echo "Build complete."
