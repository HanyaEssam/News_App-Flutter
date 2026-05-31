import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;
  bool _isManuallySet = false; // Flag to track manual interaction

  Locale? get locale => _locale;

  // Called when user interacts with LanguagePicker
  void setLocale(Locale locale) {
    _locale = locale;
    _isManuallySet = true; // User manually chose this
    notifyListeners();
  }

  // Called when fetching user data from Firestore
  void updateFromDatabase(String languageCode) {
    if (!_isManuallySet) {
      _locale = Locale(languageCode);
      notifyListeners();
    }
  }
}
