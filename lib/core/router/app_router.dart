import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/home_shell/presentation/screens/home_shell_screen.dart';
import '../../shared/providers/auth_state_provider.dart';
import 'route_names.dart';

/// Notifier wrapper to trigger GoRouter refresh on Riverpod state updates.
class _RouterRefreshNotifier extends ChangeNotifier {
  _RouterRefreshNotifier(Ref ref) {
    ref.listen<AuthStateModel>(authStateProvider, (_, __) {
      notifyListeners();
    });
  }
}

final routerRefreshNotifierProvider = Provider<_RouterRefreshNotifier>((ref) {
  return _RouterRefreshNotifier(ref);
});

/// GoRouter provider with reactive authentication guard.
final appRouterProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = ref.watch(routerRefreshNotifierProvider);

  return GoRouter(
    initialLocation: AppRoutes.login,
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);
      final isLoggingIn = state.matchedLocation == AppRoutes.login;

      // Unauthenticated users are redirected to login
      if (!authState.isAuthenticated) {
        return isLoggingIn ? null : AppRoutes.login;
      }

      // Authenticated users trying to access login are redirected to home
      if (isLoggingIn) {
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeShellScreen(),
      ),
    ],
  );
});
