import 'package:flutter/material.dart';

class ArticleModel {
  final String title;
  final String content;
  final String category;
  final String source;
  final String date;
  final String time;
  final String imageUrl;
  final Color categoryColor;
  final String readtime;


  ArticleModel({
    required this.title,
    required this.content,
    required this.category,
    required this.source,
    required this.date,
    required this.time,
    required this.imageUrl,
    required this.categoryColor,
    required this.readtime,

  });

  // ✅ NEW: Converts the Article into JSON for Firebase
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'category': category,
      'source': source,
      'date': date,
      'time': time,
      'imageUrl': imageUrl,
      'categoryColor': categoryColor.value, // 🔥 Save color as an Integer
      'readtime': readtime,

    };
  }

  // ✅ NEW: Converts Firebase JSON back into an Article
  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      title: map['title'] ?? '',
      content: map['content'] ?? '',
      category: map['category'] ?? 'General',
      source: map['source'] ?? 'Unknown',
      date: map['date'] ?? '',
      time: map['time'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      // 🔥 Convert Integer back to Color, fallback to blue if missing
      categoryColor: map['categoryColor'] != null
          ? Color(map['categoryColor'])
          : Colors.blue,
      readtime: map['readtime'] ?? '',

    );
  }
}