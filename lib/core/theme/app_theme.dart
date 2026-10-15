import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Custom theme extension for ChaiChu specific UI components (rail, channels, etc.)
@immutable
class ChaiChuThemeExtension extends ThemeExtension<ChaiChuThemeExtension> {
  const ChaiChuThemeExtension({
    required this.railBackground,
    required this.channelListBackground,
    required this.activeItemColor,
    required this.hoverColor,
    required this.borderSubtle,
  });

  final Color railBackground;
  final Color channelListBackground;
  final Color activeItemColor;
  final Color hoverColor;
  final Color borderSubtle;

  @override
  ChaiChuThemeExtension copyWith({
    Color? railBackground,
    Color? channelListBackground,
    Color? activeItemColor,
    Color? hoverColor,
    Color? borderSubtle,
  }) {
    return ChaiChuThemeExtension(
      railBackground: railBackground ?? this.railBackground,
      channelListBackground:
          channelListBackground ?? this.channelListBackground,
      activeItemColor: activeItemColor ?? this.activeItemColor,
      hoverColor: hoverColor ?? this.hoverColor,
      borderSubtle: borderSubtle ?? this.borderSubtle,
    );
  }

  @override
  ChaiChuThemeExtension lerp(
    covariant ThemeExtension<ChaiChuThemeExtension>? other,
    double t,
  ) {
    if (other is! ChaiChuThemeExtension) return this;
    return ChaiChuThemeExtension(
      railBackground: Color.lerp(railBackground, other.railBackground, t)!,
      channelListBackground: Color.lerp(
        channelListBackground,
        other.channelListBackground,
        t,
      )!,
      activeItemColor: Color.lerp(activeItemColor, other.activeItemColor, t)!,
      hoverColor: Color.lerp(hoverColor, other.hoverColor, t)!,
      borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
    );
  }
}

/// Provides cohesive Dark (default) and Light ThemeData for ChaiChu.
class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    const colorScheme = ColorScheme.dark(
      primary: AppColors.primary,
      secondary: AppColors.accentChai,
      surface: AppColors.darkSurface,
      surfaceContainerHighest: AppColors.darkElevated,
      error: AppColors.statusDnd,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: AppColors.darkTextPrimary,
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.darkBackground,
      dividerColor: AppColors.darkBorder,
      cardColor: AppColors.darkElevated,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.darkSurface,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.darkTextPrimary),
        titleTextStyle: TextStyle(
          color: AppColors.darkTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.darkElevated,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        hintStyle: const TextStyle(color: AppColors.darkTextMuted),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      extensions: const <ThemeExtension<dynamic>>[
        ChaiChuThemeExtension(
          railBackground: AppColors.darkRail,
          channelListBackground: AppColors.darkSurface,
          activeItemColor: AppColors.primary,
          hoverColor: Color(0x1A6366F1),
          borderSubtle: AppColors.darkBorder,
        ),
      ],
    );
  }

  static ThemeData get lightTheme {
    const colorScheme = ColorScheme.light(
      primary: AppColors.primaryDark,
      secondary: AppColors.accentChai,
      surface: AppColors.lightSurface,
      surfaceContainerHighest: AppColors.lightElevated,
      error: AppColors.statusDnd,
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onSurface: AppColors.lightTextPrimary,
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.lightBackground,
      dividerColor: AppColors.lightBorder,
      cardColor: AppColors.lightElevated,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.lightSurface,
        elevation: 0,
        centerTitle: false,
        iconTheme: IconThemeData(color: AppColors.lightTextPrimary),
        titleTextStyle: TextStyle(
          color: AppColors.lightTextPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.lightElevated,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.lightBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.lightBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primaryDark, width: 2),
        ),
        hintStyle: const TextStyle(color: AppColors.lightTextMuted),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDark,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      extensions: const <ThemeExtension<dynamic>>[
        ChaiChuThemeExtension(
          railBackground: AppColors.lightRail,
          channelListBackground: AppColors.lightSurface,
          activeItemColor: AppColors.primaryDark,
          hoverColor: Color(0x1A4F46E5),
          borderSubtle: AppColors.lightBorder,
        ),
      ],
    );
  }
}
