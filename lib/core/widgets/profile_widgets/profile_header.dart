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
    return Row(
      children: [
        // Avatar Container with custom neon framing glow matching your image
        Container(
          height: 80,
          width: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(avatarPath),
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