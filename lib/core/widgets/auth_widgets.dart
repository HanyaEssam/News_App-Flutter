import 'package:flutter/material.dart';
import '../theme/app_colors.dart'; // Adjust path based on your folder structure

// --- 1. Custom Text Field with Label ---
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
            color: AppColors.mutedText,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          style: const TextStyle(color: AppColors.white),
          decoration: InputDecoration(
            hintText: hintText,
            // If it's a password, show the eye icon
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      obscureText
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.mutedText,
                      size: 20,
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

// --- 2. Social Login Button ---
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
      child: FilledButton(
        onPressed: onPressed,
        // Removed the hardcoded styles! It now relies 100% on your AppTheme.
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imagePath != null)
              Image.asset(
                imagePath!,
                height: 24,
                width: 24,
              )
            else if (icon != null)
              Icon(
                icon,
                size: 24,
                color: iconColor,
              ),

            const SizedBox(width: 12),
            Text(text),
          ],
        ),
      ),
    );
  }
}