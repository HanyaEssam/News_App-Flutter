import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/article_model.dart';
import 'package:news/ui/article_details/article_details_screen.dart';
import '../../../core/utils/saved_articles_manager.dart';
import '../bookmark/bookmark_button.dart';

class ForYouCard extends StatelessWidget {
  final String label;
  final String title;
  final String description;
  final String time;
  final String readTime;
  final String source;
  final String imageUrl;

  const ForYouCard({
    super.key,
    required this.label,
    required this.title,
    required this.description,
    required this.time,
    required this.readTime,
    required this.source,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    // 1. Create the unified ArticleModel instance here so everything can use it
    final articleModel = ArticleModel(
      title: title,
      content: '$description\n\nHere is the rest of the full article content explaining the details in depth...',
      category: label.replaceAll('Based on your interest in ', '').replaceAll('Discovery of the week', 'Discovery'),
      categoryColor: AppColors.blue, // Or use a dynamic color map if needed
      source: source,
      date: 'Oct 24, 2023', // Dummy date
      time: time,
      imageUrl: imageUrl,
      readtime: readTime,
    );

    return InkWell(
      onTap: () {
        // 2. Simply pass the created articleModel here
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
          color: Theme.of(context).colorScheme.surface, // CHANGED
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.25), // CHANGED
          ),        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.lightbulb_outline, size: 16, color: AppColors.blue),
                    const SizedBox(width: 8),
                    Text(
                      label.toUpperCase(),
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.blue,
                      ),
                    ),
                  ],
                ),

                // 3. Update the listenable type to expect ArticleModel elements
                BookmarkButton(
                  article: articleModel,
                  unselectedColor: AppColors.mutedText, // Uses muted/grey color inside cards
                ),              ],
            ),
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
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(time, style: Theme.of(context).textTheme.bodySmall),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('•', style: TextStyle(color: AppColors.border)),
                ),
                Text(readTime, style: Theme.of(context).textTheme.bodySmall),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('•', style: TextStyle(color: AppColors.border)),
                ),
                Text(
                  source.toUpperCase(),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface, // CHANGED
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}