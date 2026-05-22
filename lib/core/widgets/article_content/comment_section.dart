import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/guest_checker.dart';

class CommentsSection extends StatefulWidget {
  final Color categoryColor;
  final String articleId;

  const CommentsSection({
    super.key,
    required this.categoryColor,
    required this.articleId,
  });

  @override
  State<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  final TextEditingController _commentController = TextEditingController();

  Future<void> _postComment() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return;

    final text = _commentController.text.trim();
    if (text.isEmpty) return;

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    final userName = userDoc.data()?['fullName'] ?? 'Anonymous';

    await FirebaseFirestore.instance
        .collection('articles')
        .doc(widget.articleId)
        .collection('comments')
        .add({
      'userId': user.uid,
      'userName': userName,
      'comment': text,
      'createdAt': FieldValue.serverTimestamp(),
    });

    _commentController.clear();
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // 🔹 HEADER
        Row(
          children: [
            Text(
              "Comments",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: widget.categoryColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('articles')
                    .doc(widget.articleId)
                    .collection('comments')
                    .snapshots(),
                builder: (context, snapshot) {
                  final count = snapshot.data?.docs.length ?? 0;

                  return Text(
                    "$count",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: widget.categoryColor,
                    ),
                  );
                },
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // 🔹 INPUT BOX
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
                decoration: const InputDecoration(
                  hintText: "Add a comment...",
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.transparent,
                  contentPadding: EdgeInsets.zero,
                ),
              ),

              const SizedBox(height: 12),

              FilledButton(
                onPressed: () async {
                  if (GuestChecker.checkAndPrompt(context)) return;
                  await _postComment();
                },
                style: FilledButton.styleFrom(
                  backgroundColor: widget.categoryColor,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  "POST COMMENT",
                  style: Theme.of(context)
                      .textTheme
                      .labelSmall
                      ?.copyWith(color: AppColors.darkText),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // 🔥 REAL COMMENTS FROM FIRESTORE
        StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('articles')
              .doc(widget.articleId)
              .collection('comments')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final comments = snapshot.data!.docs;

            if (comments.isEmpty) {
              return const Text("No comments yet");
            }

            return Column(
              children: comments.map((doc) {
                final data = doc.data() as Map<String, dynamic>;

                final name = data['userName'] ?? 'Anonymous';
                final comment = data['comment'] ?? '';

                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      CircleAvatar(
                        backgroundColor:
                        widget.categoryColor.withOpacity(0.8),
                        child: Text(name[0].toUpperCase()),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(comment),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}