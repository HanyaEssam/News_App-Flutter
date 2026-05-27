import 'package:flutter/material.dart';
import 'package:news/core/theme/app_colors.dart';
import 'package:news/core/widgets/auth_widgets.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news/core/theme/theme_controller.dart';
import '../../../services/auth_service.dart';
import '../../../onboarding/screens/interest_screen.dart';

import 'package:provider/provider.dart';
import '../../../core/utils/locale_provider.dart';
import '../../../core/utils/saved_articles_manager.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _authService = AuthService();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // 🔥 NEW: Language Picker for Guests (No Firebase saving here!)
  void _showLanguagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'CHOOSE LANGUAGE',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.mutedText,
                  ),
                ),
                const SizedBox(height: 16),

                ListTile(
                  title: Text('English (UK)', style: Theme.of(context).textTheme.titleMedium),
                  onTap: () {
                    Navigator.pop(context);
                    Provider.of<LocaleProvider>(context, listen: false).setLocale(const Locale('en'));
                  },
                ),
                ListTile(
                  title: Text('العربية (Arabic)', style: Theme.of(context).textTheme.titleMedium),
                  onTap: () {
                    Navigator.pop(context);
                    Provider.of<LocaleProvider>(context, listen: false).setLocale(const Locale('ar'));
                  },
                ),
                ListTile(
                  title: Text('Español (Spanish)', style: Theme.of(context).textTheme.titleMedium),
                  onTap: () {
                    Navigator.pop(context);
                    Provider.of<LocaleProvider>(context, listen: false).setLocale(const Locale('es'));
                  },
                ),
                ListTile(
                  title: Text('Français (French)', style: Theme.of(context).textTheme.titleMedium),
                  onTap: () {
                    Navigator.pop(context);
                    Provider.of<LocaleProvider>(context, listen: false).setLocale(const Locale('fr'));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleSignIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = 'Please fill in all fields');
      return;
    }
    if (!email.contains('@')) {
      setState(() => _errorMessage = 'Please enter a valid email');
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final user = await _authService.signInWithEmail(
        email: email,
        password: password,
      );

      if (user != null && mounted) {
        final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

        if (doc.exists && doc.data() != null) {
          if (doc.data()!.containsKey('isDarkMode')) {
            ThemeController.toggleTheme(doc.data()!['isDarkMode']);
          } else {
            ThemeController.toggleTheme(true);
          }

          if (doc.data()!.containsKey('language')) {
            String userLang = doc.data()!['language'];
            if (context.mounted) {
              Provider.of<LocaleProvider>(context, listen: false).setLocale(Locale(userLang));
            }
          }
        }

        await SavedArticlesManager.loadUserSavedArticles();

        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        }
      }
    } catch (e) {
      setState(() => _errorMessage = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
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

        if (doc.exists && doc.data() != null) {
          if (doc.data()!.containsKey('isDarkMode')) {
            ThemeController.toggleTheme(doc.data()!['isDarkMode']);
          } else {
            ThemeController.toggleTheme(true);
          }

          if (doc.data()!.containsKey('language')) {
            String userLang = doc.data()!['language'];
            if (context.mounted) {
              Provider.of<LocaleProvider>(context, listen: false).setLocale(Locale(userLang));
            }
          }

          await SavedArticlesManager.loadUserSavedArticles();
          List topics = doc.data()?['selectedTopics'] ?? [];

          if (context.mounted) {
            if (topics.isEmpty) {
              Navigator.pushReplacementNamed(context, InterestScreen.routeName);
            } else {
              Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
            }
          }
        } else {
          await SavedArticlesManager.loadUserSavedArticles();

          // 🔥 NEW: If it's a brand new Google user, save the language they selected on the Login Screen to Firebase!
          final currentLocale = Provider.of<LocaleProvider>(context, listen: false).locale.languageCode;
          await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
            'language': currentLocale
          }, SetOptions(merge: true));

          if (context.mounted) {
            Navigator.pushReplacementNamed(context, InterestScreen.routeName);
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
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
              const SizedBox(height: 10),

              // 🔥 NEW: Top Right Globe Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.language, color: AppColors.mutedText),
                    onPressed: () => _showLanguagePicker(context),
                  ),
                ],
              ),

              const SizedBox(height: 10),
              Text('INSIGHTLY', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              Text(
                'Sign in to continue your curated narrative.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.cardDark,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    AuthTextField(
                      label: 'EMAIL ADDRESS',
                      hintText: 'farida@gmail.com',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    AuthTextField(
                      label: 'PASSWORD',
                      hintText: '• • • • • • • •',
                      isPassword: true,
                      obscureText: _obscurePassword,
                      controller: _passwordController,
                      onToggleVisibility: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.red.withOpacity(0.5)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error_outline, color: Colors.redAccent, size: 18),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                _errorMessage!,
                                style: const TextStyle(color: AppColors.error, fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _isLoading ? null : _handleSignIn,
                        child: _isLoading
                            ? const SizedBox(
                          height: 20, width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.black),
                        )
                            : const Text('Sign In'),
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        const Expanded(child: Divider(color: AppColors.border)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            'OR CONTINUE WITH',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: AppColors.mutedText, letterSpacing: 1.5,
                            ),
                          ),
                        ),
                        const Expanded(child: Divider(color: AppColors.border)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SocialAuthButton(
                      text: 'Continue with Google',
                      imagePath: 'assets/images/google.png',
                      onPressed: _isLoading ? () {} : _handleGoogleSignIn,
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account? ", style: Theme.of(context).textTheme.bodyMedium),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacementNamed(context, '/signup');
                          },
                          child: Text(
                            "Create Account",
                            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: AppColors.primary),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () async {
                          await _authService.signOut();
                          SavedArticlesManager.clearSession();
                          if (context.mounted) {
                            // Leave the language as whatever they just selected via the Globe icon!
                            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                          }
                        },
                        child: const Text('Continue as a guest'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Text(
                '© 2026 INSIGHTLY PRIVACY & TERMS.',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(color: AppColors.border),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}