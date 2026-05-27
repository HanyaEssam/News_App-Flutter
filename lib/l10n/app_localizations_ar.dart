// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'إنسايتلي';

  @override
  String get dailyBriefing => 'موجزك اليومي';

  @override
  String get trendingNow => 'الشائع الآن';

  @override
  String get forYou => 'من أجلك';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get settings => 'الإعدادات';

  @override
  String get articlesRead => 'مقالات قرأتها';

  @override
  String get minutesSaved => 'دقائق وفرتها';

  @override
  String get appearance => 'المظهر';

  @override
  String get darkMode => 'الوضع الداكن';

  @override
  String get lightMode => 'الوضع الفاتح';

  @override
  String get language => 'اللغة';

  @override
  String get logoutSession => 'تسجيل الخروج';

  @override
  String get home => 'الرئيسية';

  @override
  String get search => 'بحث';

  @override
  String get saved => 'المحفوظات';

  @override
  String get tech => 'تكنولوجيا';

  @override
  String get business => 'أعمال';

  @override
  String get sports => 'رياضة';

  @override
  String get politics => 'سياسة';

  @override
  String get science => 'علوم';

  @override
  String get health => 'صحة';

  @override
  String get travel => 'سفر';

  @override
  String get entertainment => 'ترفيه';

  @override
  String get general => 'عام';

  @override
  String get trendingLabel => 'شائع';

  @override
  String get recent => 'حديث';

  @override
  String get minRead => 'دقيقة قراءة';

  @override
  String get mainSource => 'المصدر الرئيسي';

  @override
  String basedOnInterest(String category) {
    return 'بناءً على اهتمامك في $category';
  }

  @override
  String feedTitle(String category) {
    return 'أخبار $category';
  }

  @override
  String get intelligence => 'رؤى';

  @override
  String get searchPageTitle => 'بحث';

  @override
  String get searchHint => 'ابحث عن الأخبار، المواضيع، أو المؤلفين';

  @override
  String get recentSearches => 'عمليات البحث الأخيرة';

  @override
  String get trendingTopics => 'المواضيع الشائعة';

  @override
  String get savedPageTitle => 'المحفوظات';

  @override
  String savedArticlesCount(String count) {
    return 'المقالات المحفوظة $count';
  }

  @override
  String get noSavedArticles => 'لا توجد مقالات محفوظة بعد.';

  @override
  String get curationSpaceEmpty =>
      'مساحة الحفظ الخاصة بك فارغة. استكشف أحدث الرؤى واحفظ المقالات لبناء موجز الأخبار المخصص لك.';

  @override
  String get startExploring => 'ابدأ الاستكشاف';

  @override
  String get loginSubtitle => 'سجل الدخول لمتابعة رحلتك المعرفية.';

  @override
  String get emailAddress => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get orContinueWith => 'أو تابع باستخدام';

  @override
  String get continueWithGoogle => 'المتابعة مع جوجل';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟ ';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get continueAsGuest => 'المتابعة كزائر';

  @override
  String get footerCopyright => '© 2026 إنسايتفول - الخصوصية والشروط.';

  @override
  String get joinInsightly => 'انضم إلى إنسايتلي';

  @override
  String get signupSubtitle => 'حيث يلتقي العالم بشاشتك.';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get alreadyHaveAccount => 'هل لديك حساب بالفعل؟ ';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get pleaseFillFields => 'يرجى ملء جميع الحقول';

  @override
  String get invalidEmail => 'يرجى إدخال بريد إلكتروني صحيح';

  @override
  String get passwordsDoNotMatch => 'كلمات المرور غير متطابقة!';

  @override
  String get passwordMinLength => 'يجب أن تكون كلمة المرور 8 أحرف على الأقل.';

  @override
  String get passwordUppercase =>
      'يجب أن تحتوي كلمة المرور على حرف كبير واحد على الأقل.';

  @override
  String get passwordLowercase =>
      'يجب أن تحتوي كلمة المرور على حرف صغير واحد على الأقل.';

  @override
  String get passwordNumber =>
      'يجب أن تحتوي كلمة المرور على رقم واحد على الأقل.';

  @override
  String get passwordSpecialChar =>
      'يجب أن تحتوي كلمة المرور على رمز خاص واحد على الأقل.';
}
