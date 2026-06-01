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
import 'package:provider/provider.dart';
import '../../../core/utils/locale_provider.dart';
import '../../../core/utils/saved_articles_manager.dart';
import '../../onboarding/screens/interest_screen.dart';
import '../../../core/utils/responsive.dart';

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
          await ThemeController.toggleTheme(doc.data()!['isDarkMode'] ?? true);
          if (doc.data()!.containsKey('language') && context.mounted) {
            Provider.of<LocaleProvider>(context, listen: false)
                .setLocale(Locale(doc.data()!['language']));
          }
        }

        await SavedArticlesManager.loadUserSavedArticles();

        if (context.mounted) {
          Navigator.pushNamedAndRemoveUntil(
              context, '/home', (route) => false);
        }
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
          await ThemeController.toggleTheme(doc.data()!['isDarkMode'] ?? true);
          if (doc.data()!.containsKey('language') && context.mounted) {
            Provider.of<LocaleProvider>(context, listen: false)
                .setLocale(Locale(doc.data()!['language']));
          }

          await SavedArticlesManager.loadUserSavedArticles();

          if (context.mounted) {
            final topics = doc.data()?['selectedTopics'] ?? [];
            if (topics.isEmpty) {
              Navigator.pushReplacementNamed(
                  context, InterestScreen.routeName);
            } else {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/home', (route) => false);
            }
          }
        } else {
          await SavedArticlesManager.loadUserSavedArticles();

          final currentLocale =
              Provider.of<LocaleProvider>(context, listen: false)
                  .locale
                  ?.languageCode ?? 'en';

          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .set({'language': currentLocale}, SetOptions(merge: true));

          if (context.mounted) {
            Navigator.pushReplacementNamed(
                context, InterestScreen.routeName);
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      }
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
        bottom: true,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: Responsive.maxWidth(context)),
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: Responsive.scale(context, 24),
                right: Responsive.scale(context, 24),
                bottom: Responsive.scale(context, 20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: Responsive.scale(context, 10)),
                  const Align(
                    alignment: Alignment.centerRight,
                    child: LanguagePicker(),
                  ),
                  SizedBox(height: Responsive.scale(context, 20)),
                  AuthHeader(
                    title: loc.appTitle,
                    subtitle: loc.loginSubtitle,
                  ),
                  SizedBox(height: Responsive.scale(context, 32)),
                  AuthCard(
                    child: Column(
                      children: [
                        AuthTextField(
                          label: loc.emailAddress,
                          hintText: 'User@gmail.com',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: Responsive.scale(context, 20)),
                        AuthTextField(
                          label: loc.password,
                          hintText: '• • • • • • • •',
                          isPassword: true,
                          obscureText: _obscurePassword,
                          controller: _passwordController,
                          onToggleVisibility: () => setState(
                                  () => _obscurePassword = !_obscurePassword),
                        ),
                        if (_errorMessage != null) ...[
                          SizedBox(height: Responsive.scale(context, 16)),
                          AuthErrorBox(message: _errorMessage!),
                        ],
                        SizedBox(height: Responsive.scale(context, 32)),
                        SizedBox(
                          width: double.infinity,
                          height: Responsive.scale(context, 52),
                          child: FilledButton(
                            onPressed: _isLoading ? null : _handleSignIn,
                            child: _isLoading
                                ? SizedBox(
                              height: Responsive.scale(context, 20),
                              width: Responsive.scale(context, 20),
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimary,
                              ),
                            )
                                : Text(
                              loc.signIn,
                              style: TextStyle(
                                fontSize:
                                Responsive.scaleText(context, 14),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: Responsive.scale(context, 32)),
                        AuthDivider(text: loc.orContinueWith),
                        SizedBox(height: Responsive.scale(context, 24)),
                        SocialAuthButton(
                          text: loc.continueWithGoogle,
                          imagePath: 'assets/images/google.png',
                          onPressed:
                          _isLoading ? () {} : _handleGoogleSignIn,
                        ),
                        SizedBox(height: Responsive.scale(context, 32)),
                        AuthLinkText(
                          message: loc.dontHaveAccount,
                          linkText: loc.createAccount,
                          onTap: () => Navigator.pushReplacementNamed(
                              context, '/signup'),
                        ),
                        SizedBox(height: Responsive.scale(context, 24)),
                        SizedBox(
                          width: double.infinity,
                          height: Responsive.scale(context, 52),
                          child: FilledButton(
                            onPressed: () async {
                              await _authService.signOut();
                              SavedArticlesManager.clearSession();
                              if (context.mounted) {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, '/home', (route) => false);
                              }
                            },
                            child: Text(
                              loc.continueAsGuest,
                              style: TextStyle(
                                fontSize: Responsive.scaleText(context, 14),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Responsive.scale(context, 32)),
                  AuthFooter(text: loc.footerCopyright),
                  SizedBox(height: Responsive.scale(context, 24)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}