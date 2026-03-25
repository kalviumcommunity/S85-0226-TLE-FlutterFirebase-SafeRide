@echo off
REM SafeRide Flutter App Setup Script for Windows

echo 🚀 Setting up SafeRide Flutter App...

REM Check if Flutter is installed
flutter --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Flutter is not installed. Please install Flutter first.
    pause
    exit /b 1
)

echo ✅ Flutter found

REM Get Flutter dependencies
echo 📦 Installing dependencies...
flutter pub get

REM Check if google-services.json exists
if not exist "android\app\google-services.json" (
    echo ⚠️  google-services.json not found in android\app\
    echo 📝 Please download it from Firebase Console:
    echo    1. Go to https://console.firebase.google.com
    echo    2. Select project: saferide-48eab
    echo    3. Project Settings ^> Your Apps ^> Android
    echo    4. Download google-services.json
    echo    5. Place it in android\app\google-services.json
    echo.
    echo 🔄 Creating placeholder for testing...
    if not exist "android\app" mkdir android\app
    echo # Placeholder - Replace with actual google-services.json > android\app\google-services.json
)

REM Run Flutter doctor
echo 🔍 Checking Flutter environment...
flutter doctor

REM Analyze code
echo 📊 Analyzing code...
flutter analyze --no-fatal-infos

echo.
echo ✅ Setup complete!
echo.
echo 🎯 Next steps:
echo 1. Ensure google-services.json is properly configured
echo 2. Run: flutter run
echo 3. Test on Android device/emulator
echo.
echo 📚 For architecture details, see: README_ARCHITECTURE.md

pause
