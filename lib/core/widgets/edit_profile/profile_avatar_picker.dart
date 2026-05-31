import 'package:flutter/material.dart';
import '../../../../core/utils/responsive.dart';

class ProfileAvatarPicker extends StatelessWidget {
  final String avatarUrl;
  final VoidCallback onTap;

  const ProfileAvatarPicker({
    super.key,
    required this.avatarUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double size = Responsive.isMobile(context)
        ? Responsive.scale(context, 100)
        : 130;

    return Center(
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Container(
              height: size,
              width: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.surface, // Background for blank state
                border: Border.all(
                  color: theme.colorScheme.primary,
                  width: 2,
                ),
                // 🔥 Only show an image if they actually have one
                image: avatarUrl.isNotEmpty
                    ? DecorationImage(
                  image: avatarUrl.startsWith('http')
                      ? NetworkImage(avatarUrl) as ImageProvider
                      : AssetImage(avatarUrl),
                  fit: BoxFit.cover,
                )
                    : null,
              ),
              // 🔥 Show the default person icon if it is empty
              child: avatarUrl.isEmpty
                  ? Icon(
                Icons.person,
                size: size * 0.5,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
              )
                  : null,
            ),
            Container(
              padding: EdgeInsets.all(Responsive.scale(context, 6)),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.camera_alt,
                size: Responsive.scale(context, 16),
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}