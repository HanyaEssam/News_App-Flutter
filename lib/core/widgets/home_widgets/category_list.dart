import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:news/l10n/app_localizations.dart';

import '../../theme/app_colors.dart';
import '../../../ui/category_feed/screens/category_feed_screen.dart';
import '../../../core/utils/locale_provider.dart';
import '../../../core/utils/responsive.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int selectedIndex = -1;

  final List<Map<String, dynamic>> categories = [
    {'name': 'Tech', 'iconPath': 'assets/images/tech.png', 'color': AppColors.primary},
    {'name': 'Business', 'iconPath': 'assets/images/business.png', 'color': AppColors.blue},
    {'name': 'Sports', 'iconPath': 'assets/images/sport.png', 'color': AppColors.green},
    {'name': 'Politics', 'iconPath': 'assets/images/politics.png', 'color': AppColors.orange},
    {'name': 'Science', 'iconPath': 'assets/images/science.png', 'color': AppColors.purple},
    {'name': 'Health', 'iconPath': 'assets/images/health.png', 'color': AppColors.error},
    {'name': 'Travel', 'iconPath': 'assets/images/travel.png', 'color': AppColors.yellow},
    {'name': 'Entertainment', 'iconPath': 'assets/images/entertainment.png', 'color': AppColors.pink},
    {'name': 'General', 'iconPath': 'assets/images/general.png', 'color': AppColors.grey},
  ];

  String _translateCategory(BuildContext context, String rawName) {
    final loc = AppLocalizations.of(context)!;
    switch (rawName) {
      case 'Tech': return loc.tech;
      case 'Business': return loc.business;
      case 'Sports': return loc.sports;
      case 'Politics': return loc.politics;
      case 'Science': return loc.science;
      case 'Health': return loc.health;
      case 'Travel': return loc.travel;
      case 'Entertainment': return loc.entertainment;
      case 'General': return loc.general;
      default: return rawName;
    }
  }

  Future<void> _onCategoryTap(int index) async {
    if (selectedIndex == index) return;
    setState(() => selectedIndex = index);
    await Future.delayed(const Duration(milliseconds: 150));
    if (!mounted) return;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CategoryFeedScreen(
          categoryName: categories[index]['name'],
          categoryColor: categories[index]['color'],
        ),
      ),
    );
    if (mounted) setState(() => selectedIndex = -1);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<LocaleProvider>(context);
    final theme = Theme.of(context);

    final double itemSize = Responsive.scale(context, 60);
    final double iconSize = Responsive.scale(context, 32);
    final double borderRadius = Responsive.scale(context, 16);
    final double separatorWidth = Responsive.scale(context, 20);
    final double labelGap = Responsive.scale(context, 8);
    final double horizontalPadding = Responsive.scale(context, 20);
    final double totalHeight = itemSize + labelGap + Responsive.scaleText(context, 11) + Responsive.scale(context, 24);    return SizedBox(
      height: totalHeight,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          itemCount: categories.length,
          separatorBuilder: (context, index) => SizedBox(width: separatorWidth),
          itemBuilder: (context, index) {
            final bool isSelected = index == selectedIndex;
            final category = categories[index];

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _onCategoryTap(index),
              child: SizedBox(
                width: itemSize, // fix all items to the same width
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                      height: itemSize,
                      width: itemSize,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? theme.colorScheme.primary.withOpacity(0.15)
                            : theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(borderRadius),
                        border: Border.all(
                          color: isSelected
                              ? theme.colorScheme.primary
                              : Colors.transparent,
                          width: 1.5,
                        ),
                      ),
                      child: Image.asset(
                        category['iconPath'],
                        width: iconSize,
                        height: iconSize,
                        gaplessPlayback: true,
                      ),
                    ),
                    SizedBox(height: labelGap),
                    AnimatedDefaultTextStyle(
                      duration: const Duration(milliseconds: 200),
                      style: theme.textTheme.titleSmall!.copyWith(
                        fontSize: Responsive.scaleText(context, 11),
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.textTheme.bodySmall?.color,
                      ),
                      child: Text(
                        _translateCategory(context, category['name']!),
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}