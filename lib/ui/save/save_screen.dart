import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/background_color/app_background.dart';
import '../../../core/widgets/saved_widgets/empty_saved_state.dart';
import '../../../core/widgets/saved_widgets/save_article_card.dart';
import '../../../core/models/article_model.dart';
import '../../../core/utils/saved_articles_manager.dart';
import '../../../core/utils/responsive.dart';
import 'package:news/l10n/app_localizations.dart';
import '../../../core/utils/guest_checker.dart';
import '../../../core/widgets/guest/guest_widget.dart';

class SaveScreen extends StatelessWidget {
  static const String routeName = '/save';
  const SaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (GuestChecker.isGuest()) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Text(AppLocalizations.of(context)!.appTitle.toUpperCase()),
        ),
        body: AppBackground(
          child:  GuestWidget(
            icon: Icons.bookmark_outline,
            title: AppLocalizations.of(context)!.guestLibraryTitle,
            subtitle: AppLocalizations.of(context)!.guestLibrarySubtitle,
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
          bottom: true,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: Responsive.maxWidth(context)),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: Responsive.scale(context, 24),
                  right: Responsive.scale(context, 24),
                  bottom: Responsive.scale(context, 20),
                ),                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Responsive.scale(context, 20)),

                    Text(
                      AppLocalizations.of(context)!.savedPageTitle,
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontSize: Responsive.scaleText(context, 32),
                      ),
                    ),
                    SizedBox(height: Responsive.scale(context, 12)),

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
                              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                                color: AppColors.mutedText,
                                fontSize: Responsive.scaleText(context, 12),
                              ),
                            ),
                            SizedBox(height: Responsive.scale(context, 32)),

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

                    SizedBox(height: Responsive.scale(context, 40)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}