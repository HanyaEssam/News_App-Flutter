import 'package:flutter/material.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/core/widgets/auth_widgets.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Using your dark background from app_theme
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // 1. Header Texts
              Text('INSIGHTLY', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              Text(
                'Sign in to continue your curated narrative.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // 2. The Main Dark Card Container
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.cardDark,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    // Email Field
                    const AuthTextField(
                      label: 'EMAIL ADDRESS',
                      hintText: 'farida@gmail.com',
                    ),
                    const SizedBox(height: 20),

                    // Password Field
                    AuthTextField(
                      label: 'PASSWORD',
                      hintText: '• • • • • • • •',
                      isPassword: true,
                      obscureText: _obscurePassword,
                      onToggleVisibility: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    const SizedBox(height: 32),

                    // Sign In Button
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        },
                        child: const Text('Sign In'),
                      ),
                    ),
                    const SizedBox(height: 32),

                    // OR Divider
                    Row(
                      children: [
                        const Expanded(child: Divider(color: AppColors.border)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'OR CONTINUE WITH',
                            style: Theme.of(context).textTheme.labelSmall
                                ?.copyWith(
                                  color: AppColors.mutedText,
                                  letterSpacing: 1.5,
                                ),
                          ),
                        ),
                        const Expanded(child: Divider(color: AppColors.border)),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Social Buttons
                    SocialAuthButton(
                      text: 'Continue with Google',
                      icon: Icons.g_mobiledata, // Replace with asset later
                      iconColor: Colors.blue,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 12),
                    SocialAuthButton(
                      text: 'Continue with Apple',
                      icon: Icons.apple,
                      iconColor: Colors.white,
                      onPressed: () {},
                    ),
                    const SizedBox(height: 32),

                    // Create Account Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigate to Create Account
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text(
                            "Create Account",
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(color: AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Guest Button
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/home');
                        },
                        style: FilledButton.styleFrom(
                          // Using a slightly different style for the guest button if needed
                        ),
                        child: const Text('Continue as a guest'),
                      ),
                    ),
                  ],
                ),
              ),

              // Footer
              const SizedBox(height: 32),
              Text(
                '© 2026 INSIGHTFUL PRIVACY & TERMS.',
                style: Theme.of(
                  context,
                ).textTheme.labelSmall?.copyWith(color: AppColors.border),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
