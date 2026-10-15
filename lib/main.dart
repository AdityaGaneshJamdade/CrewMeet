import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'app.dart';
import 'core/config/env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables (.env)
  await Env.init();

  // Initialize Supabase if valid URL provided, or fallback for demo
  try {
    if (Env.supabaseUrl.startsWith('https://') &&
        !Env.supabaseUrl.contains('placeholder.supabase.co')) {
      await Supabase.initialize(
        url: Env.supabaseUrl,
        // ignore: deprecated_member_use
        anonKey: Env.supabaseAnonKey,
      );
    }
  } catch (e) {
    debugPrint('Supabase init skipped (running in offline/mock mode): $e');
  }

  runApp(
    const ProviderScope(
      child: ChaiChuApp(),
    ),
  );
}
