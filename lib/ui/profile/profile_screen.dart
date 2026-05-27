import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/background_color/app_background.dart';
import '../../core/utils/saved_articles_manager.dart';
import '../../core/widgets/profile_widgets/edit_profile_screen.dart';
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

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String selectedLanguage = 'English (UK)';

  String _userName = 'Loading...';
  String _avatarUrl = '';
  String _articlesRead = '0';
  String _minutesSaved = '0';
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
        // Use snapshots() so the profile updates instantly when edited!
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
              _minutesSaved = (data['minutesSaved'] ?? 0).toString();
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

  void _showLanguagePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'CHOOSE LANGUAGE',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.mutedText,
                  ),
                ),
                const SizedBox(height: 16),

                // 🇬🇧 ENGLISH
                ListTile(
                  title: Text('English (UK)', style: Theme.of(context).textTheme.titleMedium),
                  trailing: selectedLanguage == 'English (UK)' ? const Icon(Icons.check_circle, color: AppColors.primary) : null,
                  onTap: () {
                    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

                    // 1. Close the bottom sheet FIRST to prevent Red Screen of Death
                    Navigator.pop(context);

                    // 2. Change language
                    setState(() => selectedLanguage = 'English (UK)');
                    localeProvider.setLocale(const Locale('en'));

                    // 3. Save to Cloud
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      FirebaseFirestore.instance.collection('users').doc(user.uid).set({
                        'language': 'en'
                      }, SetOptions(merge: true));
                    }
                  },
                ),

                // 🇸🇦 ARABIC
                ListTile(
                  title: Text(
                    'العربية (Arabic)',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing: selectedLanguage == 'العربية'
                      ? const Icon(Icons.check_circle, color: AppColors.primary)
                      : null,
                  onTap: () {
                    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

                    Navigator.pop(context); // Close FIRST

                    setState(() => selectedLanguage = 'العربية');
                    localeProvider.setLocale(const Locale('ar'));

                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      FirebaseFirestore.instance.collection('users').doc(user.uid).set({
                        'language': 'ar'
                      }, SetOptions(merge: true));
                    }
                  },
                ),

                // 🇪🇸 SPANISH
                ListTile(
                  title: Text(
                    'Español (Spanish)',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing: selectedLanguage == 'Español'
                      ? const Icon(Icons.check_circle, color: AppColors.primary)
                      : null,
                  onTap: () {
                    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

                    Navigator.pop(context); // Close FIRST

                    setState(() => selectedLanguage = 'Español');
                    localeProvider.setLocale(const Locale('es'));

                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      FirebaseFirestore.instance.collection('users').doc(user.uid).set({
                        'language': 'es'
                      }, SetOptions(merge: true));
                    }
                  },
                ),

                // 🇫🇷 FRENCH
                ListTile(
                  title: Text(
                    'Français (French)',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing: selectedLanguage == 'Français'
                      ? const Icon(Icons.check_circle, color: AppColors.primary)
                      : null,
                  onTap: () {
                    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);

                    Navigator.pop(context); // Close FIRST

                    setState(() => selectedLanguage = 'Français');
                    localeProvider.setLocale(const Locale('fr'));

                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      FirebaseFirestore.instance.collection('users').doc(user.uid).set({
                        'language': 'fr'
                      }, SetOptions(merge: true));
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    if (GuestChecker.isGuest()) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true, // ✅ Centered title
          backgroundColor: Colors.transparent,
          title: Text(AppLocalizations.of(context)!.appTitle.toUpperCase()),
        ),
        body: AppBackground(
          child: const GuestWidget(
            icon: Icons.person_outline,
            title: 'Guest Profile',
            subtitle: 'Log in to track your reading stats, manage your topics, and adjust your preferences.',
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true, // ✅ Centered title
        backgroundColor: Colors.transparent,
        title: Text(AppLocalizations.of(context)!.appTitle.toUpperCase()),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const EditProfileScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: AppBackground(
        child: SafeArea(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
              : SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                ProfileHeader(
                  userName: _userName,
                  avatarPath: _avatarUrl,
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    MetricCard(
                      title: AppLocalizations.of(context)!.articlesRead,
                      value: _articlesRead,
                    ),
                    const SizedBox(width: 16),
                    MetricCard(
                      title: AppLocalizations.of(context)!.minutesSaved,
                      value: _minutesSaved,
                      unit: 'm',
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Text(
                  AppLocalizations.of(context)!.appearance.toUpperCase(),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 12),
                SettingsRow(
                  leadingIcon: isDarkMode
                      ? Icons.dark_mode_outlined
                      : Icons.light_mode_outlined,
                  title: isDarkMode
                      ? AppLocalizations.of(context)!.darkMode
                      : AppLocalizations.of(context)!.lightMode,
                  trailing: Switch(
                    value: isDarkMode,
                    activeColor: AppColors.primary,
                    activeTrackColor: AppColors.inputFill,
                    inactiveThumbColor: AppColors.mutedText,
                    onChanged: (value) {
                      ThemeController.toggleTheme(value);
                    },
                  ),
                ),
                const SizedBox(height: 32),
                Text(
                  AppLocalizations.of(context)!.language.toUpperCase(),
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                const SizedBox(height: 12),
                SettingsRow(
                  leadingIcon: Icons.language,
                  title: AppLocalizations.of(context)!.language,
                  // 🔥 FIX: This just opens the picker now!
                  trailing: TextButton(
                    onPressed: () {
                      _showLanguagePicker(context);
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: Text(
                      selectedLanguage,
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(color: AppColors.primary),
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                OutlinedButton(
                  onPressed: () async {
                    // 1. Sign out of Firebase
                    await FirebaseAuth.instance.signOut();

                    if (context.mounted) {
                      // 2. Wipe the Saved Articles RAM clean
                      SavedArticlesManager.clearSession();

                      // 3. Reset language to English (or device default)
                      Provider.of<LocaleProvider>(context, listen: false).setLocale(const Locale('en'));

                      // 4. Kick them back to Login
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        LoginScreen.routeName,
                            (route) => false,
                      );
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    side: const BorderSide(
                      color: AppColors.error,
                      width: 1.5,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    AppLocalizations.of(
                      context,
                    )!.logoutSession.toUpperCase(),
                    style: Theme.of(context).textTheme.labelMedium
                        ?.copyWith(
                      color: AppColors.error,
                      letterSpacing: 2,
                    ),
                  ),

                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}