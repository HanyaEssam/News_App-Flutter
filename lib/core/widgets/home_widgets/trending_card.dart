import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../models/article_model.dart';
import 'package:news/ui/article_details/article_details_screen.dart';
import 'package:news/l10n/app_localizations.dart';
import '../../utils/responsive.dart';

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
      borderRadius: BorderRadius.circular(Responsive.scale(context, 20)),
      child: Container(
        width: Responsive.scale(context, 280),
        margin: EdgeInsets.only(right: Responsive.scale(context, 16)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Responsive.scale(context, 20)),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(Responsive.scale(context, 20)),
              ),
              child: _buildImage(context),
            ),
            Padding(
              padding: EdgeInsets.all(Responsive.scale(context, 16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.scale(context, 8),
                          vertical: Responsive.scale(context, 4),
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.15),
                          borderRadius: BorderRadius.circular(
                            Responsive.scale(context, 20),
                          ),
                          border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.5),
                          ),
                        ),
                        child: Text(
                          article.category == 'Trending'
                              ? AppLocalizations.of(context)!.trendingLabel
                              : article.category,
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                            color: AppColors.primary,
                            fontSize: Responsive.scaleText(context, 10),
                          ),
                        ),
                      ),
                      SizedBox(width: Responsive.scale(context, 12)),
                      Text(
                        article.time,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: Responsive.scaleText(context, 12),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.scale(context, 12)),
                  Text(
                    article.title,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontSize: Responsive.scaleText(context, 16),
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: Responsive.scale(context, 16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.auto_awesome,
                              size: Responsive.scale(context, 16),
                              color: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.color,
                            ),
                            SizedBox(width: Responsive.scale(context, 6)),
                            Expanded(
                              child: Text(
                                article.source,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(
                                  fontSize:
                                  Responsive.scaleText(context, 12),
                                ),
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
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
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

  Widget _buildImage(BuildContext context) {
    final imageUrl = article.imageUrl;
    final double imageHeight = Responsive.scale(context, 160);

    if (imageUrl.isEmpty) {
      return Container(
        height: imageHeight,
        width: double.infinity,
        color: Colors.grey.shade900,
        child: Center(
          child: Icon(
            Icons.image_not_supported_outlined,
            color: Colors.white24,
            size: Responsive.scale(context, 48),
          ),
        ),
      );
    }

    final isNetwork =
        imageUrl.startsWith('http://') || imageUrl.startsWith('https://');

    if (isNetwork) {
      return Image.network(
        imageUrl,
        height: imageHeight,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: imageHeight,
            color: Colors.grey.shade900,
            child: Center(
              child: Icon(
                Icons.broken_image_outlined,
                color: Colors.white24,
                size: Responsive.scale(context, 48),
              ),
            ),
          );
        },
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(
            height: imageHeight,
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
        height: imageHeight,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: imageHeight,
            color: Colors.grey.shade900,
            child: Center(
              child: Icon(
                Icons.broken_image_outlined,
                color: Colors.white24,
                size: Responsive.scale(context, 48),
              ),
            ),
          );
        },
      );
    }
  }
}