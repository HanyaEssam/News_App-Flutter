import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../models/article_model.dart';
import 'package:news/ui/article_details/article_details_screen.dart';
import 'package:news/l10n/app_localizations.dart';

class TrendingCard extends StatelessWidget {
  final ArticleModel article;

  const TrendingCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
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
        width: 280,
        margin: const EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 Smart image handling
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: _buildImage(),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withOpacity(0.5),
                          ),
                        ),
                        child: Text(
                          article.category == 'Trending'
                              ? AppLocalizations.of(context)!.trendingLabel
                              : article.category,
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: AppColors.primary),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        article.time,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    article.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.auto_awesome,
                              size: 16,
                              color: Theme.of(
                                context,
                              ).textTheme.bodySmall?.color,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                article.source,
                                style: Theme.of(context).textTheme.bodySmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        article.readtime.replaceAll(
                          'min read',
                          AppLocalizations.of(context)!.minRead,
                        ),
                        style: Theme.of(context).textTheme.bodySmall,
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

  // 🔥 Smart image: network OR asset
  Widget _buildImage() {
    final imageUrl = article.imageUrl;

    if (imageUrl.isEmpty) {
      return Container(
        height: 160,
        width: double.infinity,
        color: Colors.grey.shade900,
        child: const Center(
          child: Icon(
            Icons.image_not_supported_outlined,
            color: Colors.white24,
            size: 48,
          ),
        ),
      );
    }

    final isNetwork =
        imageUrl.startsWith('http://') || imageUrl.startsWith('https://');

    if (isNetwork) {
      return Image.network(
        imageUrl,
        height: 160,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 160,
            color: Colors.grey.shade900,
            child: const Center(
              child: Icon(
                Icons.broken_image_outlined,
                color: Colors.white24,
                size: 48,
              ),
            ),
          );
        },
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(
            height: 160,
            color: Colors.grey.shade900,
            child: const Center(
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        },
      );
    } else {
      return Image.asset(
        imageUrl,
        height: 160,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 160,
            color: Colors.grey.shade900,
            child: const Center(
              child: Icon(
                Icons.broken_image_outlined,
                color: Colors.white24,
                size: 48,
              ),
            ),
          );
        },
      );
    }
  }
}
