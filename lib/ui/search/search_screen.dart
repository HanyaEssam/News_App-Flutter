import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/background_color/app_background.dart';
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

  // 🕘 Mock Local Storage for Recent Searches (Max 15 items logic handled)
  final List<String> _recentSearches = [
    'Artificial Intelligence',
    'Championship Finals',
    'Global Warming Solutions',
    'Tech Stocks Crash',
  ];

  // 🔥 Mock Static Trending Topics Data
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
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  // 🧠 Search Submission Handler
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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Navigating to results for: "$cleanQuery"')),
    );
  }

  void _deleteHistoryItem(String query) {
    setState(() {
      _recentSearches.remove(query);
    });
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
                        padding: const EdgeInsets.only(
                          right: 48.0,
                        ), // Perfect text center balancing offset
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
                  // Dynamically changes text typed into the field to contrast correctly
                  style: TextStyle(color: theme.colorScheme.onSurface),
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.searchHint,
                    // Pulls decoration styles natively from your AppTheme inputDecorationTheme!
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
                      if (_recentSearches.isNotEmpty) ...[
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
                              leading: Icon(
                                Icons.history,
                                color: theme.colorScheme.secondary,
                              ),
                              title: Text(
                                item,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                              trailing: IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: theme.colorScheme.secondary,
                                  size: 20,
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

                      // Flex layout chips wrapper using theme architectural color variables
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
                                // ✅ Using your cohesive design card palette colors!
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
                                  color: theme
                                      .colorScheme
                                      .primary, // Clear readability pop accent
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
