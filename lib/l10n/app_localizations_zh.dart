// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'Insightly';

  @override
  String get dailyBriefing => '每日简报';

  @override
  String get trendingNow => '当前趋势';

  @override
  String get forYou => '为你推荐';

  @override
  String get profile => '个人资料';

  @override
  String get settings => '设置';

  @override
  String get articlesRead => '已读文章';

  @override
  String get minutesSaved => '节省的分钟数';

  @override
  String get appearance => '外观';

  @override
  String get darkMode => '深色模式';

  @override
  String get lightMode => '浅色模式';

  @override
  String get language => '语言';

  @override
  String get logoutSession => '退出登录';

  @override
  String get home => '首页';

  @override
  String get search => '搜索';

  @override
  String get saved => '已保存';

  @override
  String get tech => '科技';

  @override
  String get business => '商业';

  @override
  String get sports => '体育';

  @override
  String get politics => '政治';

  @override
  String get science => '科学';

  @override
  String get health => '健康';

  @override
  String get travel => '旅游';

  @override
  String get entertainment => '娱乐';

  @override
  String get general => '综合';

  @override
  String get trendingLabel => '热门';

  @override
  String get recent => '最新';

  @override
  String get minRead => '分钟阅读';

  @override
  String get mainSource => '主要来源';

  @override
  String basedOnInterest(String category) {
    return '基于您对 $category 的兴趣';
  }

  @override
  String feedTitle(String category) {
    return '$category 新闻';
  }

  @override
  String get intelligence => '智能';

  @override
  String get searchPageTitle => '搜索';

  @override
  String get searchHint => '搜索新闻、主题或作者';

  @override
  String get recentSearches => '最近搜索';

  @override
  String get trendingTopics => '热门话题';

  @override
  String get savedPageTitle => '已保存的文章';

  @override
  String savedArticlesCount(String count) {
    return '已保存 $count 篇文章';
  }

  @override
  String get noSavedArticles => '暂无已保存的文章。';

  @override
  String get curationSpaceEmpty => '您的保存空间为空。探索最新见解并保存文章以构建您的个性化新闻流。';

  @override
  String get startExploring => '开始探索';

  @override
  String get loginSubtitle => '登录以继续您的知识之旅。';

  @override
  String get emailAddress => '电子邮件地址';

  @override
  String get password => '密码';

  @override
  String get signIn => '登录';

  @override
  String get orContinueWith => '或使用以下方式继续';

  @override
  String get continueWithGoogle => '使用 Google 账号继续';

  @override
  String get dontHaveAccount => '还没有账号？';

  @override
  String get createAccount => '创建账号';

  @override
  String get continueAsGuest => '以访客身份继续';

  @override
  String get footerCopyright => '© 2026 Insightly - 隐私与条款。';

  @override
  String get joinInsightly => '加入 Insightly';

  @override
  String get signupSubtitle => '世界在这里与您的屏幕相遇。';

  @override
  String get fullName => '全名';

  @override
  String get confirmPassword => '确认密码';

  @override
  String get alreadyHaveAccount => '已经有账号？';

  @override
  String get login => '登录';

  @override
  String get pleaseFillFields => '请填写所有字段';

  @override
  String get invalidEmail => '请输入有效的电子邮件地址';

  @override
  String get passwordsDoNotMatch => '密码不匹配！';

  @override
  String get passwordMinLength => '密码必须至少包含 8 个字符。';

  @override
  String get passwordUppercase => '密码必须包含至少一个大写字母。';

  @override
  String get passwordLowercase => '密码必须包含至少一个小写字母。';

  @override
  String get passwordNumber => '密码必须包含至少一个数字。';

  @override
  String get passwordSpecialChar => '密码必须包含至少一个特殊字符。';

  @override
  String get topTopic => '主要主题';

  @override
  String get designYourDaily => '定制您的日报';

  @override
  String get pickTopicsSubtitle => '选择您喜爱的几个主题，以便我们为您量身定制内容。';

  @override
  String calibrated(String count) {
    return '已完成 $count / 5 个主题设置';
  }

  @override
  String get continueBriefing => '继续简报';
}
