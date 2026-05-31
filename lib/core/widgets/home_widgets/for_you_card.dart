import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/article_model.dart';
import 'package:news/ui/article_details/article_details_screen.dart';
import '../bookmark/bookmark_button.dart';
import 'package:news/l10n/app_localizations.dart';
import '../../../core/utils/responsive.dart';

class ForYouCard extends StatelessWidget {
  final String label;
  final ArticleModel article;

  const ForYouCard({super.key, required this.label, required this.article});

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
        margin: EdgeInsets.only(bottom: Responsive.scale(context, 16)),
        padding: EdgeInsets.all(Responsive.scale(context, 16)),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(Responsive.scale(context, 20)),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.25),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.lightbulb_outline,
                        size: Responsive.scale(context, 16),
                        color: article.categoryColor,
                      ),
                      SizedBox(width: Responsive.scale(context, 8)),
                      Expanded(
                        child: Text(
                          label.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .labelSmall
                              ?.copyWith(
                            color: article.categoryColor,
                            fontSize: Responsive.scaleText(context, 10),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                BookmarkButton(
                  article: article,
                  unselectedColor: AppColors.mutedText,
                ),
              ],
            ),
            SizedBox(height: Responsive.scale(context, 12)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineSmall
                            ?.copyWith(
                          fontSize: Responsive.scaleText(context, 16),
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: Responsive.scale(context, 8)),
                      Text(
                        article.content,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium
                            ?.copyWith(
                          fontSize: Responsive.scaleText(context, 14),
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: Responsive.scale(context, 16)),
                ClipRRect(
                  borderRadius:
                  BorderRadius.circular(Responsive.scale(context, 12)),
                  child: _buildSmallImage(context),
                ),
              ],
            ),
            SizedBox(height: Responsive.scale(context, 16)),
            Row(
              children: [
                Flexible(
                  child: Text(
                    article.date,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: Responsive.scaleText(context, 12),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.scale(context, 8),
                  ),
                  child: Text(
                    '•',
                    style: TextStyle(
                      color: AppColors.border,
                      fontSize: Responsive.scaleText(context, 12),
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    article.readtime.replaceAll(
                      'min read',
                      AppLocalizations.of(context)!.minRead,
                    ),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontSize: Responsive.scaleText(context, 12),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.scale(context, 8),
                  ),
                  child: Text(
                    '•',
                    style: TextStyle(
                      color: AppColors.border,
                      fontSize: Responsive.scaleText(context, 12),
                    ),
                  ),
                ),
                Flexible(
                  child: Text(
                    article.source.toUpperCase(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontSize: Responsive.scaleText(context, 10),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallImage(BuildContext context) {
    final double size = Responsive.scale(context, 80);
    final double iconSize = Responsive.scale(context, 24);

    if (article.imageUrl.isEmpty) {
      return Container(
        height: size,
        width: size,
        color: Colors.grey.shade900,
        child: Icon(
          Icons.image_not_supported_outlined,
          color: Colors.white24,
          size: iconSize,
        ),
      );
    }

    final isNetwork = article.imageUrl.startsWith('http');

    if (isNetwork) {
      return Image.network(
        article.imageUrl,
        height: size,
        width: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          height: size,
          width: size,
          color: Colors.grey.shade900,
          child: Icon(
            Icons.broken_image_outlined,
            color: Colors.white24,
            size: iconSize,
          ),
        ),
      );
    } else {
      return Image.asset(
        article.imageUrl,
        height: size,
        width: size,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          height: size,
          width: size,
          color: Colors.grey.shade900,
          child: Icon(
            Icons.broken_image_outlined,
            color: Colors.white24,
            size: iconSize,
          ),
        ),
      );
    }
  }
}