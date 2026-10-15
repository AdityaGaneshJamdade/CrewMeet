import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'supabase_provider.dart';

/// State of current authentication.
class AuthStateModel {
  const AuthStateModel({
    required this.isAuthenticated,
    this.userId,
    this.email,
  });

  final bool isAuthenticated;
  final String? userId;
  final String? email;

  factory AuthStateModel.unauthenticated() =>
      const AuthStateModel(isAuthenticated: false);

  factory AuthStateModel.authenticated({
    required String userId,
    String? email,
  }) =>
      AuthStateModel(
        isAuthenticated: true,
        userId: userId,
        email: email,
      );
}

/// Authentication state notifier used by GoRouter for route redirection.
class AuthStateNotifier extends StateNotifier<AuthStateModel> {
  AuthStateNotifier(this._supabase) : super(AuthStateModel.unauthenticated()) {
    _init();
  }

  final SupabaseClient _supabase;

  void _init() {
    try {
      final session = _supabase.auth.currentSession;
      if (session != null) {
        state = AuthStateModel.authenticated(
          userId: session.user.id,
          email: session.user.email,
        );
      }
      _supabase.auth.onAuthStateChange.listen((data) {
        final session = data.session;
        if (session != null) {
          state = AuthStateModel.authenticated(
            userId: session.user.id,
            email: session.user.email,
          );
        } else {
          state = AuthStateModel.unauthenticated();
        }
      });
    } catch (_) {
      // Running in stub/offline mode
      state = AuthStateModel.unauthenticated();
    }
  }

  /// Manually set authenticated for demo/testing without active backend
  void setAuthenticated({required String userId, String? email}) {
    state = AuthStateModel.authenticated(userId: userId, email: email);
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (_) {}
    state = AuthStateModel.unauthenticated();
  }
}

final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, AuthStateModel>((ref) {
  final supabase = ref.watch(supabaseClientProvider);
  return AuthStateNotifier(supabase);
});
