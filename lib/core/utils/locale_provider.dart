import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;
  bool _isManuallySet = false;

  Locale? get locale => _locale;

  void setLocale(Locale locale) {
    _locale = locale;
    _isManuallySet = true;
    notifyListeners();
  }
  void updateFromDatabase(String languageCode) {
    if (!_isManuallySet) {
      _locale = Locale(languageCode);
      notifyListeners();
    }
  }
}
