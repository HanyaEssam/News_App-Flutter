import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../models/article_model.dart';
import '../../../ui/article_details/article_details_screen.dart';
import '../bookmark/bookmark_button.dart';
import 'package:news/l10n/app_localizations.dart';
import '../../../../core/utils/responsive.dart';

class FeedArticleCard extends StatelessWidget {
  final ArticleModel article;

  const FeedArticleCard({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: Responsive.scale(context, 24)),
      child: InkWell(
        borderRadius: BorderRadius.circular(Responsive.scale(context, 20)),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleDetailsScreen(article: article),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(Responsive.scale(context, 20)),
            border: Border.all(
              color: theme.colorScheme.primary.withOpacity(0.25),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: Responsive.scale(context, 200),
                decoration: BoxDecoration(
                  color: Colors.grey.shade900,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(Responsive.scale(context, 20)),
                  ),
                  image: article.imageUrl.isNotEmpty
                      ? DecorationImage(
                    image: article.imageUrl.startsWith('http')
                        ? NetworkImage(article.imageUrl) as ImageProvider
                        : AssetImage(article.imageUrl),
                    fit: BoxFit.cover,
                  )
                      : null,
                ),
                child: article.imageUrl.isEmpty
                    ? Center(
                  child: Icon(
                    Icons.image_not_supported,
                    color: Colors.white24,
                    size: Responsive.scale(context, 50),
                  ),
                )
                    : null,
              ),
              Padding(
                padding: EdgeInsets.all(Responsive.scale(context, 16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(Responsive.scale(context, 6)),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(
                              Responsive.scale(context, 8),
                            ),
                          ),
                          child: Icon(
                            Icons.article,
                            size: Responsive.scale(context, 16),
                            color: article.categoryColor,
                          ),
                        ),
                        SizedBox(width: Responsive.scale(context, 12)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article.source,
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontSize: Responsive.scaleText(context, 12),
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.mainSource.toUpperCase(),
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontSize: Responsive.scaleText(context, 10),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: Responsive.scale(context, 12)),
                    Text(
                      article.title,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontSize: Responsive.scaleText(context, 18),
                      ),
                    ),
                    SizedBox(height: Responsive.scale(context, 8)),
                    Text(
                      article.content,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: Responsive.scaleText(context, 14),
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: Responsive.scale(context, 16)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              article.readtime
                                  .replaceAll(
                                'min read',
                                AppLocalizations.of(context)!.minRead,
                              )
                                  .toUpperCase(),
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontSize: Responsive.scaleText(context, 10),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: Responsive.scale(context, 8),
                              ),
                              child: Text(
                                '•',
                                style: TextStyle(
                                  fontSize: Responsive.scaleText(context, 12),
                                  color: theme.colorScheme.primary
                                      .withOpacity(0.5),
                                ),
                              ),
                            ),
                            Text(
                              article.date.toUpperCase(),
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontSize: Responsive.scaleText(context, 10),
                              ),
                            ),
                          ],
                        ),
                        BookmarkButton(
                          article: article,
                          unselectedColor: theme.textTheme.bodySmall?.color ??
                              AppColors.lightMutedText,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}