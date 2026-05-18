import 'package:flutter/material.dart';

abstract class SavedArticlesManager {
  // This is our global list that any screen can listen to!
  static final ValueNotifier<List<Map<String, String>>> savedArticles = ValueNotifier([]);

  // Function to add or remove an article
  static void toggleSave(Map<String, String> article) {
    // Make a copy of the current list
    final currentList = List<Map<String, String>>.from(savedArticles.value);

    // Check if the article is already in the list (matching by title)
    final existingIndex = currentList.indexWhere((a) => a['title'] == article['title']);

    if (existingIndex >= 0) {
      currentList.removeAt(existingIndex); // Remove it if it's already saved
    } else {
      currentList.add(article); // Add it if it's new
    }

    // Update the global list, which automatically triggers a screen refresh!
    savedArticles.value = currentList;
  }
}