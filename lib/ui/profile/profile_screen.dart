import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/background_color/app_background.dart';
import '../../core/utils/saved_articles_manager.dart';
import '../../core/utils/responsive.dart';
import '../edit_profile/edit_profile_screen.dart';
import '../../core/widgets/profile_widgets/metric_card.dart';
import '../../core/widgets/profile_widgets/profile_header.dart';
import '../../core/widgets/profile_widgets/setting_row.dart';
import '../../../core/theme/theme_controller.dart';
import '../auth/login/login_screen.dart';
import '../../../core/utils/guest_checker.dart';
import '../../../core/widgets/guest/guest_widget.dart';
import 'package:news/l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import '../../../core/utils/locale_provider.dart';
import '../../../core/widgets/language_picker.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = 'Loading...';
  String _avatarUrl = '';
  String _articlesRead = '0';
  String _topTopic = '...';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .snapshots()
            .listen((doc) {
          if (doc.exists && mounted) {
            final data = doc.data()!;
            setState(() {
              _userName = data['fullName'] ?? 'User';
              _avatarUrl = data['avatarUrl'] ?? '';
              _articlesRead = (data['articlesRead'] ?? 0).toString();

              Map<String, dynamic> categoryCounts =
                  data['categoryCounts'] ?? {};

              if (categoryCounts.isNotEmpty) {
                var topCategoryEntry = categoryCounts.entries.reduce(
                        (a, b) =>
                    (a.value as num) > (b.value as num) ? a : b);
                String rawTopic = topCategoryEntry.key;
                _topTopic =
                "${rawTopic[0].toUpperCase()}${rawTopic.substring(1).toLowerCase()}";
              } else {
                List<dynamic> topics = data['selectedTopics'] ?? [];
                if (topics.isNotEmpty &&
                    topics.first.toString().isNotEmpty) {
                  String rawTopic = topics.first.toString();
                  _topTopic =
                  "${rawTopic[0].toUpperCase()}${rawTopic.substring(1).toLowerCase()}";
                } else {
                  _topTopic = 'General';
                }
              }

              _isLoading = false;
            });
          }
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
      debugPrint("Error fetching user data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final currentCode =
        Provider.of<LocaleProvider>(context).locale?.languageCode ?? 'en';
    final selectedLanguageString = switch (currentCode) {
      'ar' => 'العربية',
      'es' => 'Español',
      'fr' => 'Français',
      _ => 'English (UK)',
    };

    if (GuestChecker.isGuest()) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text(AppLocalizations.of(context)!.appTitle.toUpperCase()),
        ),
        body: AppBackground(
          child: const GuestWidget(
            icon: Icons.person_outline,
            title: 'Guest Profile',
            subtitle:
            'Log in to track your reading stats, manage your topics, and adjust your preferences.',
          ),
        ),
      );
    }

    final double maxContentWidth =
    Responsive.isMobile(context) ? double.infinity : 600;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text(AppLocalizations.of(context)!.appTitle.toUpperCase()),
        actions: [
          IconButton(
            icon: Icon(
              Icons.edit_outlined,
              size: Responsive.scale(context, 24),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditProfileScreen(),
                ),
              );
            },
          ),
          SizedBox(width: Responsive.scale(context, 8)),
        ],
      ),
      body: AppBackground(
        child: SafeArea(
          child: _isLoading
              ? Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            ),
          )
              : Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxContentWidth),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.scale(context, 20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Responsive.scale(context, 20)),
                    ProfileHeader(
                      userName: _userName,
                      avatarPath: _avatarUrl,
                    ),
                    SizedBox(height: Responsive.scale(context, 40)),
                    Row(
                      children: [
                        Expanded(
                          child: MetricCard(
                            title: AppLocalizations.of(context)!
                                .articlesRead,
                            value: _articlesRead,
                          ),
                        ),
                        SizedBox(width: Responsive.scale(context, 16)),
                        Expanded(
                          child: MetricCard(
                            title: 'TOP TOPIC',
                            value: _topTopic,
                            isWord: true,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: Responsive.scale(context, 40)),
                    Text(
                      AppLocalizations.of(context)!
                          .appearance
                          .toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(
                        fontSize: Responsive.scaleText(context, 12),
                      ),
                    ),
                    SizedBox(height: Responsive.scale(context, 12)),
                    SettingsRow(
                      leadingIcon: isDarkMode
                          ? Icons.dark_mode_outlined
                          : Icons.light_mode_outlined,
                      title: isDarkMode
                          ? AppLocalizations.of(context)!.darkMode
                          : AppLocalizations.of(context)!.lightMode,
                      trailing: Switch(
                        value: isDarkMode,
                        activeColor:
                        Theme.of(context).colorScheme.primary,
                        activeTrackColor: AppColors.inputFill,
                        inactiveThumbColor: AppColors.mutedText,
                        onChanged: (value) async {
                          await ThemeController.toggleTheme(value);
                          final user =
                              FirebaseAuth.instance.currentUser;
                          if (user != null) {
                            FirebaseFirestore.instance
                                .collection('users')
                                .doc(user.uid)
                                .set(
                              {'isDarkMode': value},
                              SetOptions(merge: true),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(height: Responsive.scale(context, 32)),
                    Text(
                      AppLocalizations.of(context)!.language.toUpperCase(),
                      style: Theme.of(context)
                          .textTheme
                          .labelMedium
                          ?.copyWith(
                        fontSize: Responsive.scaleText(context, 12),
                      ),
                    ),
                    SizedBox(height: Responsive.scale(context, 12)),
                    SettingsRow(
                      leadingIcon: Icons.language,
                      title: AppLocalizations.of(context)!.language,
                      trailing: TextButton(
                        onPressed: () async {
                          await LanguagePicker.show(context);
                          if (context.mounted) {
                            final newCode =
                                Provider.of<LocaleProvider>(context,
                                    listen: false)
                                    .locale
                                    ?.languageCode ?? 'en';
                            final user =
                                FirebaseAuth.instance.currentUser;
                            if (user != null) {
                              FirebaseFirestore.instance
                                  .collection('users')
                                  .doc(user.uid)
                                  .set(
                                {'language': newCode},
                                SetOptions(merge: true),
                              );
                            }
                          }
                        },
                        style: TextButton.styleFrom(
                            padding: EdgeInsets.zero),
                        child: Text(
                          selectedLanguageString,
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .primary,
                            fontSize:
                            Responsive.scaleText(context, 16),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.scale(context, 48)),
                    OutlinedButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.signOut();
                        if (context.mounted) {
                          SavedArticlesManager.clearSession();
                          Provider.of<LocaleProvider>(context,
                              listen: false)
                              .setLocale(const Locale('en'));
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            LoginScreen.routeName,
                                (route) => false,
                          );
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        minimumSize: Size(
                          double.infinity,
                          Responsive.scale(context, 56),
                        ),
                        side: const BorderSide(
                          color: AppColors.error,
                          width: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            Responsive.scale(context, 14),
                          ),
                        ),
                      ),
                      child: Text(
                        AppLocalizations.of(context)!
                            .logoutSession
                            .toUpperCase(),
                        style: Theme.of(context)
                            .textTheme
                            .labelMedium
                            ?.copyWith(
                          color: AppColors.error,
                          letterSpacing: 2,
                          fontSize:
                          Responsive.scaleText(context, 12),
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.scale(context, 40)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}