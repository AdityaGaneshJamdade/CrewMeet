import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nexcord/core/theme/app_theme.dart';
import 'package:nexcord/features/auth/presentation/screens/login_screen.dart';

void main() {
  testWidgets('LoginScreen displays Welcome to ChaiChu and branding',
      (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          theme: AppTheme.darkTheme,
          home: const LoginScreen(),
        ),
      ),
    );

    expect(find.text('Welcome to ChaiChu'), findsOneWidget);
    expect(find.text('EMAIL OR USERNAME'), findsOneWidget);
    expect(find.text('PASSWORD'), findsOneWidget);
    expect(find.text('Log In'), findsOneWidget);
    expect(find.text('Continue as Guest / Demo Mode'), findsOneWidget);
  });
}
