import 'package:flutter/material.dart';
import '../../../core/utils/responsive.dart';

class AuthHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const AuthHeader({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontSize: Responsive.scaleText(context, 22),
          ),
        ),
        SizedBox(height: Responsive.scale(context, 12)),
        Text(
          subtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: Responsive.scaleText(context, 14),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}