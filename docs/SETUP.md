# Setup & Development Guide

## Prerequisites
1. **Flutter SDK**: Flutter 3 (Dart 3)
2. **Supabase**: Local CLI or cloud Supabase project
3. **LiveKit**: LiveKit Cloud or self-hosted instance (for voice/video)
4. **Firebase**: Firebase project with FCM configured

## Quick Start
1. Clone the repository and navigate to the project root:
   ```bash
   cd c:\Downloads\Discord
   ```
2. Copy `.env.example` to `.env` and fill in your keys:
   ```bash
   cp .env.example .env
   ```
3. Install Flutter dependencies:
   ```bash
   flutter pub get
   ```
4. Run code generation (for Freezed and Riverpod):
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
5. Run the analyzer and verify zero warnings:
   ```bash
   flutter analyze
   ```
6. Run unit tests:
   ```bash
   flutter test
   ```
7. Launch the app on your preferred platform:
   ```bash
   flutter run -d chrome    # Web
   flutter run -d windows   # Windows Desktop
   flutter run -d android   # Android (emulator or device)
   ```
