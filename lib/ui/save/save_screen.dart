import 'package:flutter/material.dart';
import '../../core/widgets/background_color/app_background.dart';

class SaveScreen extends StatelessWidget {
  static const String routeName = '/save';
  const SaveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: const Center(
          child: Text(
            'Home / save',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}