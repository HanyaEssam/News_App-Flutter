import 'package:flutter/material.dart';
// Note: Adjust the import path below if your app_colors.dart is located elsewhere
import '../../../../core/theme/app_colors.dart';

class CommentsSection extends StatelessWidget {
  final Color categoryColor; // We will use this to color the button and avatar!

  const CommentsSection({super.key, required this.categoryColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Comments Counter Header
        Row(
          children: [
            Text("Comments", style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: categoryColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "24",
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: categoryColor, // Colored to match category
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // 2. The Custom Input Field with Colored Button
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.cardDark,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.border.withOpacity(0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end, // Aligns button to the right
            children: [
              TextField(
                maxLines: 3,
                minLines: 2,
                decoration: InputDecoration(
                  hintText: "Add to the briefing...",
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  // We remove the default borders so it blends seamlessly into the Container
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  fillColor: Colors.transparent,
                  filled: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const SizedBox(height: 12),

              // The Dynamic Colored Button
              FilledButton(
                onPressed: () {
                  // TODO: Handle comment post
                },
                style: FilledButton.styleFrom(
                  backgroundColor: categoryColor, // Uses the exact category color!
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "POST COMMENT",
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.darkText, // High contrast text on top of the color
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),

        // 3. Single Dummy Comment
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User Avatar styled to match design
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: categoryColor.withOpacity(0.8), // Matches the category!
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.center,
              child: Text(
                "HA",
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.darkText,
                ),
              ),
            ),
            const SizedBox(width: 16),

            // Comment Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                          "Hanya Abdelmeguid",
                          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: AppColors.white,
                          )
                      ),
                      const SizedBox(width: 12),
                      Text("2H AGO", style: Theme.of(context).textTheme.labelSmall),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "The point about Von Neumann bottlenecks is crucial. We've been hitting the thermal wall for years. Photonics is finally making this transition viable at scale.",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}