import 'dart:async'; // 🔥 Required for StreamSubscription
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/background_color/app_background.dart';
import '../../../core/widgets/profile_widgets/setting_row.dart';
import '../../core/widgets/edit_profile/avatar_picker_sheet.dart';
import '../../core/widgets/edit_profile/change_password_sheet.dart';
import '../../core/widgets/edit_profile/name_editor_section.dart';
import '../../core/widgets/edit_profile/profile_avatar_picker.dart';
import '../../core/widgets/edit_profile/topics_picker_sheet.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  final _nameController = TextEditingController();

  // 🔥 NEW: We keep track of the live database connection so we can close it later
  StreamSubscription<DocumentSnapshot>? _userDataSubscription;

  bool _isUpdatingName = false;
  bool _isLoading = true;
  bool _isFirstLoad = true; // 🔥 NEW: Prevents overwriting the text box while typing

  String _avatarUrl = '';
  List<String> _selectedTopics = [];

  static const List<String> _allTopics = [
    'Technology', 'Sports', 'Politics', 'Business',
    'Health', 'Science', 'General', 'Entertainment',
  ];

  static const List<String> _availableAvatars = [
    'assets/images/avatars/avatar_1.png',
    'assets/images/avatars/avatar_2.png',
    'assets/images/avatars/avatar_3.png',
    'assets/images/avatars/avatar_4.png',
    'assets/images/avatars/avatar_5.png',
    'assets/images/avatars/avatar_6.png',
    'assets/images/avatars/avatar.png',
  ];

  @override
  void initState() {
    super.initState();
    _listenToUserData(); // 🔥 Changed to our new live-listening function
  }

  @override
  void dispose() {
    // 🔥 ALWAYS cancel the database subscription when leaving the screen to save memory!
    _userDataSubscription?.cancel();
    _nameController.dispose();
    super.dispose();
  }

  // 🔥 UPGRADED: Now listens to the database in real-time instead of fetching once
  void _listenToUserData() {
    if (currentUser == null) return;

    _userDataSubscription = FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .snapshots()
        .listen((doc) {
      if (doc.exists && mounted) {
        setState(() {
          _avatarUrl = doc.data()!['avatarUrl'] ?? '';
          _selectedTopics = List<String>.from(doc.data()!['selectedTopics'] ?? []);

          // 🔥 Only set the text controller the VERY FIRST time the screen loads.
          // This stops the database from erasing your text while you are typing!
          if (_isFirstLoad) {
            _nameController.text = doc.data()!['fullName'] ?? '';
            _isFirstLoad = false;
          }

          _isLoading = false;
        });
      }
    });
  }

  Future<void> _updateName() async {
    final newName = _nameController.text.trim();
    if (newName.isEmpty) return;

    setState(() => _isUpdatingName = true);

    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUser!.uid)
          .update({'fullName': newName});
      await currentUser!.updateDisplayName(newName);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Name updated successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isUpdatingName = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final maxContentWidth =
    Responsive.isMobile(context) ? double.infinity : 600.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('EDIT PROFILE'),
        backgroundColor: Colors.transparent,
      ),
      body: AppBackground(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxContentWidth),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.scale(context, 24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Responsive.scale(context, 32)),

                  // 1. AVATAR
                  ProfileAvatarPicker(
                    avatarUrl: _avatarUrl,
                    onTap: () => AvatarPickerSheet.show(
                      context,
                      avatars: _availableAvatars,
                      onAvatarSelected: (path) {
                        // The database listener will update the screen, but we can
                        // also manually update the database here if needed.
                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(currentUser!.uid)
                            .update({'avatarUrl': path});
                      },
                    ),
                  ),
                  SizedBox(height: Responsive.scale(context, 48)),

                  // 2. PERSONAL INFO
                  Text(
                    'PERSONAL INFO',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  SizedBox(height: Responsive.scale(context, 12)),
                  NameEditorSection(
                    controller: _nameController,
                    isLoading: _isUpdatingName,
                    onUpdate: _updateName,
                  ),
                  SizedBox(height: Responsive.scale(context, 40)),

                  // 3. SECURITY
                  Text(
                    'SECURITY',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  SizedBox(height: Responsive.scale(context, 12)),
                  GestureDetector(
                    onTap: () => ChangePasswordSheet.show(context),
                    child: SettingsRow(
                      leadingIcon: Icons.lock_outline,
                      title: 'Change Password',
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: Responsive.scale(context, 16),
                        color: AppColors.mutedText,
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.scale(context, 32)),

                  // 4. PREFERENCES
                  Text(
                    'PREFERENCES',
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  SizedBox(height: Responsive.scale(context, 12)),
                  GestureDetector(
                    onTap: () => TopicsPickerSheet.show(
                      context,
                      allTopics: _allTopics,
                      selectedTopics: _selectedTopics,
                      onTopicsChanged: (newTopics) {
                        // We don't need setState here anymore because the live database
                        // listener will handle updating the UI for us automatically!
                      },
                    ),
                    child: SettingsRow(
                      leadingIcon: Icons.interests_outlined,
                      title: 'Your Topics',
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _selectedTopics.isEmpty
                                ? 'None'
                                : '${_selectedTopics.length} Selected',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(color: Theme.of(context).colorScheme.primary),
                          ),
                          SizedBox(width: Responsive.scale(context, 8)),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: Responsive.scale(context, 16),
                            color: AppColors.mutedText,
                          ),
                        ],
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
    );
  }
}