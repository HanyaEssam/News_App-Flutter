import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news/l10n/app_localizations.dart';

import 'package:news/core/widgets/auth_widgets/auth_widgets.dart';
import 'package:news/core/widgets/auth_widgets/auth_card.dart';
import 'package:news/core/widgets/auth_widgets/auth_header.dart';
import 'package:news/core/widgets/auth_widgets/auth_error_box.dart';
import 'package:news/core/widgets/auth_widgets/auth_divider.dart';
import 'package:news/core/widgets/auth_widgets/auth_link_text.dart';
import 'package:news/core/widgets/auth_widgets/auth_footer.dart';
import 'package:news/core/widgets/language_picker.dart';
import 'package:news/core/theme/theme_controller.dart';

import '../../../services/auth_service.dart';
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

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final AuthService _authService = AuthService();

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validatePassword(String password, AppLocalizations loc) {
    if (password.length < 8) return loc.passwordMinLength;
    if (!password.contains(RegExp(r'[A-Z]'))) return loc.passwordUppercase;
    if (!password.contains(RegExp(r'[a-z]'))) return loc.passwordLowercase;
    if (!password.contains(RegExp(r'[0-9]'))) return loc.passwordNumber;
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return loc.passwordSpecialChar;
    }
    return null;
  }

  Future<void> _handleSignup() async {
    final loc = AppLocalizations.of(context)!;
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirm = _confirmPasswordController.text;

    setState(() => _errorMessage = null);

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      setState(() => _errorMessage = loc.pleaseFillFields);
      return;
    }

    final passwordError = _validatePassword(password, loc);
    if (passwordError != null) {
      setState(() => _errorMessage = passwordError);
      return;
    }

    if (password != confirm) {
      setState(() => _errorMessage = loc.passwordsDoNotMatch);
      return;
    }

    setState(() => _isLoading = true);

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
      setState(() => _errorMessage = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _handleGoogleSignIn() async {
    setState(() => _isLoading = true);

    try {
      final user = await _authService.signInWithGoogle();

      if (user != null && mounted) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (doc.exists) {
          if (doc.data()!.containsKey('isDarkMode')) {
            ThemeController.toggleTheme(doc.data()!['isDarkMode']);
          } else {
            ThemeController.toggleTheme(true);
          }

          List topics = doc.data()?['selectedTopics'] ?? [];

          if (topics.isEmpty) {
            Navigator.pushReplacementNamed(context, InterestScreen.routeName);
          } else {
            Navigator.pushNamedAndRemoveUntil(
                context, '/home', (route) => false);
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!; // 👈 Localizations instance

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 12),

              const Align(
                alignment: Alignment.centerRight,
                child: LanguagePicker(),
              ),
              const SizedBox(height: 20),

              AuthHeader(
                title: loc.joinInsightly,
                subtitle: loc.signupSubtitle,
              ),
              const SizedBox(height: 8),

              AuthCard(
                child: Column(
                  children: [
                    AuthTextField(
                      controller: _nameController,
                      label: loc.fullName,
                      hintText: 'Caroll Froid',
                    ),
                    const SizedBox(height: 20),
                    AuthTextField(
                      controller: _emailController,
                      label: loc.emailAddress,
                      hintText: 'caroll@gmail.com',
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    AuthTextField(
                      controller: _passwordController,
                      label: loc.password,
                      hintText: '• • • • • • • •',
                      isPassword: true,
                      obscureText: _obscurePassword,
                      onToggleVisibility: () => setState(
                              () => _obscurePassword = !_obscurePassword),
                    ),
                    const SizedBox(height: 20),
                    AuthTextField(
                      controller: _confirmPasswordController,
                      label: loc.confirmPassword,
                      hintText: '• • • • • • • •',
                      isPassword: true,
                      obscureText: _obscureConfirm,
                      onToggleVisibility: () => setState(
                              () => _obscureConfirm = !_obscureConfirm),
                    ),

                    if (_errorMessage != null) ...[
                      const SizedBox(height: 24),
                      AuthErrorBox(message: _errorMessage!),
                      const SizedBox(height: 24),
                    ] else
                      const SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _isLoading ? null : _handleSignup,
                        child: _isLoading
                            ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        )
                            : Text(loc.createAccount),
                      ),
                    ),
                    const SizedBox(height: 20),

                    AuthDivider(text: loc.orContinueWith),
                    const SizedBox(height: 24),

                    SocialAuthButton(
                      text: loc.continueWithGoogle,
                      imagePath: 'assets/images/google.png',
                      iconColor: Colors.blue,
                      onPressed: _isLoading ? () {} : _handleGoogleSignIn,
                    ),
                    const SizedBox(height: 15),

                    AuthLinkText(
                      message: loc.alreadyHaveAccount,
                      linkText: loc.login,
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, '/login'),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              AuthFooter(text: loc.footerCopyright),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}