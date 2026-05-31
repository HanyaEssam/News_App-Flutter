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
  String get logoutSession => 'Se déconnecter';

  @override
  String get home => 'Accueil';

  @override
  String get search => 'Recherche';

  @override
  String get saved => 'Enregistrés';

  @override
  String get tech => 'Technologie';

  @override
  String get business => 'Économie';

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
    return 'Basé sur votre intérêt pour $category';
  }

  @override
  String feedTitle(String category) {
    return 'Actualités $category';
  }

  @override
  String get intelligence => 'Intelligence';

  @override
  String get searchPageTitle => 'Recherche';

  @override
  String get searchHint => 'Rechercher des actualités, sujets ou auteurs';

  @override
  String get recentSearches => 'Recherches récentes';

  @override
  String get trendingTopics => 'Sujets tendances';

  @override
  String get savedPageTitle => 'Articles enregistrés';

  @override
  String savedArticlesCount(String count) {
    return '$count Articles enregistrés';
  }

  @override
  String get noSavedArticles => 'Aucun article enregistré pour le moment.';

  @override
  String get curationSpaceEmpty =>
      'Votre espace est vide. Explorez et sauvegardez des articles pour personnaliser votre flux.';

  @override
  String get startExploring => 'Commencer à explorer';

  @override
  String get loginSubtitle => 'Connectez-vous pour continuer votre lecture.';

  @override
  String get emailAddress => 'Adresse e-mail';

  @override
  String get password => 'Mot de passe';

  @override
  String get signIn => 'Se connecter';

  @override
  String get orContinueWith => 'Ou continuer avec';

  @override
  String get continueWithGoogle => 'Continuer avec Google';

  @override
  String get dontHaveAccount => 'Vous n\'avez pas de compte ? ';

  @override
  String get createAccount => 'Créer un compte';

  @override
  String get continueAsGuest => 'Continuer en tant qu\'invité';

  @override
  String get footerCopyright =>
      '© 2026 Insightly - Confidentialité et conditions.';

  @override
  String get joinInsightly => 'Rejoindre Insightly';

  @override
  String get signupSubtitle => 'Où le monde rencontre votre écran.';

  @override
  String get fullName => 'Nom complet';

  @override
  String get confirmPassword => 'Confirmer le mot de passe';

  @override
  String get alreadyHaveAccount => 'Vous avez déjà un compte ? ';

  @override
  String get login => 'Connexion';

  @override
  String get pleaseFillFields => 'Veuillez remplir tous les champs';

  @override
  String get invalidEmail => 'Veuillez entrer un email valide';

  @override
  String get passwordsDoNotMatch => 'Les mots de passe ne correspondent pas !';

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

  @override
  String get topTopic => 'Sujet Principal';

  @override
  String get designYourDaily => 'PERSONNALISEZ VOTRE QUOTIDIEN';

  @override
  String get pickTopicsSubtitle =>
      'Choisissez quelques sujets que vous aimez afin que nous puissions adapter votre flux.';

  @override
  String calibrated(String count) {
    return '$count SUR 5 SUJETS CALIBRÉS';
  }

  @override
  String get continueBriefing => 'Continuer le briefing';
}
