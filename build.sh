#!/bin/bash
# Flutter SDK 설치 및 빌드 스크립트

echo "Starting Vercel build script for Flutter..."

if [ ! -d "flutter" ]; then
  echo "Cloning Flutter stable branch..."
  git clone https://github.com/flutter/flutter.git -b stable
else
  echo "Flutter directory already exists."
fi

export PATH="$PATH:`pwd`/flutter/bin"
flutter --version

flutter config --enable-web

cd frontend
echo "Running flutter pub get..."
flutter pub get

echo "Building Flutter Web..."
flutter build web --release

echo "Build complete."
