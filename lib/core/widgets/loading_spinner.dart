import 'package:flutter/material.dart';
import '../utils/responsive.dart';

class LoadingSpinner extends StatelessWidget {
  final Color? color;
  final double size;
  final double strokeWidth;

  const LoadingSpinner({
    super.key,
    this.color,
    this.size = 20,
    this.strokeWidth = 2,
  });

  @override
  Widget build(BuildContext context) {
    final double scaledSize = Responsive.scale(context, size);

    return SizedBox(
      height: scaledSize,
      width: scaledSize,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        color: color ?? Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}