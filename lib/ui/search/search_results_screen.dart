import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/background_color/app_background.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/models/article_model.dart';
import '../../../services/news_service.dart';
import '../../../core/widgets/category_feed_widgets/feed_article_card.dart';

class SearchResultsScreen extends StatefulWidget {
  final String query;

  const SearchResultsScreen({super.key, required this.query});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final NewsService _newsService = NewsService();
  List<ArticleModel> _results = [];
  bool _isLoading = true;
  String? _error;

  String _formatDate(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return 'Recent';
    try {
      final DateTime dt = DateTime.parse(rawDate);
      final List<String> months = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
      ];
      return '${months[dt.month - 1]} ${dt.day}, ${dt.year}';
    } catch (e) {
      return rawDate.substring(0, 10);
    }
  }

  @override
  void initState() {
    super.initState();
    _search();
  }

  Future<void> _search() async {
    try {
      final articlesData =
      await _newsService.getArticlesForTopics([widget.query]);

      final articles = articlesData.map((data) {
        return ArticleModel(
          title: data['title'] ?? 'No title',
          content: data['content'] ?? data['description'] ?? 'No content',
          category: widget.query,
          categoryColor: AppColors.primary,
          source: data['source']?['name'] ?? 'Unknown',
          date: _formatDate(data['publishedAt']),
          time: 'Recent',
          imageUrl: data['urlToImage'] ?? '',
          readtime: '5 min read',
          url: data['url'] ?? '',
        );
      }).toList();

      if (mounted) {
        setState(() {
          _results = articles;
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'INSIGHTLY',
          style: TextStyle(fontSize: Responsive.scaleText(context, 18)),
        ),
      ),
      body: AppBackground(
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: Responsive.maxWidth(context)),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.scale(context, 20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Responsive.scale(context, 20)),
                    Text(
                      'SEARCH RESULTS',
                      style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.primary,
                        letterSpacing: 2.0,
                        fontSize: Responsive.scaleText(context, 10),
                      ),
                    ),
                    SizedBox(height: Responsive.scale(context, 8)),
                    Text(
                      '"${widget.query}"',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontSize: Responsive.scaleText(context, 28),
                      ),
                    ),
                    SizedBox(height: Responsive.scale(context, 32)),
                    if (_isLoading)
                      Center(
                        child: Padding(
                          padding:
                          EdgeInsets.all(Responsive.scale(context, 40)),
                          child: const CircularProgressIndicator(),
                        ),
                      )
                    else if (_error != null)
                      Center(
                        child: Padding(
                          padding:
                          EdgeInsets.all(Responsive.scale(context, 20)),
                          child: Text(
                            'Could not load results.',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                              fontSize: Responsive.scaleText(context, 14),
                            ),
                          ),
                        ),
                      )
                    else if (_results.isEmpty)
                        Center(
                          child: Padding(
                            padding:
                            EdgeInsets.all(Responsive.scale(context, 20)),
                            child: Text(
                              'No results found for "${widget.query}".',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                fontSize: Responsive.scaleText(context, 14),
                              ),
                            ),
                          ),
                        )
                      else
                        ..._results.map((article) {
                          return FeedArticleCard(article: article);
                        }).toList(),
                    SizedBox(height: Responsive.scale(context, 40)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}