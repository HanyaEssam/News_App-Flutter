import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/article_model.dart';
import '../bookmark/bookmark_button.dart';
// 🔥 IMPORT ADDED: Needed to navigate to the details screen
import 'package:news/ui/article_details/article_details_screen.dart';

class SavedArticleCard extends StatelessWidget {
  final ArticleModel article;

  const SavedArticleCard({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 🔥 FIX 1: Wrapped the entire Container in an InkWell to make it clickable
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailsScreen(article: article),
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: theme.colorScheme.primary.withOpacity(0.25),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 FIX 2: Upgraded the image handling to support API Network links
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.grey.shade900, // Placeholder background color
                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                image: article.imageUrl.isNotEmpty
                    ? DecorationImage(
                  // Check if it's a web link or a local asset
                  image: article.imageUrl.startsWith('http')
                      ? NetworkImage(article.imageUrl) as ImageProvider
                      : AssetImage(article.imageUrl),
                  fit: BoxFit.cover,
                )
                    : null,
              ),
              // Fallback icon if the article has no image URL at all
              child: article.imageUrl.isEmpty
                  ? const Center(
                child: Icon(Icons.image_not_supported, color: Colors.white24, size: 50),
              )
                  : null,
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
                            color: theme.colorScheme.primary.withOpacity(0.5),
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
      ),
    );
  }
}