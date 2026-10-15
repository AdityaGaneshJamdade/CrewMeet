import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment configuration reader.
///
/// Ensures all runtime environment variables are loaded securely
/// without hardcoded secrets in the codebase.
class Env {
  Env._();

  static const String _defaultSupabaseUrl = 'https://placeholder.supabase.co';
  static const String _defaultSupabaseAnonKey =
      'placeholder-anon-key-eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.e30.placeholder';

  /// Initializes dotenv. Safe to call multiple times or during tests.
  static Future<void> init({String fileName = '.env'}) async {
    try {
      await dotenv.load(fileName: fileName);
    } catch (_) {
      // In CI / test environments, .env may not be present on disk.
    }
  }

  static String get supabaseUrl =>
      dotenv.maybeGet('SUPABASE_URL') ?? _defaultSupabaseUrl;

  static String get supabaseAnonKey =>
      dotenv.maybeGet('SUPABASE_ANON_KEY') ?? _defaultSupabaseAnonKey;

  static String get liveKitUrl =>
      dotenv.maybeGet('LIVEKIT_URL') ?? 'wss://placeholder.livekit.cloud';

  static String get fcmVapidKey => dotenv.maybeGet('FCM_VAPID_KEY') ?? '';

  static String get environment =>
      dotenv.maybeGet('ENVIRONMENT') ?? 'development';

  static bool get isProduction => environment == 'production';
  static bool get isDevelopment => environment == 'development';
}
