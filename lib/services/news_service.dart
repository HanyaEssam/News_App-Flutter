import 'dart:convert';
import 'package:http/http.dart' as http;
import '../core/constants/api_constants.dart';

class NewsService {

  Future<List<Map<String, dynamic>>> _fetchFromNewsApi(String urlString, {String? topic}) async {
    try {
      final response = await http.get(Uri.parse(urlString));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List articles = data['articles'] ?? [];

        return articles.map((a) {
          if (topic != null) a['matchedTopic'] = topic;
          return {
            ...a as Map<String, dynamic>,
            'urlToImage': a['urlToImage'] ?? '',
          };
        }).where((a) => a['title'] != null).toList();
      }
    } catch (e) {
      print('NewsAPI Error: $e');
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> _fetchFromGNews(String urlString, {String? topic}) async {
    try {
      final response = await http.get(Uri.parse(urlString));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List articles = data['articles'] ?? [];

        return articles.map((a) => {
          'title': a['title'],
          'description': a['description'],
          'content': a['content'],
          'urlToImage': a['image'] ?? '',
          'url': a['url'],
          'source': {'name': a['source']['name']},
          'publishedAt': a['publishedAt'],
          if (topic != null) 'matchedTopic': topic,
        }).where((a) => a['title'] != null).toList();
      }
    } catch (e) {
      print('GNews Error: $e');
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> _fetchFromNewsData(String urlString, {String? topic}) async {
    try {
      final response = await http.get(Uri.parse(urlString));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List articles = data['results'] ?? [];

        return articles.map((a) {
          String rawContent = a['content'] ?? '';

          if (rawContent.toLowerCase().contains('paid plan') || rawContent.isEmpty) {
            rawContent = a['description'] ?? 'Click "Read Full Article" below to view the full story.';
          }

          return {
            'title': a['title'],
            'description': a['description'],
            'content': rawContent,
            'urlToImage': a['image_url'] ?? '',
            'url': a['link'] ?? '',
            'source': {'name': a['source_id'] ?? 'Local News'},
            'publishedAt': a['pubDate'],
            if (topic != null) 'matchedTopic': topic,
          };
        }).where((a) => a['title'] != null).toList();
      }
    } catch (e) {
      print('NewsData Error: $e');
    }
    return [];
  }

  Future<List<Map<String, dynamic>>> getTopHeadlines() async {
    final newsApiUrl = '${ApiConstants.newsApiBaseUrl}/top-headlines?country=us&apiKey=${ApiConstants.newsApiKey}';
    final gNewsUrl = '${ApiConstants.gNewsBaseUrl}/top-headlines?lang=en&apikey=${ApiConstants.gNewsApiKey}';
    final newsDataUrl = '${ApiConstants.newsDataBaseUrl}/news?country=eg&apikey=${ApiConstants.newsDataApiKey}';

    final results1 = await _fetchFromNewsApi(newsApiUrl);
    final results2 = await _fetchFromGNews(gNewsUrl);
    final results3 = await _fetchFromNewsData(newsDataUrl);

    final combined = [...results1, ...results2, ...results3];
    combined.shuffle();
    return combined;
  }

  Future<List<Map<String, dynamic>>> getArticlesForTopics(List<String> topics) async {
    if (topics.isEmpty) return getTopHeadlines();

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
    final topicsToFetch = topics.take(3).toList();

    for (final topic in topicsToFetch) {
      final lowerTopic = topic.toLowerCase();
      final category = categoryMap[lowerTopic];

      String newsApiUrl;
      String gNewsUrl;
      String newsDataUrl;
      if (category != null) {
        newsApiUrl = '${ApiConstants.newsApiBaseUrl}/top-headlines?country=us&category=$category&apiKey=${ApiConstants.newsApiKey}';
        gNewsUrl = '${ApiConstants.gNewsBaseUrl}/top-headlines?category=$category&lang=en&apikey=${ApiConstants.gNewsApiKey}';
        newsDataUrl = '${ApiConstants.newsDataBaseUrl}/news?country=eg&category=$category&apikey=${ApiConstants.newsDataApiKey}';
      } else {
        newsApiUrl = '${ApiConstants.newsApiBaseUrl}/everything?q=$topic&sortBy=publishedAt&language=en&apiKey=${ApiConstants.newsApiKey}';
        gNewsUrl = '${ApiConstants.gNewsBaseUrl}/search?q=$topic&lang=en&apikey=${ApiConstants.gNewsApiKey}';
        newsDataUrl = '${ApiConstants.newsDataBaseUrl}/news?country=eg&q=$topic&apikey=${ApiConstants.newsDataApiKey}';
      }

      final newsApiResults = await _fetchFromNewsApi(newsApiUrl, topic: topic);
      final gNewsResults = await _fetchFromGNews(gNewsUrl, topic: topic);
      final newsDataResults = await _fetchFromNewsData(newsDataUrl, topic: topic);

      allArticles.addAll(newsApiResults.take(3));
      allArticles.addAll(gNewsResults.take(3));
      allArticles.addAll(newsDataResults.take(3));
    }

    allArticles.shuffle();
    return allArticles;
  }
}