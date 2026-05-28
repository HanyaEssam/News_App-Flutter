import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../utils/responsive.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final String value;
  final String? unit;
  final bool isWord;

  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    this.unit,
    this.isWord = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Expanded(
      child: Container(
        padding: EdgeInsets.all(Responsive.scale(context, 20)),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(Responsive.scale(context, 16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title.toUpperCase(),
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.secondary.withOpacity(0.8),
                fontSize: Responsive.scaleText(context, 12),
              ),
            ),
            SizedBox(height: Responsive.scale(context, 12)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Flexible(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      value,
                      style: theme.textTheme.displayMedium?.copyWith(
                        fontSize: Responsive.scaleText(context, isWord ? 24 : 32),
                      ),
                    ),
                  ),
                ),
                if (unit != null) ...[
                  SizedBox(width: Responsive.scale(context, 6)),
                  Text(
                    unit!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.mutedText,
                      fontSize: Responsive.scaleText(context, 14),
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