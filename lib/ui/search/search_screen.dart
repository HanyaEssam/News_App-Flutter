import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/background_color/app_background.dart';
import '../category_feed/screens/category_feed_screen.dart';
import '../author/author_screen.dart';
import '../topic/topic_screen.dart';
import 'package:news/l10n/app_localizations.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = 'search';

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _searchFocusNode = FocusNode();

  // 🔥 Now empty by default! Will fill up based on the logged-in user.
  List<String> _recentSearches = [];
  bool _isLoadingSearches = true;

  // Static Trending Topics Data
  final List<String> _trendingTopics = [
    'Tech',
    'Sports',
    'Politics',
    'GlobalNews',
    'Crypto',
    'HealthTips',
    'Cinema',
  ];

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

  // ☁️ FETCH: Get the user's personal search history from Firestore
  Future<void> _loadUserRecentSearches() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
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

  // ☁️ SAVE: Add new searches to the list and update Firestore
  Future<void> _saveSearchToFirebase(List<String> updatedList) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'recentSearches': updatedList,
        }, SetOptions(merge: true));
      } catch (e) {
        debugPrint("Error saving search: $e");
      }
    }
  }

  // 🧠 Search Submission Handler
  void _onSearchSubmitted(String query) {
    final cleanQuery = query.trim();
    if (cleanQuery.isEmpty) return;

    setState(() {
      // Remove it if it already exists so we can move it to the top
      if (_recentSearches.contains(cleanQuery)) {
        _recentSearches.remove(cleanQuery);
      }

      // Add to the top of the list
      _recentSearches.insert(0, cleanQuery);

      // Keep only the last 15 searches
      if (_recentSearches.length > 15) {
        _recentSearches.removeLast();
      }
    });

    // Save the new list to Firebase!
    _saveSearchToFirebase(_recentSearches);

    final lower = cleanQuery.toLowerCase();

    // CATEGORY
    final categories = [
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

    if (categories.contains(lower)) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CategoryFeedScreen(
            categoryName: cleanQuery,
            categoryColor: AppColors.primary,
          ),
        ),
      );
    }
    // AUTHOR (if starts with @)
    else if (cleanQuery.startsWith('@')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AuthorScreen(
            authorName: cleanQuery.substring(1),
          ),
        ),
      );
    }
    // TOPIC (if starts with #)
    else if (cleanQuery.startsWith('#')) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TopicScreen(
            topicName: cleanQuery.substring(1),
          ),
        ),
      );
    }
    // DEFAULT → treat as category search
    else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CategoryFeedScreen(
            categoryName: cleanQuery,
            categoryColor: AppColors.primary,
          ),
        ),
      );
    }
  }

  // ☁️ DELETE: Remove a specific search item from Firestore
  void _deleteHistoryItem(String query) {
    setState(() {
      _recentSearches.remove(query);
    });

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'recentSearches': FieldValue.arrayRemove([query]),
      }).catchError((e) => debugPrint("Error deleting search: $e"));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // 🧭 1. TOP NAVIGATION HEADER
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 48.0),
                        child: Text(
                          AppLocalizations.of(context)!.searchPageTitle,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.displaySmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // 🔎 2. THEMED SEARCH BAR WIDGET
                TextField(
                  controller: _searchController,
                  focusNode: _searchFocusNode,
                  onSubmitted: _onSearchSubmitted,
                  textInputAction: TextInputAction.search,
                  style: TextStyle(color: theme.colorScheme.onSurface),
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.searchHint,
                    prefixIcon: const Icon(Icons.search),
                  ),
                ),

                const SizedBox(height: 24),

                // ⚙️ STATE MANAGEMENT AREA
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [

                      // 🕘 3. RECENT SEARCHES SECTION
                      // Only show this section if it's done loading AND there are actually items!
                      if (!_isLoadingSearches && _recentSearches.isNotEmpty) ...[
                        Text(
                          AppLocalizations.of(context)!.recentSearches,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _recentSearches.length,
                          itemBuilder: (context, index) {
                            final item = _recentSearches[index];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Icon(Icons.history, color: theme.colorScheme.secondary),
                              title: Text(
                                item,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                              trailing: IconButton(
                                icon: Icon(Icons.close, color: theme.colorScheme.secondary, size: 20),
                                onPressed: () => _deleteHistoryItem(item),
                              ),
                              onTap: () {
                                _searchController.text = item;
                                _onSearchSubmitted(item);
                              },
                            );
                          },
                        ),
                        const SizedBox(height: 24),
                      ],

                      // 🔥 4. TRENDING TOPICS SECTION
                      Text(
                        AppLocalizations.of(context)!.trendingTopics,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 14),

                      Wrap(
                        spacing: 10,
                        runSpacing: 12,
                        children: _trendingTopics.map((topic) {
                          return GestureDetector(
                            onTap: () {
                              _searchController.text = topic;
                              _onSearchSubmitted(topic);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surface,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: AppColors.border,
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                '#$topic',
                                style: theme.textTheme.titleSmall?.copyWith(
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}