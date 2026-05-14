import 'package:flutter/material.dart';
import '../../core/widgets/background_color/app_background.dart';

class SearchScreen extends StatelessWidget {
  static const String routeName = '/search';
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: const Center(
          child: Text(
            'Home / search',
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