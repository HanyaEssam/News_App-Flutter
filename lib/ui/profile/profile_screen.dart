import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/background_color/app_background.dart';
import '../../core/widgets/profile_widgets/edit_profile_screen.dart';
import '../../core/widgets/profile_widgets/metric_card.dart';
import '../../core/widgets/profile_widgets/profile_header.dart';
import '../../core/widgets/profile_widgets/setting_row.dart';
import '../../../core/theme/theme_controller.dart';
import '../auth/login/login_screen.dart';
import '../../../core/utils/guest_checker.dart';
import '../../../core/widgets/guest/guest_widget.dart';

// 🔥 IMPORT YOUR NEW EDIT SCREEN

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
        FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots().listen((doc) {
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
                ListTile(
                  title: Text('English (UK)', style: Theme.of(context).textTheme.titleMedium),
                  trailing: selectedLanguage == 'English (UK)' ? const Icon(Icons.check_circle, color: AppColors.primary) : null,
                  onTap: () {
                    setState(() => selectedLanguage = 'English (UK)');
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('العربية (Arabic)', style: Theme.of(context).textTheme.titleMedium),
                  trailing: selectedLanguage == 'العربية' ? const Icon(Icons.check_circle, color: AppColors.primary) : null,
                  onTap: () {
                    setState(() => selectedLanguage = 'العربية');
                    Navigator.pop(context);
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
            backgroundColor: Colors.transparent,
            title: const Text('INSIGHTLY')
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
        backgroundColor: Colors.transparent,
        title: const Text('INSIGHTLY'),
        // 🔥 ADDED THE EDIT PENCIL ICON
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
                ProfileHeader(userName: _userName, avatarPath: _avatarUrl),
                const SizedBox(height: 40),
                Row(
                  children: [
                    MetricCard(title: 'Articles Read', value: _articlesRead),
                    const SizedBox(width: 16),
                    MetricCard(title: 'Minutes Saved', value: _minutesSaved, unit: 'm'),
                  ],
                ),
                const SizedBox(height: 40),
                Text('APPEARANCE', style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(height: 12),
                SettingsRow(
                  leadingIcon: isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                  title: isDarkMode ? 'Dark Mode' : 'Light Mode',
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
                Text('LANGUAGE', style: Theme.of(context).textTheme.labelMedium),
                const SizedBox(height: 12),
                SettingsRow(
                  leadingIcon: Icons.language,
                  title: 'Language',
                  trailing: TextButton(
                    onPressed: () {
                      _showLanguagePicker(context);
                    },
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    child: Text(
                      selectedLanguage,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 48),
                OutlinedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    if (context.mounted) {
                      Navigator.pushNamedAndRemoveUntil(context, LoginScreen.routeName, (route) => false);
                    }
                  },
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 56),
                    side: const BorderSide(color: AppColors.error, width: 1.5),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(
                    'LOGOUT SESSION',
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
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