import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';
import '../../../core/utils/responsive.dart';

class AuthTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? onToggleVisibility;
  final TextEditingController? controller;
  final TextInputType? keyboardType;

  const AuthTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.isPassword = false,
    this.obscureText = false,
    this.onToggleVisibility,
    this.controller,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            letterSpacing: 1.2,
            fontSize: Responsive.scaleText(context, 11),
          ),
        ),
        SizedBox(height: Responsive.scale(context, 8)),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: Responsive.scaleText(context, 14),
          ),
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(
                obscureText
                    ? Icons.visibility_off_outlined
                    : Icons.visibility_outlined,
                color: Theme.of(context).colorScheme.onSurface,
                size: Responsive.scale(context, 20),
              ),
              onPressed: onToggleVisibility,
            )
                : null,
          ),
        ),
      ],
    );
  }
}

class SocialAuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final IconData? icon;
  final String? imagePath;
  final Color? iconColor;

  const SocialAuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.imagePath,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: Responsive.scale(context, 52),
      child: FilledButton(
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imagePath != null)
              Image.asset(
                imagePath!,
                height: Responsive.scale(context, 24),
                width: Responsive.scale(context, 24),
              )
            else if (icon != null)
              Icon(
                icon,
                size: Responsive.scale(context, 24),
                color: iconColor,
              ),
            SizedBox(width: Responsive.scale(context, 12)),
            Text(
              text,
              style: TextStyle(
                fontSize: Responsive.scaleText(context, 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}