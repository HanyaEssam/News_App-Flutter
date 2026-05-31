import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/models/article_model.dart';
import '../../../../core/utils/guest_checker.dart';
import '../../../../core/utils/responsive.dart';

class CommentsSection extends StatefulWidget {
  final ArticleModel article;

  const CommentsSection({super.key, required this.article});

  @override
  State<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  final TextEditingController _commentController = TextEditingController();
  bool _isPosting = false;

  String _getInitials(String name) {
    if (name.isEmpty) return "U";
    List<String> parts = name.trim().split(" ");
    if (parts.length > 1 && parts[1].isNotEmpty) {
      return "${parts[0][0]}${parts[1][0]}".toUpperCase();
    }
    return name.substring(0, 1).toUpperCase();
  }

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
      String userName = "Reader";
      String avatarUrl = "";

      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      if (userDoc.exists && userDoc.data() != null) {
        final data = userDoc.data()!;
        userName = data['fullName'] ?? data['name'] ?? userName;
        avatarUrl = data['avatarUrl'] ?? '';
      } else if (user.displayName != null && user.displayName!.isNotEmpty) {
        userName = user.displayName!;
      } else if (user.email != null) {
        userName = user.email!.split('@')[0];
      }

      await FirebaseFirestore.instance.collection('comments').add({
        'articleTitle': widget.article.title,
        'userId': user.uid,
        'userName': userName,
        'avatarUrl': avatarUrl,
        'text': text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      _commentController.clear();
      if (mounted) FocusScope.of(context).unfocus();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to post comment: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isPosting = false);
    }
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  Widget _buildAvatar(String avatarUrl, String userName, Color fallbackColor) {
    final double size = Responsive.scale(context, 44);
    final double radius = Responsive.scale(context, 12);

    if (avatarUrl.isEmpty) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: fallbackColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(radius),
        ),
        alignment: Alignment.center,
        child: Text(
          _getInitials(userName),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: Responsive.scaleText(context, 11),
          ),
        ),
      );
    }

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(radius),
        image: DecorationImage(
          image: avatarUrl.startsWith('http')
              ? NetworkImage(avatarUrl) as ImageProvider
              : AssetImage(avatarUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.article.categoryColor;

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('comments')
          .where('articleTitle', isEqualTo: widget.article.title)
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        int commentCount = snapshot.hasData ? snapshot.data!.docs.length : 0;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Comments",
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: Responsive.scaleText(context, 22),
                  ),
                ),
                SizedBox(width: Responsive.scale(context, 12)),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.scale(context, 12),
                    vertical: Responsive.scale(context, 6),
                  ),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.15),
                    borderRadius:
                    BorderRadius.circular(Responsive.scale(context, 12)),
                  ),
                  child: Text(
                    "$commentCount",
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: color,
                      fontSize: Responsive.scaleText(context, 10),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Responsive.scale(context, 24)),
            Container(
              padding: EdgeInsets.all(Responsive.scale(context, 16)),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius:
                BorderRadius.circular(Responsive.scale(context, 16)),
                border: Border.all(color: AppColors.border.withOpacity(0.5)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    controller: _commentController,
                    maxLines: 3,
                    minLines: 2,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: Responsive.scaleText(context, 14),
                    ),
                    decoration: InputDecoration(
                      hintText: "Add to the briefing...",
                      hintStyle:
                      Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: Responsive.scaleText(context, 14),
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      fillColor: Colors.transparent,
                      filled: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                  SizedBox(height: Responsive.scale(context, 12)),
                  FilledButton(
                    onPressed: _isPosting
                        ? null
                        : () {
                      if (GuestChecker.checkAndPrompt(context)) return;
                      _postComment();
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor:
                      Theme.of(context).colorScheme.primary,
                      foregroundColor:
                      Theme.of(context).colorScheme.onPrimary,
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.scale(context, 24),
                        vertical: Responsive.scale(context, 14),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          Responsive.scale(context, 12),
                        ),
                      ),
                    ),
                    child: _isPosting
                        ? SizedBox(
                      width: Responsive.scale(context, 16),
                      height: Responsive.scale(context, 16),
                      child: const CircularProgressIndicator(
                        color: AppColors.darkText,
                        strokeWidth: 2,
                      ),
                    )
                        : Text(
                      "POST COMMENT",
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(
                        color: AppColors.darkText,
                        fontSize: Responsive.scaleText(context, 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: Responsive.scale(context, 32)),
            if (!snapshot.hasData)
              const Center(child: CircularProgressIndicator())
            else if (snapshot.data!.docs.isEmpty)
              Padding(
                padding: EdgeInsets.symmetric(
                  vertical: Responsive.scale(context, 20),
                ),
                child: Text(
                  "No comments yet. Be the first to share your thoughts!",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.mutedText,
                    fontSize: Responsive.scaleText(context, 14),
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                separatorBuilder: (context, index) =>
                    SizedBox(height: Responsive.scale(context, 24)),
                itemBuilder: (context, index) {
                  var data = snapshot.data!.docs[index].data()
                  as Map<String, dynamic>;

                  String userName = data['userName'] ?? 'Reader';
                  String text = data['text'] ?? '';
                  String avatarUrl = data['avatarUrl'] ?? '';
                  Timestamp? timestamp = data['timestamp'] as Timestamp?;

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildAvatar(avatarUrl, userName, color),
                      SizedBox(width: Responsive.scale(context, 16)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  userName,
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                    color: AppColors.white,
                                    fontSize:
                                    Responsive.scaleText(context, 13),
                                  ),
                                ),
                                SizedBox(width: Responsive.scale(context, 12)),
                                Text(
                                  _getTimeAgo(timestamp),
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                    fontSize:
                                    Responsive.scaleText(context, 10),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Responsive.scale(context, 8)),
                            Text(
                              text,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                fontSize:
                                Responsive.scaleText(context, 14),
                              ),
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