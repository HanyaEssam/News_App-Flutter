import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news/l10n/app_localizations.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/responsive.dart';
import '../../../core/widgets/background_color/app_background.dart';
import '../../../core/widgets/language_picker.dart';
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
  StreamSubscription<DocumentSnapshot>? _userDataSubscription;
  bool _isUpdatingName = false;
  bool _isLoading = true;
  bool _isFirstLoad = true;
  String _avatarUrl = '';
  List<String> _selectedTopics = [];

  static const List<String> _allTopics = [
    'Technology',
    'Sports',
    'Politics',
    'Business',
    'Health',
    'Science',
    'General',
    'Entertainment',
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
    _listenToUserData();
  }

  @override
  void dispose() {
    _userDataSubscription?.cancel();
    _nameController.dispose();
    super.dispose();
  }

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
              _selectedTopics = List<String>.from(
                doc.data()!['selectedTopics'] ?? [],
              );
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
      if (mounted)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Name updated!')));
    } catch (e) {
      if (mounted)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _isUpdatingName = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(loc.editProfile.toUpperCase()),
        backgroundColor: Colors.transparent,
        actions: const [LanguagePicker()],
      ),
      body: AppBackground(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: EdgeInsets.all(Responsive.scale(context, 24)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileAvatarPicker(
                      avatarUrl: _avatarUrl,
                      onTap: () => AvatarPickerSheet.show(
                        context,
                        avatars: _availableAvatars,
                        onAvatarSelected: (p) => FirebaseFirestore.instance
                            .collection('users')
                            .doc(currentUser!.uid)
                            .update({'avatarUrl': p}),
                      ),
                    ),
                    SizedBox(height: 40),
                    Text(
                      loc.personalInfo.toUpperCase(),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    NameEditorSection(
                      controller: _nameController,
                      isLoading: _isUpdatingName,
                      onUpdate: _updateName,
                      label: loc.fullNameLabel,
                      btnText: loc.updateName,
                    ),
                    SizedBox(height: 40),
                    Text(
                      loc.security.toUpperCase(),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    GestureDetector(
                      onTap: () => ChangePasswordSheet.show(context),
                      child: SettingsRow(
                        leadingIcon: Icons.lock_outline,
                        title: loc.changePassword,
                        trailing: Icon(Icons.arrow_forward_ios, size: 16),
                      ),
                    ),
                    SizedBox(height: 32),
                    Text(
                      loc.preferences.toUpperCase(),
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    GestureDetector(
                      onTap: () => TopicsPickerSheet.show(
                        context,
                        allTopics: _allTopics,
                        selectedTopics: _selectedTopics,
                        onTopicsChanged: (_) {},
                      ),
                      child: SettingsRow(
                        leadingIcon: Icons.interests_outlined,
                        title: loc.yourTopics,
                        trailing: Text(
                          _selectedTopics.isEmpty
                              ? loc.none
                              : '${_selectedTopics.length} ${loc.selected}',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
