// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Insightly';

  @override
  String get dailyBriefing => 'Tu resumen diario';

  @override
  String get trendingNow => 'Tendencias ahora';

  @override
  String get forYou => 'Para ti';

  @override
  String get profile => 'Perfil';

  @override
  String get settings => 'Ajustes';

  @override
  String get articlesRead => 'Artículos leídos';

  @override
  String get minutesSaved => 'Minutos ahorrados';

  @override
  String get appearance => 'Apariencia';

  @override
  String get darkMode => 'Modo oscuro';

  @override
  String get lightMode => 'Modo claro';

  @override
  String get language => 'Idioma';

  @override
  String get logoutSession => 'Cerrar sesión';

  @override
  String get home => 'Inicio';

  @override
  String get search => 'Buscar';

  @override
  String get saved => 'Guardados';

  @override
  String get tech => 'Tecnología';

  @override
  String get business => 'Negocios';

  @override
  String get sports => 'Deportes';

  @override
  String get politics => 'Política';

  @override
  String get science => 'Ciencia';

  @override
  String get health => 'Salud';

  @override
  String get travel => 'Viajes';

  @override
  String get entertainment => 'Entretenimiento';

  @override
  String get general => 'General';

  @override
  String get trendingLabel => 'Tendencia';

  @override
  String get recent => 'Reciente';

  @override
  String get minRead => 'min de lectura';

  @override
  String get mainSource => 'Fuente principal';

  @override
  String basedOnInterest(String category) {
    return 'BASADO EN TU INTERÉS EN $category';
  }

  @override
  String feedTitle(String category) {
    return 'Noticias de $category';
  }

  @override
  String get intelligence => 'Inteligencia';

  @override
  String get searchPageTitle => 'Buscar';

  @override
  String get searchHint => 'Buscar noticias, temas o autores';

  @override
  String get recentSearches => 'Búsquedas recientes';

  @override
  String get trendingTopics => 'Temas del momento';

  @override
  String get savedPageTitle => 'Guardados';

  @override
  String savedArticlesCount(String count) {
    return 'ARTÍCULOS GUARDADOS $count';
  }

  @override
  String get noSavedArticles => 'Aún no hay artículos guardados.';

  @override
  String get curationSpaceEmpty =>
      'Tu espacio de curación está vacío. Explora las últimas novedades y guarda artículos para crear tu feed personalizado.';

  @override
  String get startExploring => 'Empezar a explorar';

  @override
  String get loginSubtitle =>
      'Inicia sesión para continuar tu narrativa curada.';

  @override
  String get emailAddress => 'CORREO ELECTRÓNICO';

  @override
  String get password => 'CONTRASEÑA';

  @override
  String get signIn => 'Iniciar Sesión';

  @override
  String get orContinueWith => 'O CONTINÚA CON';

  @override
  String get continueWithGoogle => 'Continuar con Google';

  @override
  String get dontHaveAccount => '¿No tienes cuenta? ';

  @override
  String get createAccount => 'Crear Cuenta';

  @override
  String get continueAsGuest => 'Continuar como invitado';

  @override
  String get footerCopyright => '© 2026 INSIGHTFUL PRIVACIDAD Y TÉRMINOS.';

  @override
  String get joinInsightly => 'ÚNETE A INSIGHTLY';

  @override
  String get signupSubtitle => 'Donde el mundo se encuentra con tu pantalla.';

  @override
  String get fullName => 'NOMBRE COMPLETO';

  @override
  String get confirmPassword => 'CONFIRMAR CONTRASEÑA';

  @override
  String get alreadyHaveAccount => '¿Ya tienes una cuenta? ';

  @override
  String get login => 'Iniciar Sesión';

  @override
  String get pleaseFillFields => 'Por favor completa todos los campos';

  @override
  String get invalidEmail => 'Por favor ingresa un correo válido';

  @override
  String get passwordsDoNotMatch => '¡Las contraseñas no coinciden!';

  @override
  String get passwordMinLength =>
      'La contraseña debe tener al menos 8 caracteres.';

  @override
  String get passwordUppercase =>
      'La contraseña debe contener al menos una mayúscula.';

  @override
  String get passwordLowercase =>
      'La contraseña debe contener al menos una minúscula.';

  @override
  String get passwordNumber =>
      'La contraseña debe contener al menos un número.';

  @override
  String get passwordSpecialChar =>
      'La contraseña debe contener al menos un carácter especial.';
}
