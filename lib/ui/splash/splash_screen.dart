import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart'; // 🔥 1. Added this import
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

    // 🔥 2. Wait for the very first frame of this custom screen to be drawn,
    // and THEN instantly remove the native Android splash screen.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });

    // 3. Continue with your normal 3-second delay
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
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