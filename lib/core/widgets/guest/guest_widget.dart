import 'package:flutter/material.dart';
import 'package:news/ui/auth/login/login_screen.dart';
import 'package:news/ui/auth/signup_screen/signup_screen.dart';
import 'package:news/core/theme/app_colors.dart';
import '../../utils/responsive.dart';

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
    final double maxContentWidth =
    Responsive.isMobile(context) ? double.infinity : 500;

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxContentWidth),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.scale(context, 24),
            vertical: Responsive.scale(context, 24),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: Responsive.scale(context, 40)),
              Icon(
                icon,
                size: Responsive.scale(context, 80),
                color: AppColors.mutedText.withOpacity(0.5),
              ),
              SizedBox(height: Responsive.scale(context, 24)),
              Text(
                title.toUpperCase(),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: Responsive.scaleText(context, 22),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Responsive.scale(context, 16)),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: Responsive.scaleText(context, 14),
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: Responsive.scale(context, 40)),
              SizedBox(
                width: double.infinity,
                height: Responsive.scale(context, 52),
                child: FilledButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, SignupScreen.routeName),
                  child: Text(
                    'CREATE ACCOUNT',
                    style: TextStyle(
                      fontSize: Responsive.scaleText(context, 14),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Responsive.scale(context, 16)),
              SizedBox(
                width: double.infinity,
                height: Responsive.scale(context, 52),
                child: FilledButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, LoginScreen.routeName),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      fontSize: Responsive.scaleText(context, 14),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Responsive.scale(context, 24)),
            ],
          ),
        ),
      ),
    );
  }
}