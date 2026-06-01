import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('zh'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'INSIGHTLY'**
  String get appTitle;

  /// No description provided for @dailyBriefing.
  ///
  /// In en, this message translates to:
  /// **'Your daily briefing'**
  String get dailyBriefing;

  /// No description provided for @trendingNow.
  ///
  /// In en, this message translates to:
  /// **'Trending Now'**
  String get trendingNow;

  /// No description provided for @forYou.
  ///
  /// In en, this message translates to:
  /// **'For You'**
  String get forYou;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @articlesRead.
  ///
  /// In en, this message translates to:
  /// **'Articles Read'**
  String get articlesRead;

  /// No description provided for @minutesSaved.
  ///
  /// In en, this message translates to:
  /// **'Minutes Saved'**
  String get minutesSaved;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @lightMode.
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @logoutSession.
  ///
  /// In en, this message translates to:
  /// **'Logout Session'**
  String get logoutSession;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @tech.
  ///
  /// In en, this message translates to:
  /// **'Tech'**
  String get tech;

  /// No description provided for @business.
  ///
  /// In en, this message translates to:
  /// **'Business'**
  String get business;

  /// No description provided for @sports.
  ///
  /// In en, this message translates to:
  /// **'Sports'**
  String get sports;

  /// No description provided for @politics.
  ///
  /// In en, this message translates to:
  /// **'Politics'**
  String get politics;

  /// No description provided for @science.
  ///
  /// In en, this message translates to:
  /// **'Science'**
  String get science;

  /// No description provided for @health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get health;

  /// No description provided for @travel.
  ///
  /// In en, this message translates to:
  /// **'Travel'**
  String get travel;

  /// No description provided for @entertainment.
  ///
  /// In en, this message translates to:
  /// **'Entertainment'**
  String get entertainment;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @trendingLabel.
  ///
  /// In en, this message translates to:
  /// **'Trending'**
  String get trendingLabel;

  /// No description provided for @recent.
  ///
  /// In en, this message translates to:
  /// **'RECENT'**
  String get recent;

  /// No description provided for @minRead.
  ///
  /// In en, this message translates to:
  /// **'min read'**
  String get minRead;

  /// No description provided for @mainSource.
  ///
  /// In en, this message translates to:
  /// **'Main Source'**
  String get mainSource;

  /// No description provided for @basedOnInterest.
  ///
  /// In en, this message translates to:
  /// **'Based on your interest in {category}'**
  String basedOnInterest(Object category);

  /// No description provided for @feedTitle.
  ///
  /// In en, this message translates to:
  /// **'{category} Feed'**
  String feedTitle(Object category);

  /// No description provided for @intelligence.
  ///
  /// In en, this message translates to:
  /// **'Intelligence'**
  String get intelligence;

  /// No description provided for @searchPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchPageTitle;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Search news, topics, or authors'**
  String get searchHint;

  /// No description provided for @recentSearches.
  ///
  /// In en, this message translates to:
  /// **'Recent Searches'**
  String get recentSearches;

  /// No description provided for @trendingTopics.
  ///
  /// In en, this message translates to:
  /// **'Trending Topics'**
  String get trendingTopics;

  /// No description provided for @savedPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Saved Articles'**
  String get savedPageTitle;

  /// No description provided for @savedArticlesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Saved Articles'**
  String savedArticlesCount(Object count);

  /// No description provided for @noSavedArticles.
  ///
  /// In en, this message translates to:
  /// **'No saved articles yet.'**
  String get noSavedArticles;

  /// No description provided for @curationSpaceEmpty.
  ///
  /// In en, this message translates to:
  /// **'Your curation space is empty.'**
  String get curationSpaceEmpty;

  /// No description provided for @startExploring.
  ///
  /// In en, this message translates to:
  /// **'Start Exploring'**
  String get startExploring;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in to continue your curated narrative.'**
  String get loginSubtitle;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'EMAIL ADDRESS'**
  String get emailAddress;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'PASSWORD'**
  String get password;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'SIGN IN'**
  String get signIn;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'OR CONTINUE WITH'**
  String get orContinueWith;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE WITH GOOGLE'**
  String get continueWithGoogle;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? '**
  String get dontHaveAccount;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @continueAsGuest.
  ///
  /// In en, this message translates to:
  /// **'CONTINUE AS GUEST'**
  String get continueAsGuest;

  /// No description provided for @footerCopyright.
  ///
  /// In en, this message translates to:
  /// **'© 2026 INSIGHTLY. ALL RIGHTS RESERVED.'**
  String get footerCopyright;

  /// No description provided for @joinInsightly.
  ///
  /// In en, this message translates to:
  /// **'Join Insightly'**
  String get joinInsightly;

  /// No description provided for @signupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Where the world meets your screen.'**
  String get signupSubtitle;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'FULL NAME'**
  String get fullName;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get alreadyHaveAccount;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @pleaseFillFields.
  ///
  /// In en, this message translates to:
  /// **'Please fill all fields'**
  String get pleaseFillFields;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get invalidEmail;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match!'**
  String get passwordsDoNotMatch;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters long.'**
  String get passwordMinLength;

  /// No description provided for @passwordUppercase.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one uppercase letter.'**
  String get passwordUppercase;

  /// No description provided for @passwordLowercase.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one lowercase letter.'**
  String get passwordLowercase;

  /// No description provided for @passwordNumber.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one number.'**
  String get passwordNumber;

  /// No description provided for @passwordSpecialChar.
  ///
  /// In en, this message translates to:
  /// **'Password must contain at least one special character.'**
  String get passwordSpecialChar;

  /// No description provided for @topTopic.
  ///
  /// In en, this message translates to:
  /// **'Top Topic'**
  String get topTopic;

  /// No description provided for @designYourDaily.
  ///
  /// In en, this message translates to:
  /// **'DESIGN YOUR DAILY'**
  String get designYourDaily;

  /// No description provided for @pickTopicsInstruction.
  ///
  /// In en, this message translates to:
  /// **'Pick a few topics you love so we can tailor your feed just for you.'**
  String get pickTopicsInstruction;

  /// No description provided for @calibrated.
  ///
  /// In en, this message translates to:
  /// **'{count} OF 5 TOPICS CALIBRATED'**
  String calibrated(Object count);

  /// No description provided for @continueBriefing.
  ///
  /// In en, this message translates to:
  /// **'Continue Briefing'**
  String get continueBriefing;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'EDIT PROFILE'**
  String get editProfile;

  /// No description provided for @personalInfo.
  ///
  /// In en, this message translates to:
  /// **'PERSONAL INFO'**
  String get personalInfo;

  /// No description provided for @fullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'FULL NAME'**
  String get fullNameLabel;

  /// No description provided for @updateName.
  ///
  /// In en, this message translates to:
  /// **'UPDATE NAME'**
  String get updateName;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'SECURITY'**
  String get security;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'PREFERENCES'**
  String get preferences;

  /// No description provided for @yourTopics.
  ///
  /// In en, this message translates to:
  /// **'Your Topics'**
  String get yourTopics;

  /// No description provided for @selected.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get selected;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @yourTopicsTitle.
  ///
  /// In en, this message translates to:
  /// **'YOUR TOPICS'**
  String get yourTopicsTitle;

  /// No description provided for @changePasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'CHANGE PASSWORD'**
  String get changePasswordTitle;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'CURRENT PASSWORD'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'NEW PASSWORD'**
  String get newPassword;

  /// No description provided for @confirmPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'CONFIRM PASSWORD'**
  String get confirmPasswordTitle;

  /// No description provided for @updatePassword.
  ///
  /// In en, this message translates to:
  /// **'UPDATE PASSWORD'**
  String get updatePassword;

  /// No description provided for @chooseAvatar.
  ///
  /// In en, this message translates to:
  /// **'CHOOSE AVATAR'**
  String get chooseAvatar;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @guestProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Guest Profile'**
  String get guestProfileTitle;

  /// No description provided for @guestProfileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Log in to track your reading stats, manage your topics, and adjust your preferences.'**
  String get guestProfileSubtitle;

  /// No description provided for @guestLibraryTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Private Library'**
  String get guestLibraryTitle;

  /// No description provided for @guestLibrarySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create an account to bookmark articles and build your curated intelligence feed.'**
  String get guestLibrarySubtitle;

  /// No description provided for @commentsCount.
  ///
  /// In en, this message translates to:
  /// **'{count} COMMENTS'**
  String commentsCount(Object count);

  /// No description provided for @addToBriefing.
  ///
  /// In en, this message translates to:
  /// **'...ADD TO BRIEFING'**
  String get addToBriefing;

  /// No description provided for @postComment.
  ///
  /// In en, this message translates to:
  /// **'POST COMMENT'**
  String get postComment;

  /// No description provided for @noCommentsYet.
  ///
  /// In en, this message translates to:
  /// **'No comments yet. Be the first to share your thoughts!'**
  String get noCommentsYet;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'COMPLETED'**
  String get completed;

  /// No description provided for @extractingArticle.
  ///
  /// In en, this message translates to:
  /// **'Extracting full article...'**
  String get extractingArticle;

  /// No description provided for @trending.
  ///
  /// In en, this message translates to:
  /// **'TRENDING'**
  String get trending;

  /// No description provided for @comments.
  ///
  /// In en, this message translates to:
  /// **'COMMENTS'**
  String get comments;

  /// No description provided for @maxTopicsAllowed.
  ///
  /// In en, this message translates to:
  /// **'Max 5 topics allowed'**
  String get maxTopicsAllowed;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'es', 'fr', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
