#!/bin/bash
set -ex
echo "--- Environment Info ---"
pwd
whoami
df -h

# 1. Flutter SDK 다운로드 (속도 향상을 위해 curl 사용)
if [ ! -d "flutter" ]; then
  echo "Downloading Flutter SDK..."
  # 특정 안정 버전을 직접 다운로드하여 빌드 일관성 유지
  curl -O https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.19.6-stable.tar.xz
  echo "Extracting Flutter SDK..."
  tar xf flutter_linux_3.19.6-stable.tar.xz
  rm flutter_linux_3.19.6-stable.tar.xz
fi

export PATH="$PATH:$(pwd)/flutter/bin"
flutter config --no-analytics
flutter --version

# 2. Frontend 빌드
cd frontend
flutter pub get
flutter build web --release

# 3. 결과물 복사
cd ..
rm -rf public
mkdir -p public
cp -rv frontend/build/web/* public/

echo "Build completed successfully."
