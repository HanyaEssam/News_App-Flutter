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

    ImageProvider imageProvider;
    if (avatarPath.startsWith('http')) {
      imageProvider = NetworkImage(avatarPath);
    } else {
      imageProvider = AssetImage(
        avatarPath.isEmpty ? 'assets/images/avatar.png' : avatarPath,
      );
    }

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