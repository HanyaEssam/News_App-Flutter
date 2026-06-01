// lib/core/utils/locale_provider.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;
  Locale? get locale => _locale;

  Future<void> initLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final String languageCode = prefs.getString('language_code') ?? 'en';
    _locale = Locale(languageCode);
    // notifyListeners() is called here; this is correct.
  }

  Future<void> setLocale(Locale locale) async {
    _locale = locale;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale.languageCode);
    notifyListeners(); // This triggers the Consumer in main.dart
  }
}
