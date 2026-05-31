import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import '../../core/widgets/background_color/app_background.dart';
import 'package:news/ui/auth/login/login_screen.dart';
import '../../core/utils/responsive.dart';

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: AppBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/images/logo.png',
                width: Responsive.scale(context, 190),
                height: Responsive.scale(context, 190),
                fit: BoxFit.contain,
              ),

              SizedBox(height: Responsive.scale(context, 10)),

              // App Name
              Text(
                'Insightly',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: Responsive.scaleText(context, 50),
                  fontWeight: FontWeight.w400,
                  letterSpacing: Responsive.scale(context, 1.2),
                ),
              ),

              SizedBox(height: Responsive.scale(context, 8)),

              // Tagline
              Text(
                'YOUR WORLD IN ONE PLACE',
                style: theme.textTheme.labelMedium?.copyWith(
                  letterSpacing: Responsive.scale(context, 3),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}