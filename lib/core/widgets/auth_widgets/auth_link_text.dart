import 'package:flutter/material.dart';
import '../../../core/utils/responsive.dart';

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

    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: Responsive.scale(context, 4),      children: [
        Text(
          message,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: Responsive.scaleText(context, 14),
          ),
        ),
        SizedBox(width: Responsive.scale(context, 4)),
        GestureDetector(
          onTap: onTap,
          child: Text(
            linkText,
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.primary,
              fontSize: Responsive.scaleText(context, 14),
            ),
          ),
        ),
      ],
    );
  }
}