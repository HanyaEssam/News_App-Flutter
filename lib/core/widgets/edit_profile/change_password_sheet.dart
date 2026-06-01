import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news/l10n/app_localizations.dart';
import '../../../../core/utils/responsive.dart';
import '../auth_widgets/auth_widgets.dart';
import '../loading_spinner.dart';
import '../../utils/password_validatior.dart';

class ChangePasswordSheet extends StatefulWidget {
  const ChangePasswordSheet({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(Responsive.scale(context, 24)),
        ),
      ),
      builder: (_) => const ChangePasswordSheet(),
    );
  }

  @override
  State<ChangePasswordSheet> createState() => _ChangePasswordSheetState();
}

class _ChangePasswordSheetState extends State<ChangePasswordSheet> {
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;
  bool _isSaving = false;
  String? _errorMsg;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _updatePassword() async {
    final loc = AppLocalizations.of(context)!;

    final passwordError = PasswordValidator.validate(
      _newPasswordController.text,
      loc,
    );
    if (passwordError != null) {
      setState(() => _errorMsg = passwordError);
      return;
    }

    if (_newPasswordController.text != _confirmPasswordController.text) {
      setState(() => _errorMsg = loc.passwordsDoNotMatch);
      return;
    }

    setState(() {
      _isSaving = true;
      _errorMsg = null;
    });

    try {
      final user = FirebaseAuth.instance.currentUser!;
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: _oldPasswordController.text,
      );
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(_newPasswordController.text);

      if (mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMsg = e.message ?? "Authentication failed.";
      });
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Padding(
      padding: EdgeInsets.only(
        bottom:
            MediaQuery.of(context).viewInsets.bottom +
            Responsive.scale(context, 24),
        left: Responsive.scale(context, 24),
        right: Responsive.scale(context, 24),
        top: Responsive.scale(context, 24),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                loc.changePasswordTitle,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: Theme.of(
                    context,
                  ).colorScheme.onSurface.withOpacity(0.6),
                  fontSize: Responsive.scaleText(context, 12),
                ),
              ),
            ),
            SizedBox(height: Responsive.scale(context, 24)),
            AuthTextField(
              label: loc.currentPassword,
              hintText: '• • • • • • • •',
              isPassword: true,
              obscureText: _obscureOld,
              controller: _oldPasswordController,
              onToggleVisibility: () =>
                  setState(() => _obscureOld = !_obscureOld),
            ),
            SizedBox(height: Responsive.scale(context, 20)),
            AuthTextField(
              label: loc.newPassword,
              hintText: '• • • • • • • •',
              isPassword: true,
              obscureText: _obscureNew,
              controller: _newPasswordController,
              onToggleVisibility: () =>
                  setState(() => _obscureNew = !_obscureNew),
            ),
            SizedBox(height: Responsive.scale(context, 20)),
            AuthTextField(
              label: loc.confirmPasswordTitle,
              hintText: '• • • • • • • •',
              isPassword: true,
              obscureText: _obscureConfirm,
              controller: _confirmPasswordController,
              onToggleVisibility: () =>
                  setState(() => _obscureConfirm = !_obscureConfirm),
            ),
            if (_errorMsg != null) ...[
              SizedBox(height: Responsive.scale(context, 16)),
              Container(
                padding: EdgeInsets.all(Responsive.scale(context, 12)),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(
                    Responsive.scale(context, 8),
                  ),
                  border: Border.all(color: Colors.red.withOpacity(0.5)),
                ),
                child: Text(
                  _errorMsg!,
                  style: const TextStyle(color: Colors.redAccent),
                ),
              ),
            ],
            SizedBox(height: Responsive.scale(context, 32)),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _isSaving ? null : _updatePassword,
                child: _isSaving
                    ? const LoadingSpinner(color: Colors.black)
                    : Text(
                        loc.updatePassword,
                        style: TextStyle(
                          fontSize: Responsive.scaleText(context, 14),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
