# template-flutter-app
https://api.codemagic.io/apps/6a90358a26b2ddf9fd1c04bc/6a90358a26b2ddf9fd1c04bb/status_badge.svg

[![Codemagic build status](https://api.codemagic.io/apps/6a90358a26b2ddf9fd1c04bc/6a90358a26b2ddf9fd1c04bb/status_badge.svg)](https://codemagic.io/app/6a90358a26b2ddf9fd1c04bc/6a90358a26b2ddf9fd1c04bb/latest_build)

A minimal **Hello World** Flutter app configured to build and run on both **Android** and **iOS**.

## Project layout

```
.
├── lib/
│   └── main.dart            # Flutter "Hello, World!" entry point
├── test/
│   └── widget_test.dart     # Basic widget test
├── android/                 # Android Gradle project (applicationId: com.example.hello_world)
├── ios/                     # iOS Xcode project (bundle id: com.example.helloWorld)
├── pubspec.yaml             # Dart/Flutter package manifest
└── analysis_options.yaml    # Lint rules
```

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) `>= 3.22` (Dart `^3.4`)
- Android: Android Studio + Android SDK, JDK 17
- iOS: Xcode 15+, CocoaPods, an Apple developer account for device deployment

## First-time setup

If you cloned this repo without a Flutter SDK on the original machine, some auto-generated platform files (Xcode `Runner.xcodeproj/project.pbxproj`, Gradle wrapper jar, CocoaPods manifest) may be missing. Regenerate them once:

```bash
flutter create . --platforms=ios,android --project-name hello_world
```

This will **not** overwrite the source files in `lib/`, `test/`, `pubspec.yaml`, or the platform configuration under `android/` and `ios/`. It only fills in any missing scaffolding.

## Run

```bash
flutter pub get
flutter run                       # auto-detects attached device or emulator
flutter run -d <device-id>        # pick a specific device
flutter run -d chrome             # web preview (optional)
```

## Build

### Android

```bash
flutter build apk --release       # APK at build/app/outputs/flutter-apk/
flutter build appbundle --release # AAB at build/app/outputs/bundle/release/
```

### iOS

```bash
cd ios && pod install && cd ..
flutter build ios --release --no-codesign   # unsigned .app for QA
flutter build ios --release                  # signed when a developer account is configured
```

## Test

```bash
flutter test
```

## Customize

- **App name / bundle id**: edit `android/app/build.gradle` (`applicationId`, label in `AndroidManifest.xml`) and `ios/Runner/Info.plist` (`CFBundleDisplayName`, `PRODUCT_BUNDLE_IDENTIFIER`).
- **Dart entry point**: `lib/main.dart`.
- **Dependencies**: `pubspec.yaml`, then `flutter pub get`.
