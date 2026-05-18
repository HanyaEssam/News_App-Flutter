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
}