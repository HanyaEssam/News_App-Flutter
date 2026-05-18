import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/background_color/app_background.dart';
import '../../../core/widgets/saved_widgets/empty_saved_state.dart';
import '../../../core/widgets/saved_widgets/save_article_card.dart';
import '../../../core/models/article_model.dart'; // 1. Make sure to import ArticleModel
import '../../../core/utils/saved_articles_manager.dart';

class SaveScreen extends StatelessWidget {
  static const String routeName = '/save';
  const SaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('INSIGHTLY'),
      ),
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Page Title
                Text(
                  'Saved',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 12),

                // 2. Update the listener type signature to look for ArticleModel elements
                ValueListenableBuilder<List<ArticleModel>>(
                  valueListenable: SavedArticlesManager.savedArticles,
                  builder: (context, savedList, child) {

                    bool hasSavedArticles = savedList.isNotEmpty;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Subtitle showing the dynamic count
                        Text(
                          hasSavedArticles
                              ? '${savedList.length} SAVED ARTICLES'
                              : '0 SAVED ARTICLES',
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: AppColors.mutedText,
                          ),
                        ),
                        const SizedBox(height: 32),

                        // Conditional UI Logic
                        if (!hasSavedArticles)
                          const EmptySavedState()
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: savedList.length,
                            itemBuilder: (context, index) {

                              // 3. This is now a clean ArticleModel instance!
                              final article = savedList[index];

                              // 4. Simply pass the entire object directly into the card
                              return SavedArticleCard(
                                article: article,
                              );
                            },
                          ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 40), // Bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }
}