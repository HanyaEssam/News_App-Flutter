import 'package:flutter/material.dart';
import '../../utils/responsive.dart';

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

    // 👇 Bigger avatar on tablet/desktop
    final double avatarSize = Responsive.isMobile(context)
        ? Responsive.scale(context, 80)
        : 110;

    return Row(
      children: [
        Container(
          height: avatarSize,
          width: avatarSize,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Responsive.scale(context, 20)),
            color: theme.colorScheme.surface, // Background for the blank state
            border: Border.all(
              color: theme.colorScheme.primary,
              width: 2,
            ),
            // 🔥 Only show an image if they actually have one
            image: avatarPath.isNotEmpty
                ? DecorationImage(
              image: avatarPath.startsWith('http')
                  ? NetworkImage(avatarPath) as ImageProvider
                  : AssetImage(avatarPath),
              fit: BoxFit.cover,
            )
                : null,
          ),
          // 🔥 Show the default person icon if it is empty
          child: avatarPath.isEmpty
              ? Icon(
            Icons.person,
            size: avatarSize * 0.5,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
          )
              : null,
        ),
        SizedBox(width: Responsive.scale(context, 24)),
        Expanded(
          child: Text(
            userName,
            style: theme.textTheme.displaySmall?.copyWith(
              fontSize: Responsive.scaleText(context, 24),
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ],
    );
  }
}