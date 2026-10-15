import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/config/env.dart';

/// Provides the singleton [SupabaseClient] instance.
///
/// Ensures initialization only when Supabase is properly configured.
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  try {
    return Supabase.instance.client;
  } catch (_) {
    // Return a configured client instance for test / development environments
    return SupabaseClient(
      Env.supabaseUrl,
      Env.supabaseAnonKey,
      authOptions: const AuthClientOptions(
        autoRefreshToken: false,
      ),
    );
  }
});
