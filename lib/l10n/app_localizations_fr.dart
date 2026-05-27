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

  @override
  String get loginSubtitle =>
      'Connectez-vous pour continuer votre récit personnalisé.';

  @override
  String get emailAddress => 'ADRESSE E-MAIL';

  @override
  String get password => 'MOT DE PASSE';

  @override
  String get signIn => 'Se Connecter';

  @override
  String get orContinueWith => 'OU CONTINUER AVEC';

  @override
  String get continueWithGoogle => 'Continuer avec Google';

  @override
  String get dontHaveAccount => 'Vous n\'avez pas de compte? ';

  @override
  String get createAccount => 'Créer un Compte';

  @override
  String get continueAsGuest => 'Continuer en tant qu\'invité';

  @override
  String get footerCopyright =>
      '© 2026 INSIGHTFUL CONFIDENTIALITÉ ET CONDITIONS.';

  @override
  String get joinInsightly => 'REJOIGNEZ INSIGHTLY';

  @override
  String get signupSubtitle => 'Où le monde rencontre votre écran.';

  @override
  String get fullName => 'NOM COMPLET';

  @override
  String get confirmPassword => 'CONFIRMER LE MOT DE PASSE';

  @override
  String get alreadyHaveAccount => 'Vous avez déjà un compte? ';

  @override
  String get login => 'Connexion';

  @override
  String get pleaseFillFields => 'Veuillez remplir tous les champs';

  @override
  String get invalidEmail => 'Veuillez entrer un e-mail valide';

  @override
  String get passwordsDoNotMatch => 'Les mots de passe ne correspondent pas!';

  @override
  String get passwordMinLength =>
      'Le mot de passe doit comporter au moins 8 caractères.';

  @override
  String get passwordUppercase =>
      'Le mot de passe doit contenir au moins une majuscule.';

  @override
  String get passwordLowercase =>
      'Le mot de passe doit contenir au moins une minuscule.';

  @override
  String get passwordNumber =>
      'Le mot de passe doit contenir au moins un chiffre.';

  @override
  String get passwordSpecialChar =>
      'Le mot de passe doit contenir au moins un caractère spécial.';
}
