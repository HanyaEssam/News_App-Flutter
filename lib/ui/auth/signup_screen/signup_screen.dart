import 'package:flutter/material.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/core/widgets/auth_widgets.dart';

import '../../../onboarding/screens/interest_screen.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = '/signup';
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              // 1. Header Texts
              Text(
                'JOIN INSIGHTLY',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              Text(
                'Where the world meets your screen.',
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
                    // Full Name Field
                    const AuthTextField(
                      label: 'FULL NAME',
                      hintText: 'Caroll Froid',
                    ),
                    const SizedBox(height: 20),

                    // Email Field
                    const AuthTextField(
                      label: 'EMAIL ADDRESS',
                      hintText: 'caroll@gmail.com',
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
                    const SizedBox(height: 20),

                    // Confirm Password Field
                    AuthTextField(
                      label: 'CONFIRM PASSWORD',
                      hintText: '• • • • • • • •',
                      isPassword: true,
                      obscureText: _obscureConfirm,
                      onToggleVisibility: () {
                        setState(() {
                          _obscureConfirm = !_obscureConfirm;
                        });
                      },
                    ),
                    const SizedBox(height: 32),

                    // Create Account Button
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            InterestScreen.routeName,
                          );
                        },                        child: const Text('Create Account'),
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
                      icon: Icons.g_mobiledata,
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

                    // Login Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context); // Go back to Sign In
                          },
                          child: Text(
                            "Login",
                            style: Theme.of(context).textTheme.labelLarge
                                ?.copyWith(color: AppColors.primary),
                          ),
                        ),
                      ],
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
