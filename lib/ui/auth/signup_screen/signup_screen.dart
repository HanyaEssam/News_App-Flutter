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
import '../../../core/utils/password_validatior.dart';
import '../../../core/widgets/loading_spinner.dart';
import '../../../services/auth_service.dart';
import '../../onboarding/screens/interest_screen.dart';
import '../../../core/utils/responsive.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/locale_provider.dart';

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

    final passwordError = PasswordValidator.validate(password, loc);
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
        // 🔥 Save the current selected language to Firestore for the new user
        final currentLocale =
            Provider.of<LocaleProvider>(
              context,
              listen: false,
            ).locale?.languageCode ??
            'en';

        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'fullName': name,
          'email': email,
          'language': currentLocale,
          'isDarkMode': true,
        }, SetOptions(merge: true));

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
          // Returning user: Just navigate
          Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
        } else {
          // New Google user: Set language preference
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
        bottom: true,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: Responsive.maxWidth(context)),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.scale(context, 24),
                vertical: Responsive.scale(context, 20),
              ),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerRight,
                    child: LanguagePicker(),
                  ),
                  SizedBox(height: Responsive.scale(context, 20)),
                  AuthHeader(
                    title: loc.joinInsightly,
                    subtitle: loc.signupSubtitle,
                  ),
                  SizedBox(height: Responsive.scale(context, 8)),
                  AuthCard(
                    child: Column(
                      children: [
                        AuthTextField(
                          controller: _nameController,
                          label: loc.fullName,
                          hintText: 'Full name',
                        ),
                        SizedBox(height: Responsive.scale(context, 20)),
                        AuthTextField(
                          controller: _emailController,
                          label: loc.emailAddress,
                          hintText: 'User@gmail.com',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: Responsive.scale(context, 20)),
                        AuthTextField(
                          controller: _passwordController,
                          label: loc.password,
                          hintText: '• • • • • • • •',
                          isPassword: true,
                          obscureText: _obscurePassword,
                          onToggleVisibility: () => setState(
                            () => _obscurePassword = !_obscurePassword,
                          ),
                        ),
                        SizedBox(height: Responsive.scale(context, 20)),
                        AuthTextField(
                          controller: _confirmPasswordController,
                          label: loc.confirmPassword,
                          hintText: '• • • • • • • •',
                          isPassword: true,
                          obscureText: _obscureConfirm,
                          onToggleVisibility: () => setState(
                            () => _obscureConfirm = !_obscureConfirm,
                          ),
                        ),
                        if (_errorMessage != null) ...[
                          SizedBox(height: Responsive.scale(context, 24)),
                          AuthErrorBox(message: _errorMessage!),
                        ],
                        SizedBox(height: Responsive.scale(context, 32)),
                        SizedBox(
                          width: double.infinity,
                          height: Responsive.scale(context, 52),
                          child: FilledButton(
                            onPressed: _isLoading ? null : _handleSignup,
                            child: _isLoading
                                ? const LoadingSpinner()
                                : Text(
                                    loc.createAccount,
                                    style: TextStyle(
                                      fontSize: Responsive.scaleText(
                                        context,
                                        14,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                        SizedBox(height: Responsive.scale(context, 20)),
                        AuthDivider(text: loc.orContinueWith),
                        SizedBox(height: Responsive.scale(context, 24)),
                        SocialAuthButton(
                          text: loc.continueWithGoogle,
                          imagePath: 'assets/images/google.png',
                          iconColor: Colors.blue,
                          onPressed: _isLoading ? () {} : _handleGoogleSignIn,
                        ),
                        SizedBox(height: Responsive.scale(context, 15)),
                        AuthLinkText(
                          message: loc.alreadyHaveAccount,
                          linkText: loc.login,
                          onTap: () =>
                              Navigator.pushReplacementNamed(context, '/login'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Responsive.scale(context, 32)),
                  AuthFooter(text: loc.footerCopyright),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
