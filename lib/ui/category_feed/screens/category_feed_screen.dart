import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/background_color/app_background.dart';
import 'package:news/core/widgets/category_feed_widgets/feed_article_card.dart';
import 'package:news/services/news_service.dart';
import 'package:news/core/models/article_model.dart';

class CategoryFeedScreen extends StatefulWidget {
  final String categoryName;
  final Color categoryColor;

  const CategoryFeedScreen({
    super.key,
    required this.categoryName,
    required this.categoryColor,
  });

  @override
  State<CategoryFeedScreen> createState() => _CategoryFeedScreenState();
}

class _CategoryFeedScreenState extends State<CategoryFeedScreen> {
  final NewsService _newsService = NewsService();
  List<ArticleModel> _categoryArticles = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchCategoryNews();
  }

  // ✅ Date formatter
  String _formatDate(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return 'Recent';
    try {
      final DateTime dt = DateTime.parse(rawDate);
      final List<String> months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
    } catch (e) {
      return rawDate.substring(0, 10);
    }
  }

  Future<void> _fetchCategoryNews() async {
    try {
      final articlesData = await _newsService.getArticlesForTopics([widget.categoryName]);

      final articles = articlesData.map((data) {
        return ArticleModel(
          title: data['title'] ?? 'No title',
          content: data['content'] ?? data['description'] ?? 'No content',
          category: widget.categoryName,
          categoryColor: widget.categoryColor,
          source: data['source']?['name'] ?? 'Unknown',
          date: _formatDate(data['publishedAt']),
          time: 'Recent',
          imageUrl: data['urlToImage'] ?? '',
          readtime: '5 min read',
        );
      }).toList();

      if (mounted) {
        setState(() {
          _categoryArticles = articles;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'INSIGHTLY',
                          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 48), // Balances the back button
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      Text(
                        '${widget.categoryName.toUpperCase()} INTELLIGENCE',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: widget.categoryColor,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${widget.categoryName} Feed',
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      const SizedBox(height: 32),

                      if (_isLoading)
                        const Center(
                          child: Padding(
                            padding: EdgeInsets.all(40.0),
                            child: CircularProgressIndicator(),
                          ),
                        )
                      else if (_error != null)
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Could not load ${widget.categoryName} news.',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                        )
                      else if (_categoryArticles.isEmpty)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Text(
                                'No articles found for this category.',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                          )
                        else
                          ..._categoryArticles.map((article) {
                            // ✅ FIXED: We are now passing the full article object!
                            return FeedArticleCard(
                              article: article,
                            );
                          }).toList(),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}