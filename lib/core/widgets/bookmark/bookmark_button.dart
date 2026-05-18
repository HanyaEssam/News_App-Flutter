import 'package:flutter/material.dart';
import '../../models/article_model.dart';
import '../../theme/app_colors.dart';
import '../../utils/saved_articles_manager.dart';

class BookmarkButton extends StatelessWidget {
  final ArticleModel article;
  final Color unselectedColor;
  final double size;

  const BookmarkButton({
    super.key,
    required this.article,
    this.unselectedColor = AppColors.white,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<ArticleModel>>(
      valueListenable: SavedArticlesManager.savedArticles,
      builder: (context, savedList, child) {
        bool isCurrentlySaved = SavedArticlesManager.isSaved(article);

        return IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          iconSize: size,
          icon: Icon(
            isCurrentlySaved ? Icons.bookmark : Icons.bookmark_border,
          ),
          color: isCurrentlySaved ? AppColors.primary : unselectedColor,
          onPressed: () {
            // 1. Handle global state shift
            SavedArticlesManager.toggleSave(article);

            // 2. Clear previous snackbars and show current notification context
            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isCurrentlySaved ? 'Removed from Saved' : 'Article Saved!',
                ),
                duration: const Duration(seconds: 1),
              ),
            );
          },
        );
      },
    );
  }
}