import 'package:flutter/material.dart';
import '../../utils/responsive.dart'; 

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
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.scale(context, 16),
        vertical: Responsive.scale(context, 12),
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(Responsive.scale(context, 16)),
      ),
      child: Row(
        children: [
          Icon(
            leadingIcon,
            color: theme.textTheme.bodyMedium?.color,
            size: Responsive.scale(context, 24),
          ),
          SizedBox(width: Responsive.scale(context, 16)),
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontSize: Responsive.scaleText(context, 16),
              ),
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}