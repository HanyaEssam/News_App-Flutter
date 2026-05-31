import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/article_model.dart';
import '../bookmark/bookmark_button.dart';
import 'package:news/ui/article_details/article_details_screen.dart';
import '../../../core/utils/responsive.dart'; // 🔥 Import your helper

class SavedArticleCard extends StatelessWidget {
  final ArticleModel article;

  const SavedArticleCard({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailsScreen(article: article),
          ),
        );
      },
      borderRadius: BorderRadius.circular(Responsive.scale(context, 20)),
      child: Container(
        margin: EdgeInsets.only(bottom: Responsive.scale(context, 24)),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(Responsive.scale(context, 20)),
          border: Border.all(
            color: theme.colorScheme.primary.withOpacity(0.25),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Responsive Image Container
            Container(
              height: Responsive.scale(context, 180),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(Responsive.scale(context, 20)),
                ),
                image: article.imageUrl.isNotEmpty
                    ? DecorationImage(
                  image: article.imageUrl.startsWith('http')
                      ? NetworkImage(article.imageUrl) as ImageProvider
                      : AssetImage(article.imageUrl),
                  fit: BoxFit.cover,
                )
                    : null,
              ),
              child: article.imageUrl.isEmpty
                  ? Center(
                child: Icon(
                  Icons.image_not_supported,
                  color: Colors.white24,
                  size: Responsive.scale(context, 50),
                ),
              )
                  : null,
            ),

            Padding(
              padding: EdgeInsets.all(Responsive.scale(context, 20)),
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
                          fontSize: Responsive.scaleText(context, 14), // Dynamic text
                        ),
                      ),
                      BookmarkButton(
                        article: article,
                        unselectedColor: theme.textTheme.bodySmall?.color ?? AppColors.lightMutedText,
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.scale(context, 12)),
                  Text(
                    article.title,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontSize: Responsive.scaleText(context, 20), // Responsive title
                    ),
                  ),
                  SizedBox(height: Responsive.scale(context, 16)),
                  Row(
                    children: [
                      Text(
                        article.source,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: Responsive.scaleText(context, 12),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Responsive.scale(context, 8)),
                        child: Text(
                          '•',
                          style: TextStyle(
                            color: theme.colorScheme.primary.withOpacity(0.5),
                          ),
                        ),
                      ),
                      Text(
                        article.readtime,
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: Responsive.scaleText(context, 12),
                        ),
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