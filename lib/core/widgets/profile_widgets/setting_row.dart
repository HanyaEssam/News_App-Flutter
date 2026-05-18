import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class SettingsRow extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final Widget trailing;

  const SettingsRow({
    super.key,
    required this.leadingIcon,
    required this.title,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(leadingIcon,
            color: theme.textTheme.bodyMedium?.color,
          ),
          const SizedBox(width: 16),
          // Title (titleMedium)
          Expanded(
            child: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}