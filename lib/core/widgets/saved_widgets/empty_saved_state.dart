import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../ui/home/screens/home_screen.dart';

class EmptySavedState extends StatelessWidget {
  const EmptySavedState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 60),

        // Large faded bookmark icon
        Icon(
          Icons.bookmark_border,
          size: 80,
          color: AppColors.inputFill,
        ),
        const SizedBox(height: 32),

        // Title (headlineSmall)
        Text(
          'No saved articles yet.',
          style: Theme.of(context).textTheme.headlineSmall,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),

        // Description (bodyMedium)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: Text(
            'Your curation space is empty. Explore the latest insights and bookmark articles to build your personalized intelligence feed.',
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 40),

        // Custom Outlined Button (labelMedium text)
        FilledButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, HomeLayout.routeName);
          },
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.inputFill,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Text(
            'START EXPLORING',
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.primary,
            ),
          ),
        )
      ],
    );
  }
}