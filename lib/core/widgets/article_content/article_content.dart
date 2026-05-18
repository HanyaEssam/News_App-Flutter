import 'package:flutter/material.dart';
import '../../../core/models/article_model.dart';
import '../../../core/theme/app_colors.dart';

class ArticleContent extends StatelessWidget {
  final ArticleModel article;

  const ArticleContent({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Category, Source, Date and Time Row
        Row(
          children: [
            Text(
              article.category.toUpperCase(),
              style: Theme.of(context).textTheme.titleSmall?.copyWith(color: article.categoryColor),
            ),
            const Spacer(),
            Text(
              "${article.date}  •  ${article.time}",
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(article.source.toUpperCase(), style: Theme.of(context).textTheme.labelSmall),
        const SizedBox(height: 24),

        // Main Title (displayMedium)
        Text(article.title, style: Theme.of(context).textTheme.displayMedium),
        const SizedBox(height: 24),

        // Article Image
        Container(
          height: 220,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(image: AssetImage(article.imageUrl), fit: BoxFit.cover),
          ),
        ),
        const SizedBox(height: 24),

        // Article Paragraphs (bodyLarge)
        Text(article.content, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}