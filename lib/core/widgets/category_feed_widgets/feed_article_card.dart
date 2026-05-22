import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../models/article_model.dart';
import '../../../ui/article_details/article_details_screen.dart';
import '../bookmark/bookmark_button.dart';

class FeedArticleCard extends StatelessWidget {
  final ArticleModel article; // ✅ Only passing the full article now!

  const FeedArticleCard({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleDetailsScreen(
                article: article, // ✅ Passes the real article, with the real date!
              ),
            ),
          );
        },
        child: Container(
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
              // 🔥 Smart Image Handler
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
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
                    ? const Center(child: Icon(Icons.image_not_supported, color: Colors.white24, size: 50))
                    : null,
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.article,
                            size: 16,
                            color: article.categoryColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article.source,
                              style: theme.textTheme.bodySmall,
                            ),
                            Text(
                              'MAIN SOURCE',
                              style: theme.textTheme.labelSmall,
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    Text(
                      article.title,
                      style: theme.textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),

                    Text(
                      article.content,
                      style: theme.textTheme.bodyMedium,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              article.readtime.toUpperCase(),
                              style: theme.textTheme.labelSmall,
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
                              article.date.toUpperCase(), // ✅ Shows the real date here!
                              style: theme.textTheme.labelSmall,
                            ),
                          ],
                        ),
                        BookmarkButton(
                          article: article,
                          unselectedColor:
                          theme.textTheme.bodySmall?.color ?? AppColors.lightMutedText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}