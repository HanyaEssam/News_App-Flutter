import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/saved_articles_manager.dart'; // 1. Import the global manager

class SavedArticleCard extends StatelessWidget {
  final String category;
  final String title;
  final String source;
  final String readTime;
  final String imageUrl;
  final Color categoryColor;

  const SavedArticleCard({
    super.key,
    required this.category,
    required this.title,
    required this.source,
    required this.readTime,
    required this.imageUrl,
    required this.categoryColor,
  });

  @override
  Widget build(BuildContext context) {
    // 2. Re-package this specific card's data into a map so the manager can find it
    final Map<String, String> articleData = {
      'category': category,
      'title': title,
      'source': source,
      'readTime': readTime,
      'imageUrl': imageUrl,
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Image
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              image: DecorationImage(
                image: AssetImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Card Content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Category Text (titleSmall)
                    Text(
                      category.toUpperCase(),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: categoryColor,
                      ),
                    ),

                    // 3. Wrap the icon in the global manager listener
                    ValueListenableBuilder<List<Map<String, String>>>(
                      valueListenable: SavedArticlesManager.savedArticles,
                      builder: (context, savedList, child) {
                        // Check if this article is still present in the global manager list
                        bool isCurrentlySaved = savedList.any((a) => a['title'] == title);

                        return IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(
                            isCurrentlySaved ? Icons.bookmark : Icons.bookmark_border,
                          ),
                          color: isCurrentlySaved ? AppColors.primary : AppColors.mutedText,
                          onPressed: () {
                            // This deletes it from the shared memory bank!
                            SavedArticlesManager.toggleSave(articleData);

                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Article Removed from Saved'),
                                duration: Duration(seconds: 1),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Article Title (headlineSmall)
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),

                // Footer (bodySmall)
                Row(
                  children: [
                    Text(
                      source,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('•', style: TextStyle(color: AppColors.border)),
                    ),
                    Text(
                      readTime,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}