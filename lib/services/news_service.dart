import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants/api_constants.dart';

class NewsService {
  // Fetch top headlines (Trending)
  Future<List<Map<String, dynamic>>> getTopHeadlines() async {
    final url = Uri.parse(
      '${ApiConstants.newsApiBaseUrl}/top-headlines?country=us&apiKey=${ApiConstants.newsApiKey}',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List articles = data['articles'] ?? [];

        return articles
            .where((a) => a['urlToImage'] != null && a['title'] != null)
            .cast<Map<String, dynamic>>()
            .toList();
      } else {
        throw Exception('Failed to load news: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching news: $e');
    }
  }

  // Fetch articles by category
  Future<List<Map<String, dynamic>>> getArticlesByCategory(String category) async {
    final url = Uri.parse(
      '${ApiConstants.newsApiBaseUrl}/top-headlines?country=us&category=${category.toLowerCase()}&apiKey=${ApiConstants.newsApiKey}',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List articles = data['articles'] ?? [];

        return articles
            .where((a) => a['urlToImage'] != null && a['title'] != null)
            .cast<Map<String, dynamic>>()
            .toList();
      } else {
        throw Exception('Failed to load category: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching category: $e');
    }
  }

  // 🔥 NEW: Fetch articles based on user's selected topics
  Future<List<Map<String, dynamic>>> getArticlesForTopics(
      List<String> topics) async {
    // If no topics, fall back to general news
    if (topics.isEmpty) {
      return getTopHeadlines();
    }

    // NewsAPI categories: business, entertainment, general, health, science, sports, technology
    // Map our topics to NewsAPI categories where possible
    final categoryMap = {
      'technology': 'technology',
      'tech': 'technology',
      'business': 'business',
      'science': 'science',
      'health': 'health',
      'sports': 'sports',
      'entertainment': 'entertainment',
    };

    final List<Map<String, dynamic>> allArticles = [];

    // Take up to 3 topics to avoid too many API calls
    final topicsToFetch = topics.take(3).toList();

    for (final topic in topicsToFetch) {
      final lowerTopic = topic.toLowerCase();
      final category = categoryMap[lowerTopic];

      try {
        List<Map<String, dynamic>> articles = [];

        if (category != null) {
          // Use category endpoint
          articles = await getArticlesByCategory(category);
        } else {
          // Use search endpoint for non-standard topics (Politics, Travel, etc.)
          articles = await _searchArticles(topic);
        }

        // ✅ NEW FIX: Tag every article with the topic that successfully fetched it
        for (var article in articles) {
          article['matchedTopic'] = topic;
        }

        allArticles.addAll(articles.take(3));

      } catch (e) {
        // Skip this topic if it fails, continue with others
        print('Failed to fetch topic $topic: $e');
      }
    }
    allArticles.shuffle();

    return allArticles;
  }

  // Search articles by keyword
  Future<List<Map<String, dynamic>>> _searchArticles(String query) async {
    final url = Uri.parse(
      '${ApiConstants.newsApiBaseUrl}/everything?q=$query&sortBy=publishedAt&language=en&apiKey=${ApiConstants.newsApiKey}',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List articles = data['articles'] ?? [];

        return articles
            .where((a) => a['urlToImage'] != null && a['title'] != null)
            .cast<Map<String, dynamic>>()
            .toList();
      } else {
        throw Exception('Failed to search: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Search error: $e');
    }
  }
}