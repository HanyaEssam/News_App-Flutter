import 'package:flutter/material.dart';
import '../../models/article_model.dart';
import '../../theme/app_colors.dart';
import '../../utils/saved_articles_manager.dart';

class BookmarkButton extends StatelessWidget {
  final ArticleModel article;
  final Color? unselectedColor; // CHANGED
  final double size;

  const BookmarkButton({
    super.key,
    required this.article,
    this.unselectedColor, // CHANGED
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // CHANGED

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
          color: isCurrentlySaved
              ? theme.colorScheme.primary // CHANGED
              : unselectedColor ?? theme.textTheme.bodySmall?.color, // CHANGED
          onPressed: () {
            SavedArticlesManager.toggleSave(article);

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