import 'package:flutter/material.dart';

class AuthFooter extends StatelessWidget {
  final String text;
  const AuthFooter({
    super.key,
    this.text = '© 2026 INSIGHTFUL PRIVACY & TERMS.',
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Text(
      text,
      style: theme.textTheme.labelSmall?.copyWith(
        color: theme.colorScheme.onSurface.withOpacity(0.4),
      ),
    );
  }
}