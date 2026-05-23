import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/background_color/app_background.dart';
import '../../../core/widgets/saved_widgets/empty_saved_state.dart';
import '../../../core/widgets/saved_widgets/save_article_card.dart';
import '../../../core/models/article_model.dart';
import '../../../core/utils/saved_articles_manager.dart';
import 'package:news/l10n/app_localizations.dart';
// 🔥 IMPORTS:
import '../../../core/utils/guest_checker.dart';
import '../../../core/widgets/guest/guest_widget.dart';

class SaveScreen extends StatelessWidget {
  static const String routeName = '/save';
  const SaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 🔥 Intercept Guests
    if (GuestChecker.isGuest()) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Text(AppLocalizations.of(context)!.appTitle.toUpperCase()),
        ),
        body: AppBackground(
          child: const GuestWidget(
            icon: Icons.bookmark_outline,
            title: 'Your Private Library',
            subtitle:
                'Create an account to bookmark articles and build your curated intelligence feed.',
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(AppLocalizations.of(context)!.appTitle.toUpperCase()),
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
                  AppLocalizations.of(context)!.savedPageTitle,
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 12),

                ValueListenableBuilder<List<ArticleModel>>(
                  valueListenable: SavedArticlesManager.savedArticles,
                  builder: (context, savedList, child) {
                    bool hasSavedArticles = savedList.isNotEmpty;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppLocalizations.of(context)!
                              .savedArticlesCount(savedList.length.toString())
                              .toUpperCase(),
                          style: Theme.of(context).textTheme.labelMedium
                              ?.copyWith(color: AppColors.mutedText),
                        ),
                        const SizedBox(height: 32),

                        if (!hasSavedArticles)
                          const EmptySavedState()
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: savedList.length,
                            itemBuilder: (context, index) {
                              final article = savedList[index];

                              return SavedArticleCard(article: article);
                            },
                          ),
                      ],
                    );
                  },
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
