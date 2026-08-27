# AGENTS.md — Guidelines for agentic programming

This file defines how AI agents should work on this repository. Follow these rules unless the user explicitly overrides them.

## Project overview

- **Type**: Flutter app (Dart + Material 3).
- **App ID**: `hello_world` (Android `applicationId` / iOS bundle id: `com.example.hello_world` / `com.example.helloWorld`).
- **Targets**: Android, iOS.
- **Entry point**: `lib/main.dart`.
- **Package manifest**: `pubspec.yaml`.
- **Generated platform files** (Xcode `Runner.xcodeproj/project.pbxproj`, Gradle wrapper JAR, CocoaPods lockfile, etc.) may be missing on a fresh clone. Regenerate with `flutter create . --platforms=ios,android --project-name hello_world`.

## Required toolchain

- Flutter SDK `>= 3.22` (Dart `^3.4`).
- Android: JDK 17, Android SDK, Gradle 8.x.
- iOS: Xcode 15+, CocoaPods.
- Verify with `flutter doctor` before doing anything that requires a build.

## Build / lint / test commands

```bash
flutter pub get                 # install / refresh dependencies
flutter analyze                 # static analysis (uses analysis_options.yaml)
flutter test                    # run all tests in test/
flutter run                     # auto-detect device
flutter build apk --release     # Android APK
flutter build appbundle         # Android App Bundle
flutter build ios --release     # iOS (requires signing for device install)
```

Run `flutter analyze` and `flutter test` after any non-trivial change. Never commit code that fails `flutter analyze`.

## Code style — Dart / Flutter

- Follow the official [Effective Dart](https://dart.dev/effective-dart) and [Flutter style guide](https://docs.flutter.dev/development/tools/formatting).
- Use `dart format` (or rely on auto-format on save) before committing.
- Lint rules live in `analysis_options.yaml` (extends `flutter_lints`). Do not disable rules without a justification comment.
- Prefer `const` constructors and widgets where possible.
- Use `super.key` for widget constructors that take a key.
- Avoid `print` in production code; use `debugPrint` or a logger.
- Keep widgets small and composable; extract reusable components into `lib/widgets/`.
- Public APIs need Dartdoc comments. Internal helpers can have single-line `//` comments.

## File & directory conventions

```
lib/                 # Dart source
  main.dart          # entry point — keep small, delegate to feature folders
  features/<name>/   # optional feature module (screen + state + widgets)
  widgets/           # shared widgets
  services/          # platform / network / storage
  models/            # data classes (prefer freezed when available)
test/                # mirrors lib/ structure
android/             # native Android project — minimize edits; bump versions via pubspec
ios/                 # native iOS project — minimize edits; bump versions via pubspec
```

- Do **not** put business logic in `main.dart`.
- Never edit generated files (`*.g.dart`, `*.freezed.dart`, `ios/Flutter/Generated.xcconfig`, `ios/Flutter/flutter_export_environment.sh`).
- Never commit secrets. `*.jks`, `*.keystore`, `google-services.json`, `GoogleService-Info.plist`, `.env*` are git-ignored — keep it that way.

## Adding dependencies

1. Add to `pubspec.yaml` under `dependencies:` or `dev_dependencies:`.
2. Pin to a caret range (e.g. `^1.2.3`) — never `any`.
3. Run `flutter pub get`.
4. For native plugins (camera, maps, etc.) verify both `android/` and `ios/` setups still build.

## Versioning

- Bump `version: x.y.z+n` in `pubspec.yaml`. The `+n` part is `versionCode` (Android) and `CFBundleVersion` (iOS).
- Don't touch platform `build.gradle` version fields manually — they are driven by `flutter.versionCode` / `flutter.versionName`.

## Git workflow

- Branch names: `<type>/<short-kebab-description>` (e.g. `feat/login-screen`, `fix/ios-crash-on-startup`).
- Commit messages: imperative mood, ≤ 72 chars subject, blank line, optional body explaining *why*.
- One logical change per commit. Don't mix refactors with feature work.
- PRs (if used) need a description, screenshots for UI changes, and a `flutter analyze` + `flutter test` green status.

## What agents should and should not do

**Do:**
- Read this file, `README.md`, `pubspec.yaml`, and the relevant source files before changing anything.
- Search the codebase for existing helpers before adding new ones.
- Match the surrounding code style (imports, naming, widget patterns).
- Run `flutter analyze` after edits when the toolchain is available.
- Use parallel tool calls for independent reads.
- Ask before making destructive changes (deleting files, force pushes, branch deletions, dropping data).

**Do not:**
- Modify the project's git identity, force-push, skip hooks, or commit with `--no-verify`.
- Commit `build/`, `.dart_tool/`, `Pods/`, `*.iml`, `.idea/`, or any other ignored artifact (the `.gitignore` is already configured for these).
- Add comments that narrate the code. Comments should explain *why*, not *what*.
- Invent URLs, package names, or API endpoints. Verify against existing code or docs.
- Edit `ios/Runner.xcodeproj/project.pbxproj` by hand — regenerate with `flutter create` or Xcode.
- Disable linting or tests to make a red build pass. Fix the root cause.

## Common tasks

- **Add a screen**: create `lib/features/<name>/<name>_screen.dart` with a `StatelessWidget` if no state, or `StatefulWidget` with a dedicated `State` class. Add a corresponding test under `test/features/<name>/`.
- **Add a service**: put it under `lib/services/` and inject it; avoid globals.
- **Platform change**: prefer `flutter create . --platforms=<...>` to regenerate, then hand-tune only the diff.
- **Bump Flutter / Dart**: update `pubspec.yaml` `environment:` constraints, then run `flutter pub get` and `flutter analyze`.
