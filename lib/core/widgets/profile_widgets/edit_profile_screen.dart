import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news/core/widgets/profile_widgets/setting_row.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/background_color/app_background.dart';
import '../../../core/widgets/auth_widgets.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final User? currentUser = FirebaseAuth.instance.currentUser;

  // 🔥 NEW: Controller and loading state for the Name update
  final _nameController = TextEditingController();
  bool _isUpdatingName = false;

  String _avatarUrl = '';
  List<String> _selectedTopics = [];
  bool _isLoading = true;

  final List<String> _allTopics = [
    'Technology', 'Sports', 'Politics', 'Business', 'Health',
    'Science', 'General', 'Entertainment'
  ];

  final List<String> _availableAvatars = [
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
    _fetchUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _fetchUserData() async {
    if (currentUser != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).get();
      if (doc.exists && mounted) {
        setState(() {
          _avatarUrl = doc.data()!['avatarUrl'] ?? '';
          // 🔥 NEW: Pre-fill the text field with their current name!
          _nameController.text = doc.data()!['fullName'] ?? '';
          _selectedTopics = List<String>.from(doc.data()!['selectedTopics'] ?? []);
          _isLoading = false;
        });
      }
    }
  }

  // --- 🔥 NEW: UPDATE NAME LOGIC ---
  Future<void> _updateName() async {
    final newName = _nameController.text.trim();
    if (newName.isEmpty) return;

    setState(() => _isUpdatingName = true);

    try {
      // 1. Update Firestore Database
      await FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).update({
        'fullName': newName,
      });
      // 2. Update Firebase Auth Profile
      await currentUser!.updateDisplayName(newName);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Name updated successfully!'))
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isUpdatingName = false);
    }
  }

  void _showAvatarPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.cardDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'CHOOSE AVATAR',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: AppColors.mutedText,
                  ),
                ),
                const SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: _availableAvatars.length,
                  itemBuilder: (context, index) {
                    final avatarPath = _availableAvatars[index];
                    return GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                        setState(() => _avatarUrl = avatarPath);
                        await FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).update({
                          'avatarUrl': avatarPath,
                        });
                      },
                      child: CircleAvatar(
                        backgroundImage: AssetImage(avatarPath),
                        backgroundColor: Colors.transparent,
                        radius: 40,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showTopicsPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'YOUR TOPICS',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.mutedText,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.5,
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _allTopics.length,
                        itemBuilder: (context, index) {
                          final topic = _allTopics[index];
                          final isSelected = _selectedTopics.contains(topic);

                          return ListTile(
                            title: Text(topic, style: Theme.of(context).textTheme.titleMedium),
                            trailing: isSelected ? const Icon(Icons.check_circle, color: AppColors.primary) : null,
                            onTap: () async {
                              if (isSelected) {
                                _selectedTopics.remove(topic);
                              } else {
                                if (_selectedTopics.length < 5) {
                                  _selectedTopics.add(topic);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Max 5 topics allowed')));
                                  return;
                                }
                              }
                              setModalState(() {});
                              setState(() {});
                              await FirebaseFirestore.instance.collection('users').doc(currentUser!.uid).update({
                                'selectedTopics': _selectedTopics,
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showPasswordBottomSheet() {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    bool obscureOld = true;
    bool obscureNew = true;
    bool obscureConfirm = true;
    bool isSaving = false;
    String? errorMsg;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.cardDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 24, right: 24, top: 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'CHANGE PASSWORD',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.mutedText,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  AuthTextField(
                    label: 'CURRENT PASSWORD',
                    hintText: '• • • • • • • •',
                    isPassword: true,
                    obscureText: obscureOld,
                    controller: oldPasswordController,
                    onToggleVisibility: () {
                      setModalState(() => obscureOld = !obscureOld);
                    },
                  ),
                  const SizedBox(height: 20),

                  AuthTextField(
                    label: 'NEW PASSWORD',
                    hintText: '• • • • • • • •',
                    isPassword: true,
                    obscureText: obscureNew,
                    controller: newPasswordController,
                    onToggleVisibility: () {
                      setModalState(() => obscureNew = !obscureNew);
                    },
                  ),
                  const SizedBox(height: 20),

                  AuthTextField(
                    label: 'CONFIRM PASSWORD',
                    hintText: '• • • • • • • •',
                    isPassword: true,
                    obscureText: obscureConfirm,
                    controller: confirmPasswordController,
                    onToggleVisibility: () {
                      setModalState(() => obscureConfirm = !obscureConfirm);
                    },
                  ),

                  if (errorMsg != null) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red.withOpacity(0.5)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline, color: Colors.redAccent, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              errorMsg!,
                              style: const TextStyle(color: Colors.redAccent, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: isSaving ? null : () async {
                        if (newPasswordController.text != confirmPasswordController.text) {
                          setModalState(() => errorMsg = "New passwords do not match.");
                          return;
                        }
                        if (newPasswordController.text.length < 8) {
                          setModalState(() => errorMsg = "Password must be at least 8 characters.");
                          return;
                        }

                        setModalState(() {
                          isSaving = true;
                          errorMsg = null;
                        });

                        try {
                          AuthCredential credential = EmailAuthProvider.credential(
                            email: currentUser!.email!,
                            password: oldPasswordController.text,
                          );
                          await currentUser!.reauthenticateWithCredential(credential);

                          await currentUser!.updatePassword(newPasswordController.text);

                          if (context.mounted) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Password updated successfully!'))
                            );
                          }
                        } on FirebaseAuthException catch (e) {
                          setModalState(() {
                            errorMsg = e.message ?? "Authentication failed. Check your current password.";
                          });
                        } finally {
                          setModalState(() => isSaving = false);
                        }
                      },
                      child: isSaving
                          ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2))
                          : const Text('UPDATE PASSWORD'),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    ImageProvider imageProvider;
    if (_avatarUrl.startsWith('http')) {
      imageProvider = NetworkImage(_avatarUrl);
    } else {
      imageProvider = AssetImage(_avatarUrl.isEmpty ? 'assets/images/avatar.png' : _avatarUrl);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('EDIT PROFILE'),
        backgroundColor: Colors.transparent,
      ),
      body: AppBackground(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),

              // 1. AVATAR SECTION
              Center(
                child: GestureDetector(
                  onTap: _showAvatarPicker,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        height: 100, width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Theme.of(context).colorScheme.primary, width: 2),
                          image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(Icons.camera_alt, size: 16, color: Theme.of(context).colorScheme.onPrimary),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 48),

              // 🔥 2. NEW PERSONAL INFO SECTION
              Text('PERSONAL INFO', style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 12),
              AuthTextField(
                label: 'FULL NAME',
                hintText: 'Your name',
                controller: _nameController,
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerRight,
                child: FilledButton(
                  onPressed: _isUpdatingName ? null : _updateName,
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  child: _isUpdatingName
                      ? const SizedBox(height: 16, width: 16, child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2))
                      : const Text('UPDATE NAME'),
                ),
              ),
              const SizedBox(height: 40),

              // 3. SECURITY SECTION
              Text('SECURITY', style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _showPasswordBottomSheet,
                child: const SettingsRow(
                  leadingIcon: Icons.lock_outline,
                  title: 'Change Password',
                  trailing: Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.mutedText),
                ),
              ),
              const SizedBox(height: 32),

              // 4. INTERESTS SECTION
              Text('PREFERENCES', style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: _showTopicsPicker,
                child: SettingsRow(
                  leadingIcon: Icons.interests_outlined,
                  title: 'Your Topics',
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _selectedTopics.isEmpty ? 'None' : '${_selectedTopics.length} Selected',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.mutedText),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}