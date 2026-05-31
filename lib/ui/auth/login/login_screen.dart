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
import '../../../core/theme/app_colors.dart';
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

  Future<void> _handleSignIn() async {
    final loc = AppLocalizations.of(context)!;
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() => _errorMessage = loc.pleaseFillFields);
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final user = await _authService.signInWithEmail(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      if (user != null && mounted) {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (doc.exists && doc.data() != null) {
          ThemeController.toggleTheme(doc.data()!['isDarkMode'] ?? true);
          if (doc.data()!.containsKey('language') && context.mounted) {
            // 🔥 Use updateFromDatabase to respect manual selection
            Provider.of<LocaleProvider>(
              context,
              listen: false,
            ).updateFromDatabase(doc.data()!['language']);
          }
        }
        await SavedArticlesManager.loadUserSavedArticles();
        if (context.mounted)
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
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
        if (doc.exists && doc.data() != null) {
          ThemeController.toggleTheme(doc.data()!['isDarkMode'] ?? true);
          if (doc.data()!.containsKey('language') && context.mounted) {
            // 🔥 Use updateFromDatabase
            Provider.of<LocaleProvider>(
              context,
              listen: false,
            ).updateFromDatabase(doc.data()!['language']);
          }
          await SavedArticlesManager.loadUserSavedArticles();
          if (context.mounted) {
            (doc.data()?['selectedTopics'] ?? []).isEmpty
                ? Navigator.pushReplacementNamed(
                    context,
                    InterestScreen.routeName,
                  )
                : Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home',
                    (route) => false,
                  );
          }
        } else {
          await SavedArticlesManager.loadUserSavedArticles();
          final currentLocale =
              Provider.of<LocaleProvider>(
                context,
                listen: false,
              ).locale?.languageCode ??
              'en';
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({'language': currentLocale}, SetOptions(merge: true));
          if (context.mounted)
            Navigator.pushReplacementNamed(context, InterestScreen.routeName);
        }
      }
    } catch (e) {
      if (mounted)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerRight,
                child: LanguagePicker(),
              ),
              AuthHeader(title: loc.appTitle, subtitle: loc.loginSubtitle),
              AuthCard(
                child: Column(
                  children: [
                    AuthTextField(
                      label: loc.emailAddress,
                      hintText: 'farida@gmail.com',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 20),
                    AuthTextField(
                      label: loc.password,
                      hintText: '• • • • • • • •',
                      isPassword: true,
                      obscureText: _obscurePassword,
                      controller: _passwordController,
                      onToggleVisibility: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    if (_errorMessage != null) ...[
                      const SizedBox(height: 16),
                      AuthErrorBox(message: _errorMessage!),
                    ],
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: _isLoading ? null : _handleSignIn,
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(loc.signIn),
                      ),
                    ),
                    const SizedBox(height: 32),
                    AuthDivider(text: loc.orContinueWith),
                    const SizedBox(height: 24),
                    SocialAuthButton(
                      text: loc.continueWithGoogle,
                      imagePath: 'assets/images/google.png',
                      onPressed: _isLoading ? () {} : _handleGoogleSignIn,
                    ),
                    const SizedBox(height: 32),
                    AuthLinkText(
                      message: loc.dontHaveAccount,
                      linkText: loc.createAccount,
                      onTap: () =>
                          Navigator.pushReplacementNamed(context, '/signup'),
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                        onPressed: () async {
                          await _authService.signOut();
                          SavedArticlesManager.clearSession();
                          if (context.mounted)
                            Navigator.pushNamedAndRemoveUntil(
                              context,
                              '/home',
                              (r) => false,
                            );
                        },
                        child: Text(loc.continueAsGuest),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              AuthFooter(text: loc.footerCopyright),
            ],
          ),
        ),
      ),
    );
  }
}
