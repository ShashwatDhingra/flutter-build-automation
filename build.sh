#!/bin/bash

# Load API key from environment variable
API_KEY=${LOADLY_API_KEY}

ANDROID_PATH="build/app/outputs/flutter-apk/app-release.apk"
IOS_PATH="build/ios/ipa/*.ipa"

PLATFORM=""

# -------- Parse Argument --------
if [ "$1" == "--a" ]; then
  PLATFORM="android"
elif [ "$1" == "--i" ]; then
  PLATFORM="ios"
else
  echo "Usage:"
  echo "./build.sh --a   # Android"
  echo "./build.sh --i   # iOS"
  exit 1
fi

# -------- Validate API KEY --------
if [ -z "$API_KEY" ]; then
  echo "❌ LOADLY_API_KEY not set"
  echo "Run: export LOADLY_API_KEY=your_api_key"
  exit 1
fi

# -------- Build Section --------
if [ "$PLATFORM" == "android" ]; then

  echo "📦 Building Android APK..."
  flutter build apk --release

  FILE_PATH=$ANDROID_PATH

elif [ "$PLATFORM" == "ios" ]; then

  echo "🍏 Building iOS IPA..."

  flutter build ipa \
  --release \
  --export-options-plist=ios/ExportOptions.plist

  FILE_PATH=$(ls $IOS_PATH 2>/dev/null | head -n 1)

  if [ -z "$FILE_PATH" ]; then
    echo "❌ IPA not found"
    exit 1
  fi
fi

# -------- Upload Section --------
echo "🚀 Uploading to Loadly..."

RESPONSE=$(curl -s -X POST https://api.loadly.io/apiv2/app/upload \
  -F "_api_key=$API_KEY" \
  -F "file=@$FILE_PATH")

echo "📩 Response received..."

# -------- Extract URL --------
SHORT_URL=$(echo "$RESPONSE" | grep -o '"buildShortcutUrl":"[^"]*"' | cut -d':' -f2 | tr -d '"')

if [ -z "$SHORT_URL" ]; then
  echo "❌ Failed to extract URL"
  echo "$RESPONSE"
  exit 1
fi

FINAL_URL="https://loadly.io/$SHORT_URL"

echo "✅ Upload successful!"
echo "🔗 Install Link: $FINAL_URL"
