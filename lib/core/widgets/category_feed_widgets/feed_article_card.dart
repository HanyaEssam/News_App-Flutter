import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

import '../../models/article_model.dart';
import '../../../ui/article_details/article_details_screen.dart';

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
    return Padding(
      // External padding to separate the cards from each other
      padding: const EdgeInsets.only(bottom: 24.0),

      // 1. WRAP THE CONTAINER IN AN INKWELL TO MAKE THE WHOLE CARD CLICKABLE
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          // 2. NAVIGATE TO THE DETAILS SCREEN
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleDetailsScreen(
                article: ArticleModel(
                  title: widget.title,
                  // If there is no description, we provide a default text
                  content: '${widget.description ?? "Full article text goes here..."}\n\nThis is the detailed view of the article retrieved directly from the ${widget.category} category feed.',
                  category: widget.category,
                  categoryColor: widget.categoryColor,
                  source: widget.source,
                  date: 'Oct 24, 2023', // Dummy date since the feed card doesn't pass one
                  time: widget.timeAgo ?? 'Just now',
                  imageUrl: widget.imageUrl,
                ),
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.cardDark,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.border.withOpacity(0.5)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Article Image (Top corners match the card container frame)
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                  image: DecorationImage(
                    image: NetworkImage(widget.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // 2. Card Content Panel (Interior padding so text never touches the frame edges)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Source Row
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: AppColors.inputFill,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(Icons.article, size: 16, color: widget.categoryColor),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.source, style: Theme.of(context).textTheme.bodySmall),
                            if (widget.description != null)
                              Text('MAIN SOURCE', style: Theme.of(context).textTheme.labelSmall),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Title
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),

                    // Description (Conditional)
                    if (widget.description != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        widget.description!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],

                    const SizedBox(height: 16),

                    // Footer Actions Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.readTime.toUpperCase(),
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                            if (widget.timeAgo != null) ...[
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text('•', style: TextStyle(color: AppColors.border)),
                              ),
                              Text(
                                widget.timeAgo!.toUpperCase(),
                                style: Theme.of(context).textTheme.labelSmall,
                              ),
                            ],
                          ],
                        ),

                        // Local state toggle bookmark button
                        InkWell(
                          onTap: () {
                            setState(() {
                              isSaved = !isSaved;
                            });
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(isSaved ? 'Article Saved!' : 'Removed from Saved'),
                                duration: const Duration(seconds: 1),
                              ),
                            );
                          },
                          child: Icon(
                            isSaved ? Icons.bookmark : Icons.bookmark_border,
                            color: isSaved ? AppColors.primary : AppColors.mutedText,
                            size: 24,
                          ),
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