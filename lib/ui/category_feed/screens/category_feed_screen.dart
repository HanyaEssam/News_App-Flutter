import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/background_color/app_background.dart';
import 'package:news/core/widgets/category_feed_widgets/feed_article_card.dart';

class CategoryFeedScreen extends StatelessWidget {
  final String categoryName;
  final Color categoryColor;

  const CategoryFeedScreen({
    super.key,
    required this.categoryName,
    required this.categoryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: AppColors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'INSIGHTLY',
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      Text(
                        '${categoryName.toUpperCase()} INTELLIGENCE',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: categoryColor,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$categoryName Feed',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 32),

                      FeedArticleCard(
                        category: categoryName,
                        categoryColor: categoryColor,
                        title: 'The Revolution of High-Altitude Performance Training',
                        source: 'Global Athletics',
                        readTime: '12 Min Read',
                        timeAgo: '2 Hours Ago',
                        description: 'New wave analytics indicate an increase in pushing biological boundaries through curated oxygen exposure...',
                        imageUrl: 'https://images.unsplash.com/photo-1517649763962-0c623066013b?q=80&w=2070&auto=format&fit=crop',
                      ),


                      FeedArticleCard(
                        category: categoryName,
                        categoryColor: categoryColor,
                        title: 'Urban Mobility: The Rise of Professional City Circuits',
                        source: 'The Daily Sprint',
                        readTime: '6 Min Read',
                        imageUrl: 'https://images.unsplash.com/photo-1541625602330-2277a4c46182?q=80&w=2070&auto=format&fit=crop',
                      ),

                      FeedArticleCard(
                        category: categoryName,
                        categoryColor: categoryColor,
                        title: 'Precision Analytics: How Data is Redefining the Three-Point Line',
                        source: 'Hoop Central',
                        readTime: '9 Min Read',
                        imageUrl: 'https://images.unsplash.com/photo-1546519638-68e109498ffc?q=80&w=2090&auto=format&fit=crop',
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}