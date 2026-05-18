import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/article_model.dart';
import 'package:news/ui/article_details/article_details_screen.dart';
import '../../../core/utils/saved_articles_manager.dart';

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
    // Package the article data for the global manager
    final Map<String, String> articleData = {
      'category': label,
      'title': title,
      'source': source,
      'readTime': readTime,
      'imageUrl': imageUrl,
    };

    return InkWell(
      onTap: () {
        // Kept your navigation logic!
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailsScreen(
              article: ArticleModel(
                title: title,
                content: '$description\n\nHere is the rest of the full article content explaining the details in depth...',
                category: label.replaceAll('Based on your interest in ', '').replaceAll('Discovery of the week', 'Discovery'),
                categoryColor: AppColors.blue,
                source: source,
                date: 'Oct 24, 2023', // Dummy date
                time: time,
                imageUrl: imageUrl, // Now using the dynamic image URL
              ),
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(20),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border.withOpacity(0.5)),
        ),
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

                // Listening to Farida's global manager
                ValueListenableBuilder<List<Map<String, String>>>(
                    valueListenable: SavedArticlesManager.savedArticles,
                    builder: (context, savedList, child) {
                      // Check if THIS article's title exists in the global saved list
                      bool isCurrentlySaved = savedList.any((a) => a['title'] == title);

                      return IconButton(
                        icon: Icon(
                          isCurrentlySaved ? Icons.bookmark : Icons.bookmark_border,
                        ),
                        color: isCurrentlySaved ? AppColors.primary : AppColors.mutedText,
                        onPressed: () {
                          // Tell the manager to add or remove this article
                          SavedArticlesManager.toggleSave(articleData);

                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(isCurrentlySaved ? 'Removed from Saved' : 'Article Saved!'),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        },
                      );
                    }
                ),
              ],
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
                      image: AssetImage(imageUrl), // Using the dynamic imageUrl variable
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
                    color: AppColors.white,
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