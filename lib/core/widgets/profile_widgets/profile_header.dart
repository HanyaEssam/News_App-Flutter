import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String userName;
  final String avatarPath;

  const ProfileHeader({
    super.key,
    required this.userName,
    required this.avatarPath,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // 🔥 NEW: Handle both Network Images (Google) and Local Assets (Default)
    ImageProvider imageProvider;
    if (avatarPath.startsWith('http')) {
      imageProvider = NetworkImage(avatarPath);
    } else {
      // Fallback to your default image if the path is empty
      imageProvider = AssetImage(
        avatarPath.isEmpty ? 'assets/images/avatar.png' : avatarPath,
      );
    }

    return Row(
      children: [
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: theme.colorScheme.primary,
              width: 2,
            ),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: 24),
        // User Name text (displaySmall)
        Expanded(
          child: Text(
            userName,
            style: Theme.of(context).textTheme.displaySmall,
          ),
        ),
      ],
    );
  }
}