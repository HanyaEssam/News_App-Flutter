import 'package:flutter/material.dart';
import 'package:news/ui/auth/login/login_screen.dart';
import 'package:news/ui/auth/signup_screen/signup_screen.dart';
import 'package:news/core/theme/app_colors.dart';

class GuestWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const GuestWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),
            Icon(icon, size: 80, color: AppColors.mutedText.withOpacity(0.5)),
            const SizedBox(height: 24),
            Text(
              title.toUpperCase(),
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Sign Up Button
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pushNamed(context, SignupScreen.routeName),
                child: const Text('CREATE ACCOUNT'),
              ),
            ),
            const SizedBox(height: 16),

            // Login Button
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: () => Navigator.pushNamed(context, LoginScreen.routeName),
                child: const Text('LOGIN'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}