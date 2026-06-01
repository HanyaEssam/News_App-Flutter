import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/article_model.dart';

class SavedArticlesManager {
  // This is what your UI listens to
  static ValueNotifier<List<ArticleModel>> savedArticles = ValueNotifier([]);

  // Automatically loads articles from Firebase for the logged-in user
  static Future<void> loadUserSavedArticles() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      savedArticles.value = []; // Clear if guest
      return;
    }

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('bookmarks')
          .get();

      List<ArticleModel> articles = snapshot.docs.map((doc) {
        return ArticleModel.fromMap(doc.data());
      }).toList();

      savedArticles.value = articles;
    } catch (e) {
      print("Error loading bookmarks: $e");
    }
  }

  // Check if article is saved (using the Title as a unique ID)
  static bool isSaved(ArticleModel article) {
    return savedArticles.value.any((a) => a.title == article.title);
  }

  //  Add or Remove from Firebase and UI
  static Future<void> toggleSave(ArticleModel article) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return; // Guests can't save

    // Create a safe document ID from the title (Firestore doesn't allow slashes in doc IDs)
    final docId = article.title.replaceAll(RegExp(r'[^\w\s]+'), '').replaceAll(' ', '_');

    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('bookmarks')
        .doc(docId);

    if (isSaved(article)) {
      // Remove it
      savedArticles.value = List.from(savedArticles.value)
        ..removeWhere((a) => a.title == article.title);
      await docRef.delete();
    } else {
      // Add it
      savedArticles.value = List.from(savedArticles.value)..add(article);
      await docRef.set(article.toMap());
    }
  }

  //  Wipes the local RAM memory clean when a user logs out!
  static void clearSession() {
    savedArticles.value = [];
  }
}