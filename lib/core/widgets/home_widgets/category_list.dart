import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int selectedIndex = 0;

  final List<Map<String, String>> categories = [
    {'name': 'Tech', 'iconPath': 'assets/images/tech.png'},
    {'name': 'Business', 'iconPath': 'assets/images/business.png'},
    {'name': 'Sports', 'iconPath': 'assets/images/sport.png'},
    {'name': 'Politics', 'iconPath': 'assets/images/politics.png'},
    {'name': 'Science', 'iconPath': 'assets/images/science.png'},
    {'name': 'Culture', 'iconPath': 'assets/images/culture.png'},
  ];

  @override
  Widget build(BuildContext context) {
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
            },
            child: Column(
              children: [
                Container(
                  height: 60,
                  width: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.inputFill : AppColors.cardDark,
                    borderRadius: BorderRadius.circular(16),
                    border: isSelected ? Border.all(color: AppColors.border) : null,
                  ),
                  child: Image.asset(
                    categories[index]['iconPath']!,
                    width: 32,
                    height: 32,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  categories[index]['name']!,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: isSelected ? AppColors.primary : AppColors.mutedText,
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