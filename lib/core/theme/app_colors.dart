import 'package:flutter/material.dart';

/// Original color palette for ChaiChu (nexcord).
///
/// Designed with rich dark obsidian surfaces, warm spiced chai amber accents,
/// and electric indigo primary actions.
class AppColors {
  AppColors._();

  // Brand Accents
  static const Color primary = Color(0xFF6366F1); // Electric Indigo
  static const Color primaryDark = Color(0xFF4F46E5);
  static const Color accentChai = Color(0xFFE5A93C); // Spiced Amber
  static const Color accentMatcha = Color(0xFF10B981); // Emerald online

  // Status Indicators
  static const Color statusOnline = Color(0xFF10B981);
  static const Color statusIdle = Color(0xFFF59E0B);
  static const Color statusDnd = Color(0xFFEF4444);
  static const Color statusOffline = Color(0xFF64748B);
  static const Color statusStreaming = Color(0xFF8B5CF6);

  // Dark Theme Palette (Default)
  static const Color darkBackground = Color(0xFF0F1117);
  static const Color darkSurface = Color(0xFF171923);
  static const Color darkElevated = Color(0xFF1E2230);
  static const Color darkRail = Color(0xFF0B0C10);
  static const Color darkBorder = Color(0xFF282D3F);
  static const Color darkTextPrimary = Color(0xFFF1F5F9);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkTextMuted = Color(0xFF64748B);

  // Light Theme Palette
  static const Color lightBackground = Color(0xFFF8F9FA);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightElevated = Color(0xFFEDEFF2);
  static const Color lightRail = Color(0xFFE2E8F0);
  static const Color lightBorder = Color(0xFFCBD5E1);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF475569);
  static const Color lightTextMuted = Color(0xFF94A3B8);
}
