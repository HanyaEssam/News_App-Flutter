import 'package:news/l10n/app_localizations.dart';

class PasswordValidator {
  static String? validate(String password, AppLocalizations loc) {
    if (password.length < 8) return loc.passwordMinLength;
    if (!password.contains(RegExp(r'[A-Z]'))) return loc.passwordUppercase;
    if (!password.contains(RegExp(r'[a-z]'))) return loc.passwordLowercase;
    if (!password.contains(RegExp(r'[0-9]'))) return loc.passwordNumber;
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return loc.passwordSpecialChar;
    }
    return null;
  }
}