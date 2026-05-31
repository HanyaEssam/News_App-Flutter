import 'package:flutter/material.dart';

class CategoryModel {
  final String title;
  final String imagePath;
  final Color accentColor;

  const CategoryModel({
    required this.title,
    required this.imagePath,
    required this.accentColor,
  });
}