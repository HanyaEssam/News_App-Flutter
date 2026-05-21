import 'package:flutter/material.dart';
import '../../core/widgets/background_color/app_background.dart';
import 'package:news/ui/auth/login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Grab the current theme (Light or Dark)
    final theme = Theme.of(context);

    return Scaffold(
      body: AppBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// Logo
              Image.asset(
                'assets/images/logo.png',
                width: 190,
                height: 190,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 10),

              /// App Name
              Text(
                'Insightly',
                // Uses your titleLarge style (Times New Roman, italic, primary color)
                // but scales it up perfectly for the Splash Screen
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 50,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 1.2,
                ),
              ),

              const SizedBox(height: 8),

              /// Tagline
              Text(
                'YOUR WORLD IN ONE PLACE',
                // Uses your labelMedium style which automatically applies
                // your specific muted text colors depending on the theme mode
                style: theme.textTheme.labelMedium?.copyWith(
                  letterSpacing: 3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}