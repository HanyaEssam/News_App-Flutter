import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';
import '../../../ui/category_feed/screens/category_feed_screen.dart'; // Import your screen

import 'package:news/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/locale_provider.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int selectedIndex = 0;

  // Added the specific colors for each category based on your requirements
  final List<Map<String, dynamic>> categories = [
    {
      'name': 'Tech',
      'iconPath': 'assets/images/tech.png',
      'color': AppColors.primary,
    },
    {
      'name': 'Business',
      'iconPath': 'assets/images/business.png',
      'color': AppColors.blue,
    },
    {
      'name': 'Sports',
      'iconPath': 'assets/images/sport.png',
      'color': AppColors.green,
    },
    {
      'name': 'Politics',
      'iconPath': 'assets/images/politics.png',
      'color': AppColors.orange,
    },
    {
      'name': 'Science',
      'iconPath': 'assets/images/science.png',
      'color': AppColors.purple,
    },
    {
      'name': 'Health',
      'iconPath': 'assets/images/health.png',
      'color': AppColors.error,
    },
    {
      'name': 'Travel',
      'iconPath': 'assets/images/travel.png',
      'color': AppColors.yellow,
    },
    {
      'name': 'Entertainment',
      'iconPath': 'assets/images/entertainment.png',
      'color': AppColors.pink,
    },
    {
      'name': 'General',
      'iconPath': 'assets/images/general.png',
      'color': AppColors.grey,
    },
  ];

  String _translateCategory(BuildContext context, String rawName) {
    final loc = AppLocalizations.of(context)!;
    switch (rawName) {
      case 'Tech':
        return loc.tech;
      case 'Business':
        return loc.business;
      case 'Sports':
        return loc.sports;
      case 'Politics':
        return loc.politics;
      case 'Science':
        return loc.science;
      case 'Health':
        return loc.health;
      case 'Travel':
        return loc.travel;
      case 'Entertainment':
        return loc.entertainment;
      case 'General':
        return loc.general;
      default:
        return rawName;
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<LocaleProvider>(context);

    return SizedBox(
      height: 95,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: categories.length,
        separatorBuilder: (context, index) => const SizedBox(width: 20),
        itemBuilder: (context, index) {
          bool isSelected = index == selectedIndex;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryFeedScreen(
                    categoryName: categories[index]['name'],
                    categoryColor: categories[index]['color'],
                  ),
                ),
              );
            },
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary.withOpacity(
                            0.15,
                          ) // CHANGED
                        : Theme.of(context).colorScheme.surface, // CHANGED
                    borderRadius: BorderRadius.circular(16),
                    border: isSelected
                        ? Border.all(
                            color: Theme.of(context).colorScheme.primary,
                          ) // CHANGED
                        : null,
                  ),
                  child: Image.asset(
                    categories[index]['iconPath'],

                    width: 32,
                    height: 32,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _translateCategory(context, categories[index]['name']!),

                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: isSelected
                        ? Theme.of(context)
                              .colorScheme
                              .primary // CHANGED
                        : Theme.of(
                            context,
                          ).textTheme.bodySmall?.color, // CHANGED
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
