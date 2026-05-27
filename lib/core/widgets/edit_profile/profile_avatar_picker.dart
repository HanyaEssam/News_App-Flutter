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

  ImageProvider get _imageProvider {
    if (avatarUrl.startsWith('http')) return NetworkImage(avatarUrl);
    return AssetImage(
      avatarUrl.isEmpty ? 'assets/images/avatar.png' : avatarUrl,
    );
  }

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
                border: Border.all(
                  color: theme.colorScheme.primary,
                  width: 2,
                ),
                image: DecorationImage(
                  image: _imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
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