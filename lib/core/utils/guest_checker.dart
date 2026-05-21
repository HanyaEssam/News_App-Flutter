import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../ui/auth/login/login_screen.dart';

class GuestChecker {
  // 1. Check if the user is a guest
  static bool isGuest() {
    return FirebaseAuth.instance.currentUser == null;
  }

  // 2. Block actions and show a prompt if they are a guest
  static bool checkAndPrompt(BuildContext context) {
    if (isGuest()) {
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Log in to unlock this feature.'),
          duration: const Duration(seconds: 4),
          action: SnackBarAction(
            label: 'LOGIN',
            textColor: Theme.of(context).colorScheme.primary,
            onPressed: () {
              Navigator.pushNamed(context, LoginScreen.routeName);
            },
          ),
        ),
      );
      return true; // Returns true because they ARE a guest
    }
    return false; // Returns false because they are logged in
  }
}