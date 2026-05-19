import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

import '../../models/article_model.dart';
import '../../../ui/article_details/article_details_screen.dart';
import '../../utils/saved_articles_manager.dart';
import '../bookmark/bookmark_button.dart';

class FeedArticleCard extends StatefulWidget {
  final String category;
  final String title;
  final String source;
  final String readTime;
  final String imageUrl;
  final Color categoryColor;

  final String? description;
  final String? timeAgo;

  const FeedArticleCard({
    super.key,
    required this.category,
    required this.title,
    required this.source,
    required this.readTime,
    required this.imageUrl,
    required this.categoryColor,
    this.description,
    this.timeAgo,
  });

  @override
  State<FeedArticleCard> createState() => _FeedArticleCardState();
}

class _FeedArticleCardState extends State<FeedArticleCard> {
  bool isSaved = false;


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context); // CHANGED

    final articleModel = ArticleModel(
      title: widget.title,
      content:
      '${widget.description ?? "Full article text goes here..."}\n\nThis is the detailed view of the article retrieved directly from the ${widget.category} category feed.',
      category: widget.category,
      categoryColor: widget.categoryColor,
      source: widget.source,
      date: 'Oct 24, 2023',
      time: widget.timeAgo ?? 'Just now',
      imageUrl: widget.imageUrl,
      readtime: widget.readTime,
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleDetailsScreen(
                article: articleModel,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: theme.colorScheme.surface, // CHANGED
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.colorScheme.primary.withOpacity(0.25), // CHANGED
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(20)),
                  image: DecorationImage(
                    image: NetworkImage(widget.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary.withOpacity(0.15), // CHANGED
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.article,
                            size: 16,
                            color: widget.categoryColor,
                          ),
                        ),

                        const SizedBox(width: 12),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.source,
                              style: theme.textTheme.bodySmall,
                            ),

                            if (widget.description != null)
                              Text(
                                'MAIN SOURCE',
                                style: theme.textTheme.labelSmall,
                              ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Text(
                      widget.title,
                      style: theme.textTheme.headlineSmall,
                    ),

                    if (widget.description != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        widget.description!,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],

                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.readTime.toUpperCase(),
                              style: theme.textTheme.labelSmall,
                            ),

                            if (widget.timeAgo != null) ...[
                              Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  '•',
                                  style: TextStyle(
                                    color: theme.colorScheme.primary.withOpacity(0.5), // CHANGED
                                  ),
                                ),
                              ),

                              Text(
                                widget.timeAgo!.toUpperCase(),
                                style: theme.textTheme.labelSmall,
                              ),
                            ],
                          ],
                        ),

                        BookmarkButton(
                          article: articleModel,
                          unselectedColor:
                          theme.textTheme.bodySmall?.color ??
                              AppColors.lightMutedText, // CHANGED
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