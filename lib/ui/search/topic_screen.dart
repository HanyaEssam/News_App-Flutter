import 'package:flutter/material.dart';

class TopicScreen extends StatelessWidget {
  final String topicName;

  const TopicScreen({super.key, required this.topicName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(topicName)),
      body: Center(
        child: Text("Topic: $topicName"),
      ),
    );
  }
}