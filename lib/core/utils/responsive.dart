import 'package:flutter/material.dart';

class Responsive {
  static double width(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double height(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static bool isMobile(BuildContext context) => width(context) < 600;
  static bool isTablet(BuildContext context) =>
      width(context) >= 600 && width(context) < 1024;
  static bool isDesktop(BuildContext context) => width(context) >= 1024;

  /// Scales text, but clamps it so tablets/desktops don't get giant text
  static double scaleText(BuildContext context, double size) {
    const double baseWidth = 390;
    final double screenWidth = width(context);
    final double scaleFactor = (screenWidth / baseWidth).clamp(0.85, 1.3);
    return size * scaleFactor;
  }

  /// Scales sizes (padding, icons, etc.) with a clamp
  static double scale(BuildContext context, double size) {
    const double baseWidth = 390;
    final double scaleFactor = (width(context) / baseWidth).clamp(0.85, 1.5);
    return size * scaleFactor;
  }
}