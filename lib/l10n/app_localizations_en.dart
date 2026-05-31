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
    return 'Based on your interest in $category';
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
  String get savedPageTitle => 'Saved Articles';

  @override
  String savedArticlesCount(String count) {
    return '$count Saved Articles';
  }

  @override
  String get noSavedArticles => 'No saved articles yet.';

  @override
  String get curationSpaceEmpty =>
      'Your curation space is empty. Explore the latest insights and save articles to build your personalized feed.';

  @override
  String get startExploring => 'Start Exploring';

  @override
  String get loginSubtitle => 'Sign in to continue your curated narrative.';

  @override
  String get emailAddress => 'Email Address';

  @override
  String get password => 'Password';

  @override
  String get signIn => 'Sign In';

  @override
  String get orContinueWith => 'Or continue with';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get dontHaveAccount => 'Don\'t have an account? ';

  @override
  String get createAccount => 'Create Account';

  @override
  String get continueAsGuest => 'Continue as Guest';

  @override
  String get footerCopyright => '© 2026 Insightly - Privacy & Terms.';

  @override
  String get joinInsightly => 'Join Insightly';

  @override
  String get signupSubtitle => 'Where the world meets your screen.';

  @override
  String get fullName => 'Full Name';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get alreadyHaveAccount => 'Already have an account? ';

  @override
  String get login => 'Login';

  @override
  String get pleaseFillFields => 'Please fill all fields';

  @override
  String get invalidEmail => 'Please enter a valid email';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match!';

  @override
  String get passwordMinLength =>
      'Password must be at least 8 characters long.';

  @override
  String get passwordUppercase =>
      'Password must contain at least one uppercase letter.';

  @override
  String get passwordLowercase =>
      'Password must contain at least one lowercase letter.';

  @override
  String get passwordNumber => 'Password must contain at least one number.';

  @override
  String get passwordSpecialChar =>
      'Password must contain at least one special character.';

  @override
  String get topTopic => 'Top Topic';

  @override
  String get designYourDaily => 'DESIGN YOUR DAILY';

  @override
  String get pickTopicsSubtitle =>
      'Pick a few topics you love so we can tailor your feed just for you.';

  @override
  String calibrated(String count) {
    return '$count OF 5 TOPICS CALIBRATED';
  }

  @override
  String get continueBriefing => 'Continue Briefing';
}
