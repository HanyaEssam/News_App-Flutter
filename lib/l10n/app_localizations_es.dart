// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'INSIGHTLY';

  @override
  String get dailyBriefing => 'Tu resumen diario';

  @override
  String get trendingNow => 'Tendencias';

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
  String get saved => 'Guardado';

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
  String get recent => 'RECIENTE';

  @override
  String get minRead => 'min de lectura';

  @override
  String get mainSource => 'Fuente principal';

  @override
  String basedOnInterest(Object category) {
    return 'Basado en tu interés en $category';
  }

  @override
  String feedTitle(Object category) {
    return 'Feed de $category';
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
  String get trendingTopics => 'Temas de tendencia';

  @override
  String get savedPageTitle => 'Artículos guardados';

  @override
  String savedArticlesCount(Object count) {
    return '$count Artículos guardados';
  }

  @override
  String get noSavedArticles => 'Aún no hay artículos guardados.';

  @override
  String get curationSpaceEmpty => 'Tu espacio de curación está vacío.';

  @override
  String get startExploring => 'Comenzar a explorar';

  @override
  String get loginSubtitle =>
      'Inicia sesión para continuar tu narrativa curada.';

  @override
  String get emailAddress => 'DIRECCIÓN DE CORREO';

  @override
  String get password => 'CONTRASEÑA';

  @override
  String get signIn => 'INICIAR SESIÓN';

  @override
  String get orContinueWith => 'O CONTINUAR CON';

  @override
  String get continueWithGoogle => 'CONTINUAR CON GOOGLE';

  @override
  String get dontHaveAccount => '¿No tienes cuenta? ';

  @override
  String get createAccount => 'Crear cuenta';

  @override
  String get continueAsGuest => 'CONTINUAR COMO INVITADO';

  @override
  String get footerCopyright =>
      '© 2026 INSIGHTLY. TODOS LOS DERECHOS RESERVADOS.';

  @override
  String get joinInsightly => 'Únete a Insightly';

  @override
  String get signupSubtitle => 'Donde el mundo se encuentra con tu pantalla.';

  @override
  String get fullName => 'NOMBRE COMPLETO';

  @override
  String get confirmPassword => 'Confirmar contraseña';

  @override
  String get alreadyHaveAccount => '¿Ya tienes una cuenta? ';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get pleaseFillFields => 'Por favor, rellena todos los campos';

  @override
  String get invalidEmail => 'Por favor, introduce un correo válido';

  @override
  String get passwordsDoNotMatch => '¡Las contraseñas no coinciden!';

  @override
  String get passwordMinLength =>
      'La contraseña debe tener al menos 8 caracteres.';

  @override
  String get passwordUppercase => 'Debe contener una mayúscula.';

  @override
  String get passwordLowercase => 'Debe contener una minúscula.';

  @override
  String get passwordNumber => 'Debe contener un número.';

  @override
  String get passwordSpecialChar => 'Debe contener un carácter especial.';

  @override
  String get topTopic => 'Tema principal';

  @override
  String get designYourDaily => 'DISEÑA TU DIARIO';

  @override
  String get pickTopicsInstruction =>
      'Elige algunos temas que te encanten para personalizar tu feed.';

  @override
  String calibrated(Object count) {
    return '$count DE 5 TEMAS CALIBRADOS';
  }

  @override
  String get continueBriefing => 'Continuar briefing';

  @override
  String get editProfile => 'EDITAR PERFIL';

  @override
  String get personalInfo => 'INFO PERSONAL';

  @override
  String get fullNameLabel => 'NOMBRE COMPLETO';

  @override
  String get updateName => 'ACTUALIZAR NOMBRE';

  @override
  String get security => 'SEGURIDAD';

  @override
  String get changePassword => 'Cambiar contraseña';

  @override
  String get preferences => 'PREFERENCIAS';

  @override
  String get yourTopics => 'Tus temas';

  @override
  String get selected => 'Seleccionado';

  @override
  String get none => 'Ninguno';

  @override
  String get yourTopicsTitle => 'TUS TEMAS';

  @override
  String get changePasswordTitle => 'CAMBIAR CONTRASEÑA';

  @override
  String get currentPassword => 'CONTRASEÑA ACTUAL';

  @override
  String get newPassword => 'NUEVA CONTRASEÑA';

  @override
  String get confirmPasswordTitle => 'CONFIRMAR CONTRASEÑA';

  @override
  String get updatePassword => 'ACTUALIZAR CONTRASEÑA';

  @override
  String get chooseAvatar => 'ELEGIR AVATAR';

  @override
  String get update => 'Actualizar';

  @override
  String get guestProfileTitle => 'Perfil de invitado';

  @override
  String get guestProfileSubtitle =>
      'Inicia sesión para rastrear tus estadísticas, gestionar temas y preferencias.';

  @override
  String get guestLibraryTitle => 'Tu biblioteca privada';

  @override
  String get guestLibrarySubtitle =>
      'Crea una cuenta para guardar artículos y construir tu feed de inteligencia.';

  @override
  String commentsCount(Object count) {
    return '$count COMENTARIOS';
  }

  @override
  String get addToBriefing => '...AÑADIR AL BRIEFING';

  @override
  String get postComment => 'PUBLICAR COMENTARIO';

  @override
  String get noCommentsYet =>
      'Aún no hay comentarios. ¡Sé el primero en opinar!';

  @override
  String get completed => 'COMPLETADO';

  @override
  String get extractingArticle => 'Extrayendo artículo completo...';

  @override
  String get trending => 'TENDENCIA';

  @override
  String get comments => 'COMENTARIOS';

  @override
  String get maxTopicsAllowed => 'Máximo 5 temas permitidos';
}
