import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/models/article_model.dart';
import '../../../../core/utils/guest_checker.dart';

class CommentsSection extends StatefulWidget {
  final ArticleModel article;

  const CommentsSection({super.key, required this.article});

  @override
  State<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  final TextEditingController _commentController = TextEditingController();
  bool _isPosting = false;

  // Helper to get user initials for the avatar
  String _getInitials(String name) {
    if (name.isEmpty) return "U";
    List<String> parts = name.trim().split(" ");
    if (parts.length > 1 && parts[1].isNotEmpty) {
      return "${parts[0][0]}${parts[1][0]}".toUpperCase();
    }
    return name.substring(0, 1).toUpperCase();
  }

  // Helper to format timestamps to "2H AGO"
  String _getTimeAgo(Timestamp? timestamp) {
    if (timestamp == null) return 'JUST NOW';
    final diff = DateTime.now().difference(timestamp.toDate());
    if (diff.inDays > 0) return '${diff.inDays}D AGO';
    if (diff.inHours > 0) return '${diff.inHours}H AGO';
    if (diff.inMinutes > 0) return '${diff.inMinutes}M AGO';
    return 'JUST NOW';
  }

  Future<void> _postComment() async {
    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() => _isPosting = true);

    try {
      // Fetch user's name from Firestore, or fallback to email/default
      String userName = "Reader";
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDoc.exists && userDoc.data() != null && userDoc.data()!['name'] != null) {
        userName = userDoc.data()!['name'];
      } else if (user.displayName != null && user.displayName!.isNotEmpty) {
        userName = user.displayName!;
      } else if (user.email != null) {
        userName = user.email!.split('@')[0];
      }

      await FirebaseFirestore.instance.collection('comments').add({
        // ✅ CHANGED: Now linking the comment to the article's title instead of URL
        'articleTitle': widget.article.title,
        'userId': user.uid,
        'userName': userName,
        'text': text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      _commentController.clear();
      FocusScope.of(context).unfocus(); // Close keyboard
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to post comment: $e')),
      );
    } finally {
      setState(() => _isPosting = false);
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.article.categoryColor;

    return StreamBuilder<QuerySnapshot>(
      // ✅ CHANGED: Listening for comments matching this article's title
      stream: FirebaseFirestore.instance
          .collection('comments')
          .where('articleTitle', isEqualTo: widget.article.title)
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {

        // Count comments
        int commentCount = 0;
        if (snapshot.hasData) {
          commentCount = snapshot.data!.docs.length;
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER & COUNTER
            Row(
              children: [
                Text("Comments", style: Theme.of(context).textTheme.headlineMedium),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    "$commentCount",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(color: color),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // INPUT FIELD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.cardDark,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border.withOpacity(0.5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _commentController,
                    maxLines: 3,
                    minLines: 2,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                      hintText: "Add to the briefing...",
                      hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.mutedText),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      fillColor: Colors.transparent,
                      filled: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  const SizedBox(height: 12),

                  FilledButton(
                    onPressed: _isPosting
                        ? null
                        : () {
                      if (GuestChecker.checkAndPrompt(context)) return;
                      _postComment();
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: color,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: _isPosting
                        ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(color: AppColors.darkText, strokeWidth: 2)
                    )
                        : Text(
                      "POST COMMENT",
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.darkText),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // COMMENTS LIST
            if (!snapshot.hasData)
              const Center(child: CircularProgressIndicator())
            else if (snapshot.data!.docs.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "No comments yet. Be the first to share your thoughts!",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: AppColors.mutedText),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                separatorBuilder: (context, index) => const SizedBox(height: 24),
                itemBuilder: (context, index) {
                  var doc = snapshot.data!.docs[index];
                  var data = doc.data() as Map<String, dynamic>;

                  String userName = data['userName'] ?? 'Reader';
                  String text = data['text'] ?? '';
                  Timestamp? timestamp = data['timestamp'] as Timestamp?;

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          _getInitials(userName),
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: AppColors.darkText),
                        ),
                      ),
                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  userName,
                                  style: Theme.of(context).textTheme.titleSmall?.copyWith(color: AppColors.white),
                                ),
                                const SizedBox(width: 12),
                                Text(
                                    _getTimeAgo(timestamp),
                                    style: Theme.of(context).textTheme.labelSmall
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              text,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
          ],
        );
      },
    );
  }
}