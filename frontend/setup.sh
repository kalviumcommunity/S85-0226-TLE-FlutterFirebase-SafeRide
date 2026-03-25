#!/bin/bash

# SafeRide Flutter App Setup Script
echo "🚀 Setting up SafeRide Flutter App..."

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed. Please install Flutter first."
    exit 1
fi

echo "✅ Flutter found"

# Get Flutter dependencies
echo "📦 Installing dependencies..."
flutter pub get

# Check if google-services.json exists
if [ ! -f "android/app/google-services.json" ]; then
    echo "⚠️  google-services.json not found in android/app/"
    echo "📝 Please download it from Firebase Console:"
    echo "   1. Go to https://console.firebase.google.com"
    echo "   2. Select project: saferide-48eab"
    echo "   3. Project Settings → Your Apps → Android"
    echo "   4. Download google-services.json"
    echo "   5. Place it in android/app/google-services.json"
    echo ""
    echo "🔄 Creating placeholder for testing..."
    mkdir -p android/app
    echo "# Placeholder - Replace with actual google-services.json" > android/app/google-services.json
fi

# Run Flutter doctor
echo "🔍 Checking Flutter environment..."
flutter doctor

# Analyze code
echo "📊 Analyzing code..."
flutter analyze --no-fatal-infos

echo ""
echo "✅ Setup complete!"
echo ""
echo "🎯 Next steps:"
echo "1. Ensure google-services.json is properly configured"
echo "2. Run: flutter run"
echo "3. Test on Android device/emulator"
echo ""
echo "📚 For architecture details, see: README_ARCHITECTURE.md"
