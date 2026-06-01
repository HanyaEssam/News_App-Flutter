import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/background_color/app_background.dart';
import 'package:news/core/widgets/category_feed_widgets/feed_article_card.dart';
import 'package:news/services/news_service.dart';
import 'package:news/core/models/article_model.dart';
import 'package:news/l10n/app_localizations.dart';
import '../../../../core/utils/responsive.dart';

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

  String _getTranslatedCategory(BuildContext context, String rawName) {
    final loc = AppLocalizations.of(context)!;
    switch (rawName) {
      case 'Tech': return loc.tech;
      case 'Business': return loc.business;
      case 'Sports': return loc.sports;
      case 'Politics': return loc.politics;
      case 'Science': return loc.science;
      case 'Health': return loc.health;
      case 'Travel': return loc.travel;
      case 'Entertainment': return loc.entertainment;
      case 'General': return loc.general;
      default: return rawName;
    }
  }

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

  Future<void> _fetchCategoryNews() async {
    try {
      final articlesData = await _newsService.getArticlesForTopics([
        widget.categoryName,
      ]);

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
          url: data['url'] ?? '',
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
    final translatedCategory = _getTranslatedCategory(context, widget.categoryName);

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          bottom: true,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: Responsive.maxWidth(context)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: Responsive.scale(context, 24),
                      right: Responsive.scale(context, 24),
                      bottom: Responsive.scale(context, 20),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Theme.of(context).colorScheme.primary,
                            size: Responsive.scale(context, 24),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.appTitle.toUpperCase(),
                              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                                fontSize: Responsive.scaleText(context, 24),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: Responsive.scale(context, 48)),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.scale(context, 20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: Responsive.scale(context, 20)),
                          Text(
                            '${translatedCategory.toUpperCase()} ${AppLocalizations.of(context)!.intelligence.toUpperCase()}',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: widget.categoryColor,
                              letterSpacing: 2.0,
                              fontSize: Responsive.scaleText(context, 10),
                            ),
                          ),
                          SizedBox(height: Responsive.scale(context, 8)),
                          Text(
                            AppLocalizations.of(context)!.feedTitle(translatedCategory),
                            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                              fontSize: Responsive.scaleText(context, 28),
                            ),
                          ),
                          SizedBox(height: Responsive.scale(context, 32)),
                          if (_isLoading)
                            Center(
                              child: Padding(
                                padding: EdgeInsets.all(Responsive.scale(context, 40)),
                                child: const CircularProgressIndicator(),
                              ),
                            )
                          else if (_error != null)
                            Center(
                              child: Padding(
                                padding: EdgeInsets.all(Responsive.scale(context, 20)),
                                child: Text(
                                  'Could not load $translatedCategory news.',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontSize: Responsive.scaleText(context, 14),
                                  ),
                                ),
                              ),
                            )
                          else if (_categoryArticles.isEmpty)
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(Responsive.scale(context, 20)),
                                  child: Text(
                                    'No articles found for this category.',
                                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontSize: Responsive.scaleText(context, 14),
                                    ),
                                  ),
                                ),
                              )
                            else
                              ..._categoryArticles.map((article) {
                                return FeedArticleCard(article: article);
                              }).toList(),
                          SizedBox(height: Responsive.scale(context, 40)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}