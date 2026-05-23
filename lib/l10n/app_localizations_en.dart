// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Insightly';

  @override
  String get dailyBriefing => 'Your daily briefing';

  @override
  String get trendingNow => 'Trending Now';

  @override
  String get forYou => 'For You';

  @override
  String get profile => 'Profile';

  @override
  String get settings => 'Settings';

  @override
  String get articlesRead => 'Articles Read';

  @override
  String get minutesSaved => 'Minutes Saved';

  @override
  String get appearance => 'Appearance';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get language => 'Language';

  @override
  String get logoutSession => 'Logout Session';

  @override
  String get home => 'Home';

  @override
  String get search => 'Search';

  @override
  String get saved => 'Saved';

  @override
  String get tech => 'Tech';

  @override
  String get business => 'Business';

  @override
  String get sports => 'Sports';

  @override
  String get politics => 'Politics';

  @override
  String get science => 'Science';

  @override
  String get health => 'Health';

  @override
  String get travel => 'Travel';

  @override
  String get entertainment => 'Entertainment';

  @override
  String get general => 'General';

  @override
  String get trendingLabel => 'Trending';

  @override
  String get recent => 'Recent';

  @override
  String get minRead => 'min read';

  @override
  String get mainSource => 'Main Source';

  @override
  String basedOnInterest(String category) {
    return 'BASED ON YOUR INTEREST IN $category';
  }

  @override
  String feedTitle(String category) {
    return '$category Feed';
  }

  @override
  String get intelligence => 'Intelligence';

  @override
  String get searchPageTitle => 'Search';

  @override
  String get searchHint => 'Search news, topics, or authors';

  @override
  String get recentSearches => 'Recent Searches';

  @override
  String get trendingTopics => 'Trending Topics';

  @override
  String get savedPageTitle => 'Saved';

  @override
  String savedArticlesCount(String count) {
    return 'SAVED ARTICLES $count';
  }

  @override
  String get noSavedArticles => 'No saved articles yet.';

  @override
  String get curationSpaceEmpty =>
      'Your curation space is empty. Explore the latest insights and bookmark articles to build your personalized intelligence feed.';

  @override
  String get startExploring => 'Start Exploring';
}
