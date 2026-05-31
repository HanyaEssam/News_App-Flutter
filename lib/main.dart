import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:news/core/theme/app_theme.dart';
import 'package:news/core/theme/theme_controller.dart';

import 'package:news/ui/auth/login/login_screen.dart';
import 'package:news/ui/auth/signup_screen/signup_screen.dart';
import 'package:news/ui/onboarding/screens/interest_screen.dart';
import 'package:news/ui/splash/splash_screen.dart';
import 'package:news/ui/home/screens/home_screen.dart';
import 'package:news/ui/search/search_screen.dart';
import 'package:news/ui/save/save_screen.dart';
import 'package:news/ui/profile/profile_screen.dart';

import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:news/core/utils/locale_provider.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await ThemeController.init();

  runApp(
    ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeMode,
      builder: (context, themeMode, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode,
          locale: localeProvider.locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          routes: {
            SplashScreen.routeName: (_) => const SplashScreen(),
            LoginScreen.routeName: (_) => const LoginScreen(),
            HomeLayout.routeName: (_) => const HomeLayout(),
            SearchScreen.routeName: (_) => const SearchScreen(),
            SaveScreen.routeName: (_) => const SaveScreen(),
            ProfileScreen.routeName: (_) => const ProfileScreen(),
            SignupScreen.routeName: (_) => const SignupScreen(),
            InterestScreen.routeName: (_) => const InterestScreen(),
          },
          initialRoute: SplashScreen.routeName,
        );
      },
    );
  }
}