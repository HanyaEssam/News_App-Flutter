import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/background_color/app_background.dart';
import '../../../core/models/article_model.dart';
import 'package:news/core/widgets/article_content/article_content.dart';
import 'package:news/core/widgets/article_content/comment_section.dart';
import '../../core/widgets/bookmark/bookmark_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ArticleDetailsScreen extends StatefulWidget {
  static const String routeName = '/article-details';
  final ArticleModel article;

  const ArticleDetailsScreen({super.key, required this.article});

  @override
  State<ArticleDetailsScreen> createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  Future<void> _markArticleAsCompleted() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final userRef =
    FirebaseFirestore.instance.collection('users').doc(user.uid);

    try {
      await userRef.update({
        'articlesRead': FieldValue.increment(1),

        // optional (remove if you don't want it)
        'minutesSaved': FieldValue.increment(5),
      });
    } catch (e) {
      debugPrint("Error updating read count: $e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('INSIGHTLY'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: BookmarkButton(
              article: widget.article,
              unselectedColor: AppColors.mutedText, // White when unselected for the appBar
            ),
          ),
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
                      ArticleContent(article: widget.article),
                      const SizedBox(height: 40),
                      const Divider(color: AppColors.border),
                      const SizedBox(height: 24),
                      CommentsSection(article: widget.article),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),

              //  Button at the bottom
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: FilledButton(
                  onPressed: () async {
                    await _markArticleAsCompleted();
                    if (context.mounted) {
                      Navigator.pop(context);
                    }
                  },
                  style: FilledButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    backgroundColor: Theme.of(context).colorScheme.surface,
                  ),
                  child: Text("COMPLETED", style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}