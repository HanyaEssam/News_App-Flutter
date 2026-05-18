import 'package:flutter/material.dart';
import '../models/article_model.dart'; // Make sure this path matches your project structure

abstract class SavedArticlesManager {
  // 1. Change the notifier type to hold ArticleModel objects
  static final ValueNotifier<List<ArticleModel>> savedArticles = ValueNotifier([]);

  // 2. Accept an ArticleModel object directly
  static void toggleSave(ArticleModel article) {
    final currentList = List<ArticleModel>.from(savedArticles.value);

    // Check if already in the list by matching titles
    final existingIndex = currentList.indexWhere((a) => a.title == article.title);

    if (existingIndex >= 0) {
      currentList.removeAt(existingIndex);
    } else {
      currentList.add(article);
    }

    savedArticles.value = currentList;
  }

  // Helper method to check if a specific article is saved
  static bool isSaved(ArticleModel article) {
    return savedArticles.value.any((a) => a.title == article.title);
  }
}