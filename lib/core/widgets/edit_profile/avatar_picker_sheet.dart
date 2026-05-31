import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news/l10n/app_localizations.dart'; // 🔥 Import localization
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/responsive.dart';

class AvatarPickerSheet extends StatelessWidget {
  final List<String> avatars;
  final ValueChanged<String> onAvatarSelected;

  const AvatarPickerSheet({
    super.key,
    required this.avatars,
    required this.onAvatarSelected,
  });

  static Future<void> show(
    BuildContext context, {
    required List<String> avatars,
    required ValueChanged<String> onAvatarSelected,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Responsive.scale(context, 24)),
        ),
      ),
      builder: (_) => AvatarPickerSheet(
        avatars: avatars,
        onAvatarSelected: onAvatarSelected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!; // 🔥 Access translations

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Responsive.scale(context, 20)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                loc.chooseAvatar, // 🔥 Translated label
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.mutedText,
                  fontSize: Responsive.scaleText(context, 12),
                ),
              ),
              SizedBox(height: Responsive.scale(context, 20)),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: Responsive.isMobile(context) ? 3 : 5,
                  crossAxisSpacing: Responsive.scale(context, 16),
                  mainAxisSpacing: Responsive.scale(context, 16),
                ),
                itemCount: avatars.length,
                itemBuilder: (context, index) {
                  final path = avatars[index];
                  return GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);
                      onAvatarSelected(path);

                      // Update Firestore
                      final user = FirebaseAuth.instance.currentUser;
                      if (user != null) {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .update({'avatarUrl': path});
                      }
                    },
                    child: CircleAvatar(
                      backgroundImage: AssetImage(path),
                      backgroundColor: Colors.transparent,
                      radius: Responsive.scale(context, 40),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
