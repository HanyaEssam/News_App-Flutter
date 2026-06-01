import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/models/article_model.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/background_color/app_background.dart';
import 'package:news/core/widgets/article_content/article_content.dart';
import 'package:news/core/widgets/article_content/comment_section.dart';
import '../../core/widgets/bookmark/bookmark_button.dart';

class ArticleDetailsScreen extends StatefulWidget {
  static const String routeName = '/article-details';
  final ArticleModel article;

  const ArticleDetailsScreen({super.key, required this.article});

  @override
  State<ArticleDetailsScreen> createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  // 🔥 METHOD IS NOW INSIDE THE CLASS SCOPE
  Future<void> _markArticleAsCompleted() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final userRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid);
    final articleTitle = widget.article.title;
    final articleCategory = widget.article.category.toLowerCase();

    try {
      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final snapshot = await transaction.get(userRef);
        if (!snapshot.exists) return;

        List<dynamic> readArticlesList =
            snapshot.data()?['readArticlesList'] ?? [];
        Map<String, dynamic> categoryCounts =
            snapshot.data()?['categoryCounts'] ?? {};

        if (!readArticlesList.contains(articleTitle)) {
          readArticlesList.add(articleTitle);
          categoryCounts[articleCategory] =
              (categoryCounts[articleCategory] ?? 0) + 1;

          transaction.update(userRef, {
            'readArticlesList': readArticlesList,
            'articlesRead': readArticlesList.length,
            'categoryCounts': categoryCounts,
          });
        }
      });
    } catch (e) {
      debugPrint("Error updating read count: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          loc.appTitle.toUpperCase(),
          style: TextStyle(fontSize: Responsive.scaleText(context, 18)),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: Responsive.scale(context, 12)),
            child: BookmarkButton(
              article: widget.article,
              unselectedColor: AppColors.mutedText,
            ),
          ),
        ],
      ),
      body: AppBackground(
        child: SafeArea(
          bottom: true,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: Responsive.maxWidth(context),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.scale(context, 24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ArticleContent(article: widget.article),
                    SizedBox(height: Responsive.scale(context, 40)),
                    const Divider(color: AppColors.border),
                    SizedBox(height: Responsive.scale(context, 24)),
                    CommentsSection(article: widget.article),
                    SizedBox(height: Responsive.scale(context, 40)),
                    FilledButton(
                      onPressed: () async {
                        await _markArticleAsCompleted();
                        if (context.mounted) Navigator.pop(context);
                      },
                      style: FilledButton.styleFrom(
                        minimumSize: Size(
                          double.infinity,
                          Responsive.scale(context, 56),
                        ),
                        backgroundColor: Theme.of(context).colorScheme.surface,
                      ),
                      child: Text(
                        loc.completed,
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: Responsive.scaleText(context, 12),
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.scale(context, 20)),
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
