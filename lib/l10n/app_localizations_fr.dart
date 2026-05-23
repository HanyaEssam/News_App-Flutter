// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Insightly';

  @override
  String get dailyBriefing => 'Votre briefing quotidien';

  @override
  String get trendingNow => 'Tendances actuelles';

  @override
  String get forYou => 'Pour vous';

  @override
  String get profile => 'Profil';

  @override
  String get settings => 'Paramètres';

  @override
  String get articlesRead => 'Articles lus';

  @override
  String get minutesSaved => 'Minutes gagnées';

  @override
  String get appearance => 'Apparence';

  @override
  String get darkMode => 'Mode sombre';

  @override
  String get lightMode => 'Mode clair';

  @override
  String get language => 'Langue';

  @override
  String get logoutSession => 'Déconnexion';

  @override
  String get home => 'Accueil';

  @override
  String get search => 'Recherche';

  @override
  String get saved => 'Enregistrés';

  @override
  String get tech => 'Technologie';

  @override
  String get business => 'Affaires';

  @override
  String get sports => 'Sports';

  @override
  String get politics => 'Politique';

  @override
  String get science => 'Science';

  @override
  String get health => 'Santé';

  @override
  String get travel => 'Voyage';

  @override
  String get entertainment => 'Divertissement';

  @override
  String get general => 'Général';

  @override
  String get trendingLabel => 'Tendance';

  @override
  String get recent => 'Récent';

  @override
  String get minRead => 'min de lecture';

  @override
  String get mainSource => 'Source principale';

  @override
  String basedOnInterest(String category) {
    return 'BASÉ SUR VOTRE INTÉRÊT POUR $category';
  }

  @override
  String feedTitle(String category) {
    return 'Actualités $category';
  }

  @override
  String get intelligence => 'Informations';

  @override
  String get searchPageTitle => 'Recherche';

  @override
  String get searchHint =>
      'Rechercher des actualités, des sujets ou des auteurs';

  @override
  String get recentSearches => 'Recherches récentes';

  @override
  String get trendingTopics => 'Sujets tendances';

  @override
  String get savedPageTitle => 'Enregistrés';

  @override
  String savedArticlesCount(String count) {
    return 'ARTICLES ENREGISTRÉS $count';
  }

  @override
  String get noSavedArticles => 'Aucun article enregistré pour le moment.';

  @override
  String get curationSpaceEmpty =>
      'Votre espace de curation est vide. Explorez les dernières actualités et ajoutez des articles à vos favoris pour créer votre flux personnalisé.';

  @override
  String get startExploring => 'Commencer à explorer';
}
