import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/background_color/app_background.dart';
import '../../core/widgets/profile_widgets/metric_card.dart';
import '../../core/widgets/profile_widgets/profile_header.dart';
import '../../core/widgets/profile_widgets/setting_row.dart';


class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDarkMode = true; // State for Dark mode switch widget
  String selectedLanguage = 'English (UK)';

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
                // Title Header
                Text(
                  'CHOOSE LANGUAGE',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.mutedText,
                  ),
                ),
                const SizedBox(height: 16),

                // English Option Row
                ListTile(
                  title: Text(
                    'English (UK)',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing: selectedLanguage == 'English (UK)'
                      ? const Icon(Icons.check_circle, color: AppColors.primary)
                      : null,
                  onTap: () {
                    setState(() {
                      selectedLanguage = 'English (UK)';
                    });
                    Navigator.pop(context); // Close bottom sheet
                  },
                ),

                // Arabic Option Row
                ListTile(
                  title: Text(
                    'العربية (Arabic)',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  trailing: selectedLanguage == 'العربية'
                      ? const Icon(Icons.check_circle, color: AppColors.primary)
                      : null,
                  onTap: () {
                    setState(() {
                      selectedLanguage = 'العربية';
                    });
                    Navigator.pop(context); // Close bottom sheet
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('INSIGHTLY'),
      ),
      body: AppBackground(
        child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // 1. Profile Header Widget
                  const ProfileHeader(
                    userName: 'Farida Ahmed',
                    avatarPath: 'assets/images/avatar.png',
                  ),
                  const SizedBox(height: 40),

                  // 2. Metrics Block Rows
                  Row(
                    children: const [
                      MetricCard(
                        title: 'Articles Read',
                        value: '1,248',
                      ),
                      SizedBox(width: 16),
                      MetricCard(
                        title: 'Minutes Saved',
                        value: '452',
                        unit: 'm',
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // 3. APPEARANCE Category Label (labelMedium)
                  Text(
                    'APPEARANCE',
                    style: Theme.of(context).textTheme.labelMedium
                  ),
                  const SizedBox(height: 12),

                  // Dark Mode row item
                  SettingsRow(
                    leadingIcon: isDarkMode ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                    title: isDarkMode ? 'Dark Mode' : 'Light Mode',
                    trailing: Switch(
                      value: isDarkMode,
                      activeColor: AppColors.primary,
                      activeTrackColor: AppColors.inputFill,
                      inactiveThumbColor: AppColors.mutedText,
                      onChanged: (value) {
                        setState(() {
                          isDarkMode = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 32),

                  // 4. LANGUAGE Category Label (labelMedium)
                  Text(
                    'LANGUAGE',
                    style: Theme.of(context).textTheme.labelMedium
                  ),
                  const SizedBox(height: 12),

                  // Language selection item row updated
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

                  // 5. LOGOUT SESSION Button Element
                  OutlinedButton(
                    onPressed: () {
                      // Action handler for sessions exit
                    },
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 56),
                      side: const BorderSide(color: AppColors.error, width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
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