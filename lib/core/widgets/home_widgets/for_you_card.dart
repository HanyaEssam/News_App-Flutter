import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/article_model.dart';
import 'package:news/ui/article_details/article_details_screen.dart';
import '../bookmark/bookmark_button.dart';

class ForYouCard extends StatelessWidget {
  final String label;
  final String title;
  final String description;
  final String time;
  final String readTime;
  final String source;
  final String imageUrl;
  final Color categoryColor; // ✅ Added this line

  const ForYouCard({
    super.key,
    required this.label,
    required this.title,
    required this.description,
    required this.time,
    required this.readTime,
    required this.source,
    required this.imageUrl,
    required this.categoryColor, // ✅ Added to constructor
  });

  @override
  Widget build(BuildContext context) {
    // Build ArticleModel from params
    final articleModel = ArticleModel(
      title: title,
      content:
      '$description\n\nHere is the rest of the full article content explaining the details in depth...',
      category: label
          .replaceAll('Based on your interest in ', '')
          .replaceAll('Discovery of the week', 'Discovery'),
      categoryColor: categoryColor, // ✅ Replaced AppColors.blue with categoryColor
      source: source,
      date: 'Oct 24, 2023',
      time: time,
      imageUrl: imageUrl,
      readtime: readTime,
    );

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailsScreen(article: articleModel),
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
                      // ✅ Removed "const" from Icon and used categoryColor
                      Icon(Icons.lightbulb_outline,
                          size: 16, color: categoryColor),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          label.toUpperCase(),
                          style:
                          Theme.of(context).textTheme.labelSmall?.copyWith(
                            color: categoryColor, // ✅ Replaced AppColors.blue with categoryColor
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                BookmarkButton(
                  article: articleModel,
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
                        title,
                        style: Theme.of(context).textTheme.headlineSmall,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                // 🔥 Smart image: network OR asset
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
                    time,
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
                    readTime,
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
                    source.toUpperCase(),
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

  // Smart image builder — handles network URLs and asset paths
  Widget _buildSmallImage() {
    if (imageUrl.isEmpty) {
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

    final isNetwork =
        imageUrl.startsWith('http://') || imageUrl.startsWith('https://');

    if (isNetwork) {
      return Image.network(
        imageUrl,
        height: 80,
        width: 80,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 80,
            width: 80,
            color: Colors.grey.shade900,
            child: const Icon(
              Icons.broken_image_outlined,
              color: Colors.white24,
              size: 24,
            ),
          );
        },
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return Container(
            height: 80,
            width: 80,
            color: Colors.grey.shade900,
            child: const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        },
      );
    } else {
      return Image.asset(
        imageUrl,
        height: 80,
        width: 80,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 80,
            width: 80,
            color: Colors.grey.shade900,
            child: const Icon(
              Icons.broken_image_outlined,
              color: Colors.white24,
              size: 24,
            ),
          );
        },
      );
    }
  }
}