import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/article_model.dart';
import '../bookmark/bookmark_button.dart';

class SavedArticleCard extends StatelessWidget {
  final ArticleModel article;

  const SavedArticleCard({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // CHANGED

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface, // CHANGED
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.25), // CHANGED
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              image: DecorationImage(
                image: AssetImage(article.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      article.category.toUpperCase(),
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: article.categoryColor,
                      ),
                    ),

                    BookmarkButton(
                      article: article,
                      unselectedColor: theme.textTheme.bodySmall?.color ?? AppColors.lightMutedText,
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Text(
                  article.title,
                  style: theme.textTheme.headlineSmall,
                ),

                const SizedBox(height: 16),

                Row(
                  children: [
                    Text(
                      article.source,
                      style: theme.textTheme.bodySmall,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        '•',
                        style: TextStyle(
                          color: theme.colorScheme.primary.withOpacity(0.5), // CHANGED
                        ),
                      ),
                    ),

                    Text(
                      article.readtime,
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}