import 'package:flutter/material.dart';
import '../../models/article_model.dart';
import '../../utils/saved_articles_manager.dart';
import '../../utils/guest_checker.dart';
import '../../utils/responsive.dart';

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
    final double scaledSize = Responsive.scale(context, size);

    return ValueListenableBuilder<List<ArticleModel>>(
      valueListenable: SavedArticlesManager.savedArticles,
      builder: (context, savedList, child) {
        bool isCurrentlySaved = SavedArticlesManager.isSaved(article);

        return IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          iconSize: scaledSize,
          icon: Icon(
            isCurrentlySaved ? Icons.bookmark : Icons.bookmark_border,
          ),
          color: isCurrentlySaved
              ? theme.colorScheme.primary
              : unselectedColor ?? theme.textTheme.bodySmall?.color,
          onPressed: () {
            if (GuestChecker.checkAndPrompt(context)) return;

            SavedArticlesManager.toggleSave(article);

            ScaffoldMessenger.of(context).clearSnackBars();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  isCurrentlySaved ? 'Removed from Saved' : 'Article Saved!',
                  style: TextStyle(
                    fontSize: Responsive.scaleText(context, 14),
                  ),
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