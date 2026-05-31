import 'dart:async'; // 🔥 REQUIRED for StreamSubscription
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../core/utils/saved_articles_manager.dart';
import '../../../core/widgets/bottomnav.dart';
import '../../../core/theme/app_colors.dart';
import '../../search/search_screen.dart';
import '../../profile/profile_screen.dart';
import '../../save/save_screen.dart';
import 'package:news/core/widgets/background_color/app_background.dart';
import 'package:news/core/widgets/home_widgets/category_list.dart';
import 'package:news/core/widgets/home_widgets/trending_card.dart';
import 'package:news/core/widgets/home_widgets/for_you_card.dart';
import 'package:news/core/models/article_model.dart';
import 'package:news/services/news_service.dart';
import '../../../core/utils/guest_checker.dart';
import 'package:news/l10n/app_localizations.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = '/home';
  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    HomeTabContent(),
    SearchScreen(),
    SaveScreen(),
    ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

class HomeTabContent extends StatefulWidget {
  const HomeTabContent({super.key});

  @override
  State<HomeTabContent> createState() => _HomeTabContentState();
}

class _HomeTabContentState extends State<HomeTabContent> {
  final NewsService _newsService = NewsService();

  // 🔥 NEW: Variables for the Smart Listener
  StreamSubscription<DocumentSnapshot>? _userSubscription;
  String _lastKnownTopics = "";

  List<ArticleModel> _trendingArticles = [];
  bool _isTrendingLoading = true;
  String? _trendingError;

  List<ArticleModel> _forYouArticles = [];
  List<String> _userTopics = [];
  bool _isForYouLoading = true;
  String? _forYouError;

  @override
  void initState() {
    super.initState();
    SavedArticlesManager.loadUserSavedArticles();
    _loadTrendingNews();

    // 🔥 Start listening to topic changes immediately
    _listenToTopicChanges();
  }

  @override
  void dispose() {
    // 🔥 ALWAYS cancel the subscription when the widget is destroyed to save memory
    _userSubscription?.cancel();
    super.dispose();
  }

  Color _getColorForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'technology':
      case 'tech':
        return AppColors.primaryDark;
      case 'sports':
        return AppColors.green;
      case 'business':
        return AppColors.blue;
      case 'health':
        return AppColors.lightError;
      case 'science':
        return AppColors.purple;
      case 'entertainment':
        return AppColors.pink;
      default:
        return AppColors.blue;
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

  // 🔥 THE SMART LISTENER
  void _listenToTopicChanges() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      _userTopics = ['Technology', 'Business', 'Science'];
      _loadForYouNews(); // Fallback for guests
      return;
    }

    _userSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .snapshots()
        .listen((doc) {
      if (doc.exists && mounted) {
        final data = doc.data()!;
        final topics = data['selectedTopics'] as List<dynamic>? ?? [];

        // Convert the list to a single string (e.g., "Tech,Sports") so we can easily compare it
        String newTopicsString = topics.join(',');

        // ONLY fetch new articles if the topics actually changed!
        if (newTopicsString != _lastKnownTopics) {
          _lastKnownTopics = newTopicsString;
          _userTopics = topics.cast<String>();

          setState(() {
            _isForYouLoading = true;
          });

          _loadForYouNews(); // Fetch the new custom feed!
        }
      }
    });
  }

  Future<void> _loadTrendingNews() async {
    try {
      final articlesData = await _newsService.getTopHeadlines();

      final articles = articlesData.take(5).map((data) {
        return ArticleModel(
          title: data['title'] ?? 'No title',
          content: data['content'] ?? data['description'] ?? 'No content',
          category: 'Trending',
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
          _trendingArticles = articles;
          _isTrendingLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _trendingError = e.toString();
          _isTrendingLoading = false;
        });
      }
    }
  }

  // 🔥 SIMPLIFIED: No longer needs to fetch from Firestore manually
  Future<void> _loadForYouNews() async {
    try {
      // Fallback if they somehow have no topics
      if (_userTopics.isEmpty) {
        _userTopics = ['Technology', 'Business', 'Science'];
      }

      final articlesData = await _newsService.getArticlesForTopics(_userTopics);

      final articles = articlesData.take(6).map((data) {
        final topic = data['matchedTopic'] ?? 'General';

        return ArticleModel(
          title: data['title'] ?? 'No title',
          content: data['content'] ?? data['description'] ?? 'No content',
          category: topic,
          categoryColor: _getColorForCategory(topic),
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
          _forYouArticles = articles;
          _isForYouLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _forYouError = e.toString();
          _isForYouLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isGuest = GuestChecker.isGuest();

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text(AppLocalizations.of(context)!.appTitle.toUpperCase()),
      ),
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    AppLocalizations.of(context)!.dailyBriefing,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                const SizedBox(height: 24),
                const CategoryList(),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    AppLocalizations.of(context)!.trendingNow,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(height: 360, child: _buildTrendingSection()),
                if (!isGuest) ...[
                  const SizedBox(height: 32),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      AppLocalizations.of(context)!.forYou,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: _buildForYouSection(),
                  ),
                ],
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTrendingSection() {
    if (_isTrendingLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_trendingError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            'Could not load news.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      );
    }
    if (_trendingArticles.isEmpty) {
      return Center(
        child: Text(
          'No articles available',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: _trendingArticles.length,
      itemBuilder: (context, index) {
        return TrendingCard(article: _trendingArticles[index]);
      },
    );
  }

  Widget _buildForYouSection() {
    if (_isForYouLoading) {
      return const Padding(
        padding: EdgeInsets.all(40.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (_forYouError != null) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          'Could not load personalized news.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }
    if (_forYouArticles.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          'No personalized articles yet.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }

    return Column(
      children: _forYouArticles.map((article) {
        return ForYouCard(
          label: AppLocalizations.of(context)!.basedOnInterest(article.category.toUpperCase()),
          article: article,
        );
      }).toList(),
    );
  }
}