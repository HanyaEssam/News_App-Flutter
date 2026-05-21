import 'package:flutter/material.dart';
import '../../models/article_model.dart';
import '../../theme/app_colors.dart';
import '../../utils/saved_articles_manager.dart';

// 🔥 NEW IMPORT:
import '../../utils/guest_checker.dart';

class BookmarkButton extends StatelessWidget {
  final ArticleModel article;
  final Color? unselectedColor;
  final double size;

  const BookmarkButton({
    super.key,
    required this.article,
    this.unselectedColor,
    this.size = 24,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
              ? theme.colorScheme.primary
              : unselectedColor ?? theme.textTheme.bodySmall?.color,
          onPressed: () {
            // 🔥 INTERCEPT GUESTS HERE:
            // If they are a guest, this returns true and stops the rest of the code from running
            if (GuestChecker.checkAndPrompt(context)) return;

            // If they are logged in, proceed with saving normally:
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