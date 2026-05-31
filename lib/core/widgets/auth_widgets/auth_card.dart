import 'package:flutter/material.dart';
import '../../../core/utils/responsive.dart';

class AuthCard extends StatelessWidget {
  final Widget child;
  const AuthCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(Responsive.scale(context, 24)),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(Responsive.scale(context, 30)),
        boxShadow: isDark
            ? null
            : [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}