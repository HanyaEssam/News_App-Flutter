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

  static double scaleText(BuildContext context, double size) {
    const double baseWidth = 390;
    final double scaleFactor =
    (width(context) / baseWidth).clamp(0.85, 1.8);
    return size * scaleFactor;
  }

  static double scale(BuildContext context, double size) {
    const double baseWidth = 390;
    final double scaleFactor =
    (width(context) / baseWidth).clamp(0.85, 2.2);
    return size * scaleFactor;
  }

  static double maxWidth(BuildContext context) {
    if (isDesktop(context)) return width(context) * 0.75;
    if (isTablet(context)) return width(context) * 0.85;
    return double.infinity;
  }
}