import 'package:flutter/material.dart';
import 'package:news/core/theme/app_theme.dart';
import 'package:news/ui/auth/login/login_screen.dart';
import 'package:news/ui/auth/signup_screen/signup_screen.dart';
import 'package:news/ui/splash/splash_screen.dart';
import 'package:news/ui/home/screens/home_screen.dart';

import 'package:news/ui/search/search_screen.dart';
import 'package:news/ui/save/save_screen.dart';
import 'package:news/ui/profile/profile_screen.dart';

//import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';

void main() async {
  /*WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  */
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      routes: {
        SplashScreen.routeName: (_) => const SplashScreen(),
        LoginScreen.routeName: (_) => const LoginScreen(),
        HomeLayout.routeName: (_) => const HomeLayout(),
        SearchScreen.routeName: (_) => const SearchScreen(),
        SaveScreen.routeName: (_) => const SaveScreen(),
        ProfileScreen.routeName: (_) => const ProfileScreen(),
        SignupScreen.routeName: (_) => const SignupScreen(),
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}
