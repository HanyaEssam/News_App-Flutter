import 'package:flutter/material.dart';

class AuthLinkText extends StatelessWidget {
  final String message;
  final String linkText;
  final VoidCallback onTap;

  const AuthLinkText({
    super.key,
    required this.message,
    required this.linkText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(message, style: theme.textTheme.bodyMedium),
        GestureDetector(
          onTap: onTap,
          child: Text(
            linkText,
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}