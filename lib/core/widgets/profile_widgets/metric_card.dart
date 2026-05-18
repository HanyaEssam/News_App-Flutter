import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String? unit;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    this.unit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toUpperCase(),
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.secondary.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 12),
            // Number value and optional Unit row
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                // Big Numbers (displayMedium)
                Text(
                  value,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                if (unit != null) ...[
                  const SizedBox(width: 6),
                  // Unit text like 'm' (bodyMedium)
                  Text(
                    unit!,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.mutedText,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}