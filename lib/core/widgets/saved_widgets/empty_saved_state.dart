import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../ui/home/screens/home_screen.dart';
import 'package:news/l10n/app_localizations.dart';

import '../../utils/responsive.dart';

class EmptySavedState extends StatelessWidget {
  const EmptySavedState({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: Responsive.scale(context, 60)),

        // Large faded bookmark icon
        Icon(Icons.bookmark_border, size: Responsive.scale(context, 60), color: AppColors.inputFill),
        SizedBox(height: Responsive.scale(context, 32)),

        // Title (headlineSmall)
        Text(
          AppLocalizations.of(context)!.noSavedArticles,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontSize: Responsive.scaleText(context, 20),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: Responsive.scale(context, 16)),

        // Description (bodyMedium)
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.scale(context, 40),
          ),
          child: Text(
            AppLocalizations.of(context)!.curationSpaceEmpty,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontSize: Responsive.scaleText(context, 14),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: Responsive.scale(context, 40)),

        // Custom Outlined Button (labelMedium text)
        FilledButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, HomeLayout.routeName);
          },
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.inputFill,
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.scale(context, 24),
              vertical: Responsive.scale(context, 16),),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Responsive.scale(context, 14),),
            ),
          ),
          child: Text(
            AppLocalizations.of(context)!.startExploring.toUpperCase(),
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.primary,
              fontSize: Responsive.scaleText(context, 12),
            ),
          ),
        ),
      ],
    );
  }
}
