import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/background_color/app_background.dart';
import '../../../core/widgets/language_picker.dart';
import '../../ui/home/screens/home_screen.dart';
import '../models/category_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news/l10n/app_localizations.dart';

class InterestScreen extends StatefulWidget {
  static const String routeName = 'interest';
  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  final Set<String> _selectedCategories = {};
  bool _isLoading = false;

  final List<CategoryModel> _categories = const [
    CategoryModel(
      title: 'Technology',
      imagePath: 'assets/images/TECH.jpeg',
      accentColor: AppColors.purple,
    ),
    CategoryModel(
      title: 'Sports',
      imagePath: 'assets/images/SPORTS.jpeg',
      accentColor: AppColors.green,
    ),
    CategoryModel(
      title: 'Politics',
      imagePath: 'assets/images/POLITICS.jpeg',
      accentColor: AppColors.orange,
    ),
    CategoryModel(
      title: 'Business',
      imagePath: 'assets/images/BUSINESS.jpeg',
      accentColor: AppColors.blue,
    ),
    CategoryModel(
      title: 'Health',
      imagePath: 'assets/images/HEALTH.jpeg',
      accentColor: AppColors.green,
    ),
    CategoryModel(
      title: 'Science',
      imagePath: 'assets/images/SCIENCE.jpeg',
      accentColor: AppColors.blue,
    ),
    CategoryModel(
      title: 'Travel',
      imagePath: 'assets/images/TRAVEL.jpeg',
      accentColor: AppColors.blue,
    ),
    CategoryModel(
      title: 'General',
      imagePath: 'assets/images/GENERAL.jpeg',
      accentColor: AppColors.grey,
    ),
    CategoryModel(
      title: 'Entertainment',
      imagePath: 'assets/images/ENTERTAINMENT.jpeg',
      accentColor: AppColors.grey,
    ),
  ];

  String _getTranslatedCategory(BuildContext context, String title) {
    final loc = AppLocalizations.of(context)!;
    switch (title.toLowerCase()) {
      case 'technology':
        return loc.tech;
      case 'sports':
        return loc.sports;
      case 'politics':
        return loc.politics;
      case 'business':
        return loc.business;
      case 'health':
        return loc.health;
      case 'science':
        return loc.science;
      case 'travel':
        return loc.travel;
      case 'entertainment':
        return loc.entertainment;
      case 'general':
        return loc.general;
      default:
        return title;
    }
  }

  void _toggleCategory(String title) {
    setState(() {
      if (_selectedCategories.contains(title)) {
        _selectedCategories.remove(title);
      } else if (_selectedCategories.length < 5) {
        _selectedCategories.add(title);
      }
    });
  }

  Future<void> _saveInterestsAndContinue() async {
    setState(() => _isLoading = true);
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({'selectedTopics': _selectedCategories.toList()});
      }
      if (mounted)
        Navigator.pushReplacementNamed(context, HomeLayout.routeName);
    } catch (e) {
      if (mounted)
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: const [LanguagePicker()],
      ),
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    loc.appTitle.toUpperCase(),
                    style: theme.textTheme.headlineLarge,
                  ),
                ),
                const SizedBox(height: 24),
                // 🔥 Updated with localized keys
                Text(
                  loc.designYourDaily.toUpperCase(),
                  style: theme.textTheme.displayLarge,
                ),
                const SizedBox(height: 10),
                Text(loc.pickTopicsSubtitle, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    itemCount: _categories.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 14,
                          mainAxisSpacing: 14,
                          childAspectRatio: 0.85,
                        ),
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      final isSelected = _selectedCategories.contains(
                        category.title,
                      );
                      return GestureDetector(
                        onTap: () => _toggleCategory(category.title),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(
                              color: isSelected
                                  ? category.accentColor
                                  : Colors.transparent,
                              width: 2.5,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: Image.asset(
                                    category.imagePath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Colors.black.withOpacity(0.2),
                                        Colors.black.withOpacity(0.85),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 12,
                                  left: 12,
                                  child: Text(
                                    _getTranslatedCategory(
                                      context,
                                      category.title,
                                    ),
                                    style: theme.textTheme.headlineSmall
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ),
                                if (isSelected)
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: Icon(
                                      Icons.check_circle,
                                      color: category.accentColor,
                                      size: 28,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // 🔥 Updated with localized key and placeholder for count
                Center(
                  child: Text(
                    loc.calibrated(_selectedCategories.length.toString()),
                    style: theme.textTheme.labelMedium,
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _selectedCategories.isNotEmpty && !_isLoading
                        ? _saveInterestsAndContinue
                        : null,
                    // 🔥 Updated with localized key
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(loc.continueBriefing),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
