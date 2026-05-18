import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/background_color/app_background.dart';
import '../../../core/models/article_model.dart';
import 'package:news/core/widgets/article_content/article_content.dart';
import 'package:news/core/widgets/article_content/comment_section.dart';

class ArticleDetailsScreen extends StatelessWidget {
  static const String routeName = '/article-details';
  final ArticleModel article;

  const ArticleDetailsScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('INSIGHTLY', style: Theme.of(context).textTheme.headlineLarge),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.bookmark_border)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.share_outlined)),
        ],
      ),
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      ArticleContent(article: article),
                      const SizedBox(height: 40),
                      const Divider(color: AppColors.border),
                      const SizedBox(height: 24),
                      CommentsSection(categoryColor: article.categoryColor),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),

              // COMPLETED Button at the bottom
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    backgroundColor: AppColors.cardDark,
                  ),
                  child: Text("COMPLETED", style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}