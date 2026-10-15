import 'package:flutter/material.dart';

/// Layout breakpoints and responsive builder for ChaiChu.
///
/// Rules:
/// - Mobile (<700px): Uses bottom navigation bar and drawers.
/// - Desktop / Tablet (>=700px): Uses 3-to-4 panes (server rail | channel list | content | member list).
class ResponsiveLayout extends StatelessWidget {
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.desktop,
  });

  final Widget mobile;
  final Widget desktop;

  static const double mobileBreakpoint = 700.0;

  static bool isMobile(BuildContext context) =>
      MediaQuery.sizeOf(context).width < mobileBreakpoint;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= mobileBreakpoint;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < mobileBreakpoint) {
          return mobile;
        }
        return desktop;
      },
    );
  }
}
