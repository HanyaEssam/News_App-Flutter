// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'INSIGHTLY';

  @override
  String get dailyBriefing => '每日简报';

  @override
  String get trendingNow => '热门趋势';

  @override
  String get forYou => '为你推荐';

  @override
  String get profile => '个人资料';

  @override
  String get settings => '设置';

  @override
  String get articlesRead => '已读文章';

  @override
  String get minutesSaved => '节省时间';

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
  String get saved => '收藏';

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
  String basedOnInterest(Object category) {
    return '基于您对 $category 的兴趣';
  }

  @override
  String feedTitle(Object category) {
    return '$category 动态';
  }

  @override
  String get intelligence => '情报';

  @override
  String get searchPageTitle => '搜索';

  @override
  String get searchHint => '搜索新闻、主题或作者';

  @override
  String get recentSearches => '最近搜索';

  @override
  String get trendingTopics => '热门话题';

  @override
  String get savedPageTitle => '收藏文章';

  @override
  String savedArticlesCount(Object count) {
    return '$count 篇收藏文章';
  }

  @override
  String get noSavedArticles => '暂无收藏文章。';

  @override
  String get curationSpaceEmpty => '您的策展空间是空的。';

  @override
  String get startExploring => '开始探索';

  @override
  String get loginSubtitle => '登录以继续您的定制叙述。';

  @override
  String get emailAddress => '电子邮箱';

  @override
  String get password => '密码';

  @override
  String get signIn => '登录';

  @override
  String get orContinueWith => '或使用以下方式登录';

  @override
  String get continueWithGoogle => '使用 Google 登录';

  @override
  String get dontHaveAccount => '还没有账户？';

  @override
  String get createAccount => '注册';

  @override
  String get continueAsGuest => '以访客身份继续';

  @override
  String get footerCopyright => '© 2026 INSIGHTLY. 保留所有权利。';

  @override
  String get joinInsightly => '加入 Insightly';

  @override
  String get signupSubtitle => '世界与您的屏幕相遇。';

  @override
  String get fullName => '全名';

  @override
  String get confirmPassword => '确认密码';

  @override
  String get alreadyHaveAccount => '已有账户？';

  @override
  String get login => '登录';

  @override
  String get pleaseFillFields => '请填写所有字段';

  @override
  String get invalidEmail => '请输入有效的电子邮箱';

  @override
  String get passwordsDoNotMatch => '密码不匹配！';

  @override
  String get passwordMinLength => '密码至少需要 8 个字符。';

  @override
  String get passwordUppercase => '密码必须包含至少一个大写字母。';

  @override
  String get passwordLowercase => '密码必须包含至少一个小写字母。';

  @override
  String get passwordNumber => '密码必须包含至少一个数字。';

  @override
  String get passwordSpecialChar => '密码必须包含至少一个特殊字符。';

  @override
  String get topTopic => '热门话题';

  @override
  String get designYourDaily => '设计您的每日动态';

  @override
  String get pickTopicsInstruction => '选择几个您喜欢的主题，以便我们为您定制动态。';

  @override
  String calibrated(Object count) {
    return '已选择 $count/5 个主题';
  }

  @override
  String get continueBriefing => '继续简报';

  @override
  String get editProfile => '编辑资料';

  @override
  String get personalInfo => '个人信息';

  @override
  String get fullNameLabel => '全名';

  @override
  String get updateName => '更新姓名';

  @override
  String get security => '安全';

  @override
  String get changePassword => '修改密码';

  @override
  String get preferences => '偏好设置';

  @override
  String get yourTopics => '您关注的主题';

  @override
  String get selected => '已选';

  @override
  String get none => '无';

  @override
  String get yourTopicsTitle => '您的主题';

  @override
  String get changePasswordTitle => '修改密码';

  @override
  String get currentPassword => '当前密码';

  @override
  String get newPassword => '新密码';

  @override
  String get confirmPasswordTitle => '确认密码';

  @override
  String get updatePassword => '更新密码';

  @override
  String get chooseAvatar => '选择头像';

  @override
  String get update => '更新';

  @override
  String get guestProfileTitle => '访客资料';

  @override
  String get guestProfileSubtitle => '登录以跟踪您的阅读统计数据、管理主题并调整偏好。';

  @override
  String get guestLibraryTitle => '您的私人图书馆';

  @override
  String get guestLibrarySubtitle => '创建一个账户以收藏文章并建立您的策展情报流。';

  @override
  String commentsCount(Object count) {
    return '$count 条评论';
  }

  @override
  String get addToBriefing => '...添加到简报';

  @override
  String get postComment => '发表评论';

  @override
  String get noCommentsYet => '暂无评论。成为第一个分享想法的人！';

  @override
  String get completed => '已完成';

  @override
  String get extractingArticle => '正在提取全文...';

  @override
  String get trending => '热门';

  @override
  String get comments => '评论';

  @override
  String get maxTopicsAllowed => '最多允许选择 5 个主题';
}
