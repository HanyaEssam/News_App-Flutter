import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/background_color/app_background.dart';
import '../category_feed/screens/category_feed_screen.dart';
import 'author_screen.dart';
import 'topic_screen.dart';
import 'search_results_screen.dart';
import 'package:news/l10n/app_localizations.dart';
import '../../../core/utils/responsive.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = 'search';

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  List<String> _recentSearches = [];
  bool _isLoadingSearches = true;

  final List<String> _trendingTopics = [
    'Tech',
    'Sports',
    'Politics',
    'GlobalNews',
    'Crypto',
    'HealthTips',
    'Cinema',
  ];

  final Map<String, Color> _categoryColors = {
    'tech': AppColors.purple,
    'business': AppColors.blue,
    'sports': AppColors.green,
    'politics': AppColors.orange,
    'science': AppColors.blue,
    'health': AppColors.error,
    'travel': AppColors.yellow,
    'entertainment': AppColors.pink,
    'general': AppColors.grey,
  };

  final List<String> _categories = [
    'tech',
    'business',
    'sports',
    'politics',
    'science',
    'health',
    'travel',
    'entertainment',
    'general',
  ];

  String _formatCategoryName(String query) {
    return query[0].toUpperCase() + query.substring(1).toLowerCase();
  }

  Color _getCategoryColor(String query) {
    return _categoryColors[query.toLowerCase()] ?? AppColors.primary;
  }

  @override
  void initState() {
    super.initState();
    _loadUserRecentSearches();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  Future<void> _loadUserRecentSearches() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final doc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();
        if (doc.exists && doc.data() != null) {
          final data = doc.data()!;
          if (data.containsKey('recentSearches')) {
            setState(() {
              _recentSearches = List<String>.from(data['recentSearches']);
            });
          }
        }
      } catch (e) {
        debugPrint("Error loading recent searches: $e");
      }
    }
    if (mounted) {
      setState(() => _isLoadingSearches = false);
    }
  }

  Future<void> _saveSearchToFirebase(List<String> updatedList) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .set({'recentSearches': updatedList}, SetOptions(merge: true));
      } catch (e) {
        debugPrint("Error saving search: $e");
      }
    }
  }

  void _onSearchSubmitted(String query) {
    final cleanQuery = query.trim();
    if (cleanQuery.isEmpty) return;

    setState(() {
      if (_recentSearches.contains(cleanQuery)) {
        _recentSearches.remove(cleanQuery);
      }
      _recentSearches.insert(0, cleanQuery);
      if (_recentSearches.length > 15) {
        _recentSearches.removeLast();
      }
    });

    _saveSearchToFirebase(_recentSearches);

    final lower = cleanQuery.toLowerCase();

    if (cleanQuery.startsWith('@')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AuthorScreen(
            authorName: cleanQuery.substring(1),
          ),
        ),
      );
    } else if (cleanQuery.startsWith('#')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TopicScreen(
            topicName: cleanQuery.substring(1),
          ),
        ),
      );
    } else if (_categories.contains(lower)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CategoryFeedScreen(
            categoryName: _formatCategoryName(cleanQuery),
            categoryColor: _getCategoryColor(cleanQuery),
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SearchResultsScreen(
            query: cleanQuery,
          ),
        ),
      );
    }
  }

  void _deleteHistoryItem(String query) {
    setState(() {
      _recentSearches.remove(query);
    });

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .update({
        'recentSearches': FieldValue.arrayRemove([query]),
      }).catchError((e) => debugPrint("Error deleting search: $e"));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(AppLocalizations.of(context)!.appTitle.toUpperCase()),
      ),
      body: AppBackground(
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: Responsive.maxWidth(context)),
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.scale(context, 20),
                ),
                physics: const BouncingScrollPhysics(),
                children: [
                  SizedBox(height: Responsive.scale(context, 10)),
                  Text(
                    AppLocalizations.of(context)!.searchPageTitle,
                    style: theme.textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: Responsive.scaleText(context, 32),
                    ),
                  ),
                  SizedBox(height: Responsive.scale(context, 20)),
                  TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    onSubmitted: _onSearchSubmitted,
                    textInputAction: TextInputAction.search,
                    style: TextStyle(
                      color: theme.colorScheme.onSurface,
                      fontSize: Responsive.scaleText(context, 16),
                    ),
                    decoration: InputDecoration(
                      hintText: AppLocalizations.of(context)!.searchHint,
                      prefixIcon: Icon(
                        Icons.search,
                        size: Responsive.scale(context, 24),
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.scale(context, 24)),
                  if (!_isLoadingSearches && _recentSearches.isNotEmpty) ...[
                    Text(
                      AppLocalizations.of(context)!.recentSearches,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: Responsive.scaleText(context, 16),
                      ),
                    ),
                    SizedBox(height: Responsive.scale(context, 10)),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _recentSearches.length,
                      itemBuilder: (context, index) {
                        final item = _recentSearches[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Icon(
                            Icons.history,
                            color: theme.colorScheme.secondary,
                            size: Responsive.scale(context, 24),
                          ),
                          title: Text(
                            item,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontSize: Responsive.scaleText(context, 14),
                            ),
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: theme.colorScheme.secondary,
                              size: Responsive.scale(context, 20),
                            ),
                            onPressed: () => _deleteHistoryItem(item),
                          ),
                          onTap: () {
                            _searchController.text = item;
                            _onSearchSubmitted(item);
                          },
                        );
                      },
                    ),
                    SizedBox(height: Responsive.scale(context, 24)),
                  ],
                  Text(
                    AppLocalizations.of(context)!.trendingTopics,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: Responsive.scaleText(context, 16),
                    ),
                  ),
                  SizedBox(height: Responsive.scale(context, 14)),
                  Wrap(
                    spacing: Responsive.scale(context, 10),
                    runSpacing: Responsive.scale(context, 12),
                    children: _trendingTopics.map((topic) {
                      return GestureDetector(
                        onTap: () => _onSearchSubmitted(topic),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Responsive.scale(context, 16),
                            vertical: Responsive.scale(context, 10),
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(
                              Responsive.scale(context, 20),
                            ),
                            border: Border.all(
                              color: AppColors.border,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            '#$topic',
                            style: theme.textTheme.titleSmall?.copyWith(
                              color: theme.colorScheme.primary,
                              fontSize: Responsive.scaleText(context, 13),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: Responsive.scale(context, 24)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}