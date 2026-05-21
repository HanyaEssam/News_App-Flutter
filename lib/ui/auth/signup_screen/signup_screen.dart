import 'package:flutter/material.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/core/widgets/auth_widgets.dart';

import '../../../services/auth_service.dart';
import '../../../onboarding/screens/interest_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/theme/theme_controller.dart';

class SignupScreen extends StatefulWidget {
  static const String routeName = '/signup';
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final AuthService _authService = AuthService();

  bool _isLoading = false;
  // 🔥 NEW: State variable to hold the error text
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Custom Password Validator
  String? _validatePassword(String password) {
    if (password.length < 8) {
      return 'Password must be at least 8 characters long.';
    }
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }
    if (!password.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter.';
    }
    if (!password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }
    return null;
  }

  Future<void> _handleSignup() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirm = _confirmPasswordController.text;

    // Clear any previous errors when they click the button
    setState(() {
      _errorMessage = null;
    });

    // Basic Validation
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = 'Please fill in all fields');
      return;
    }

    // Run the strict password validation
    final passwordError = _validatePassword(password);
    if (passwordError != null) {
      setState(() => _errorMessage = passwordError);
      return;
    }

    if (password != confirm) {
      setState(() => _errorMessage = 'Passwords do not match!');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final user = await _authService.signUpWithEmail(
        fullName: name,
        email: email,
        password: password,
      );

      if (user != null && mounted) {
        Navigator.pushReplacementNamed(context, InterestScreen.routeName);
      }
    } catch (e) {
      // Show Firebase errors in the same UI box
      setState(() => _errorMessage = e.toString());
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
  Future<void> _handleGoogleSignIn() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final user = await _authService.signInWithGoogle();

      if (user != null && mounted) {
        final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        if (doc.exists) {

          // 🔥 FIX 2: Apply their specific theme FIRST, before navigating anywhere!
          if (doc.data()!.containsKey('isDarkMode')) {
            ThemeController.toggleTheme(doc.data()!['isDarkMode']);
          } else {
            // Safety fallback: if they somehow don't have the field, default to Dark
            ThemeController.toggleTheme(true);
          }

          List topics = doc.data()?['selectedTopics'] ?? [];

          if (topics.isEmpty) {
            // 🚀 BRAND NEW USER
            Navigator.pushReplacementNamed(context, InterestScreen.routeName);
          } else {
            // 🏠 RETURNING USER
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

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

              // Header Texts
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
              const SizedBox(height: 8),

              // The Main Dark Card Container
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.cardDark,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    // Full Name Field
                    AuthTextField(
                      controller: _nameController,
                      label: 'FULL NAME',
                      hintText: 'Caroll Froid',
                    ),
                    const SizedBox(height: 20),

                    // Email Field
                    AuthTextField(
                      controller: _emailController,
                      label: 'EMAIL ADDRESS',
                      hintText: 'caroll@gmail.com',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),

                    // Password Field
                    AuthTextField(
                      controller: _passwordController,
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
                      controller: _confirmPasswordController,
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

                    // 🔥 NEW: The Error Message UI Box
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.red.withOpacity(0.5),
                          ),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.error_outline,
                              color: Colors.redAccent,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _errorMessage!,
                                style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ] else ...[
                      // If there's no error, just add normal spacing
                      const SizedBox(height: 32),
                    ],

                    // Create Account Button
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _isLoading ? null : _handleSignup,
                        child: _isLoading
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.black,
                          ),
                        )
                            : const Text('Create Account'),
                      ),
                    ),
                    const SizedBox(height: 20),

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
                      imagePath: 'assets/images/google.png',
                      iconColor: Colors.blue,
                      onPressed: _isLoading ? () {} : _handleGoogleSignIn,
                    ),
                    //const SizedBox(height: 12),
                   /* SocialAuthButton(
                      text: 'Continue with Apple',
                      icon: Icons.apple,
                      iconColor: Colors.white,
                      onPressed: () {},
                    ),*/
                    const SizedBox(height: 15),

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
                            Navigator.pushReplacementNamed(context, '/login');
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
              const SizedBox(height: 20),
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