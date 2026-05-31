import 'package:flutter/material.dart';

class AuthorScreen extends StatelessWidget {
  final String authorName;

  const AuthorScreen({super.key, required this.authorName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(authorName)),
      body: Center(
        child: Text("Articles by $authorName"),
      ),
    );
  }
}