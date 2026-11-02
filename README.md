# CyberLab — Flutter Android starter

CyberLab is a Hinglish cybersecurity learning app starter with:
- Termux and Kali Linux lesson categories
- Searchable command/tutorial library
- Copy-to-clipboard for commands
- A deliberately restricted in-app practice terminal
- Cybersecurity learning roadmap

## Important execution model

The in-app terminal is a **simulator**, not a real shell. It only supports `help`, `pwd`, `ls`, `whoami`, `date`, `clear`, `echo <text>`, and `cyberlab-info`. It blocks arbitrary command execution.

For real Termux/Kali practice, learners can copy documented commands and run them in their own Termux/Kali environment, only on systems and networks they own or are explicitly authorized to test. This starter does not silently execute commands on the device.

## Requirements
- Flutter stable (Dart 3.3+)
- Android Studio or Android SDK
- Android device/emulator

## Run
```bash
flutter pub get
flutter run
```

## Build APK
```bash
flutter build apk --release
```
APK output:
`build/app/outputs/flutter-apk/app-release.apk`

## Create Android project scaffolding
If this folder does not already contain Android platform files, run:
```bash
flutter create --platforms=android .
flutter pub get
flutter run
```

## Project structure
- `lib/main.dart` — app UI, lesson data, simulator and navigation
- `pubspec.yaml` — Flutter dependencies

## Before public release
1. Expand and fact-check lesson content.
2. Add a privacy policy and clear educational-use terms.
3. Test on multiple Android versions and screen sizes.
4. Do not add unrestricted shell execution, background scanning, credential collection or remote-target attack automation.
5. Add progress persistence and offline content storage if needed.

## Phone-only APK build using GitHub Actions

1. Extract this ZIP on your Android phone.
2. Create a GitHub repository named `CyberLab`.
3. Upload the extracted project files and folders to the repository root (including the hidden `.github/workflows/build.yml` file).
4. Open the repository's **Actions** tab. If prompted, enable workflows.
5. Open **Build CyberLab APK** and tap **Run workflow** (or push to `main` to trigger it).
6. Wait for the workflow to finish successfully.
7. Open the completed workflow run, find **Artifacts**, and download `cyberlab-release-apk`.
8. Extract the artifact ZIP on your phone; install `app-release.apk`. Android may ask you to allow installs from that browser/file manager.

The APK is built on GitHub's cloud runner; no laptop is needed. GitHub account and internet access are required.
