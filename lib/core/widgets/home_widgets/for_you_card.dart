import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/article_model.dart';
import 'package:news/ui/article_details/article_details_screen.dart';
import '../bookmark/bookmark_button.dart';
import 'package:news/l10n/app_localizations.dart';

class ForYouCard extends StatelessWidget {
  final String label;
  final ArticleModel article; // ✅ We now accept the FULL article model!

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
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
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
                        size: 16,
                        color: article.categoryColor,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          label.toUpperCase(),
                          style: Theme.of(context).textTheme.labelSmall
                              ?.copyWith(color: article.categoryColor),
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
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        article.title, // ✅ Using article data directly
                        style: Theme.of(context).textTheme.headlineSmall,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        article.content, // ✅ Using article data directly
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: _buildSmallImage(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Flexible(
                  child: Text(
                    article
                        .date, // ✅ This will now show the clean, formatted API date!
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('•', style: TextStyle(color: AppColors.border)),
                ),
                Flexible(
                  child: Text(
                    article.readtime.replaceAll(
                      'min read',
                      AppLocalizations.of(context)!.minRead,
                    ),
                    style: Theme.of(context).textTheme.bodySmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('•', style: TextStyle(color: AppColors.border)),
                ),
                Flexible(
                  child: Text(
                    article.source.toUpperCase(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
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

  Widget _buildSmallImage() {
    if (article.imageUrl.isEmpty) {
      return Container(
        height: 80,
        width: 80,
        color: Colors.grey.shade900,
        child: const Icon(
          Icons.image_not_supported_outlined,
          color: Colors.white24,
          size: 24,
        ),
      );
    }

    final isNetwork = article.imageUrl.startsWith('http');
    if (isNetwork) {
      return Image.network(
        article.imageUrl,
        height: 80,
        width: 80,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 80,
          width: 80,
          color: Colors.grey.shade900,
          child: const Icon(
            Icons.broken_image_outlined,
            color: Colors.white24,
            size: 24,
          ),
        ),
      );
    } else {
      return Image.asset(
        article.imageUrl,
        height: 80,
        width: 80,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => Container(
          height: 80,
          width: 80,
          color: Colors.grey.shade900,
          child: const Icon(
            Icons.broken_image_outlined,
            color: Colors.white24,
            size: 24,
          ),
        ),
      );
    }
  }
}
