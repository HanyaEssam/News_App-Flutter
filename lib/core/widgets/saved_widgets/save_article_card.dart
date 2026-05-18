import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/article_model.dart'; // Import your model
import '../../../core/utils/saved_articles_manager.dart';
import '../bookmark/bookmark_button.dart';

class SavedArticleCard extends StatelessWidget {
  // Pass the entire model instead of individual strings
  final ArticleModel article;

  const SavedArticleCard({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Image
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              image: DecorationImage(
                // Use the image asset or network from your model
                image: AssetImage(article.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Card Content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Category Text
                    Text(
                      article.category.toUpperCase(),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: article.categoryColor, // Handled automatically by model
                      ),
                    ),

                    // ValueListenableBuilder listening to our unified ArticleModel list
                    BookmarkButton(
                      article: article,
                      unselectedColor: AppColors.mutedText, // Uses muted/grey color inside cards
                    ),                  ],
                ),
                const SizedBox(height: 12),

                // Article Title
                Text(
                  article.title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),

                // Footer Info
                Row(
                  children: [
                    Text(
                      article.source,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('•', style: TextStyle(color: AppColors.border)),
                    ),
                    Text(
                      // Assuming readTime or time exists in your model mapping
                      article.readtime,
                      style: Theme.of(context).textTheme.bodySmall,
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