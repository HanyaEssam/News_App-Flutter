import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  // Default the app to English when it opens
  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (locale == _locale) return;
    _locale = locale;
    notifyListeners();
  }
}
