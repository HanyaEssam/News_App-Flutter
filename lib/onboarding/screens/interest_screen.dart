import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/background_color/app_background.dart';
import '../../../core/models/category_model.dart';
import '../../../core/utils/responsive.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news/l10n/app_localizations.dart';
import '../../ui/home/screens/home_screen.dart';

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
    CategoryModel(title: 'Technology', imagePath: 'assets/images/TECH.jpeg', accentColor: AppColors.primary),
    CategoryModel(title: 'Sports', imagePath: 'assets/images/SPORTS.jpeg', accentColor: AppColors.green),
    CategoryModel(title: 'Politics', imagePath: 'assets/images/POLITICS.jpeg', accentColor: AppColors.orange),
    CategoryModel(title: 'Business', imagePath: 'assets/images/BUSINESS.jpeg', accentColor: AppColors.blue),
    CategoryModel(title: 'Health', imagePath: 'assets/images/HEALTH.jpeg', accentColor: AppColors.error),
    CategoryModel(title: 'Science', imagePath: 'assets/images/SCIENCE.jpeg', accentColor: AppColors.purple),
    CategoryModel(title: 'Travel', imagePath: 'assets/images/TRAVEL.jpeg', accentColor: AppColors.yellow),
    CategoryModel(title: 'General', imagePath: 'assets/images/GENERAL.jpeg', accentColor: AppColors.grey),
    CategoryModel(title: 'Entertainment', imagePath: 'assets/images/ENTERTAINMENT.jpeg', accentColor: AppColors.pink),
  ];

  String _getTranslatedCategory(BuildContext context, String title) {
    final loc = AppLocalizations.of(context);
    if (loc == null) return title;
    switch (title.toLowerCase()) {
      case 'technology': return loc.tech;
      case 'sports': return loc.sports;
      case 'politics': return loc.politics;
      case 'business': return loc.business;
      case 'health': return loc.health;
      case 'science': return loc.science;
      case 'travel': return loc.travel;
      case 'entertainment': return loc.entertainment;
      case 'general': return loc.general;
      default: return title;
    }
  }

  void _toggleCategory(String title) {
    setState(() {
      if (_selectedCategories.contains(title)) {
        _selectedCategories.remove(title);
      } else if (_selectedCategories.length < 5) {
        _selectedCategories.add(title);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Max 5 topics allowed')),
        );
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
      if (mounted) {
        Navigator.pushReplacementNamed(context, HomeLayout.routeName);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to save: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final loc = AppLocalizations.of(context);

    if (loc == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: Responsive.maxWidth(context)),
              child: SingleChildScrollView(
                padding: EdgeInsets.only(
                  left: Responsive.scale(context, 20),
                  right: Responsive.scale(context, 20),
                  bottom: Responsive.scale(context, 20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: Responsive.scale(context, 20)),
                    Center(
                      child: Text(
                        loc.appTitle.toUpperCase(),
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontSize: Responsive.scaleText(context, 32),
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.scale(context, 24)),
                    Text(
                      loc.designYourDaily.toUpperCase(),
                      style: theme.textTheme.displayLarge?.copyWith(
                        fontSize: Responsive.scaleText(context, 40),
                      ),
                    ),
                    SizedBox(height: Responsive.scale(context, 10)),
                    Text(
                      loc.pickTopicsSubtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: Responsive.scaleText(context, 14),
                      ),
                    ),
                    SizedBox(height: Responsive.scale(context, 20)),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _categories.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: Responsive.isDesktop(context)
                            ? 4
                            : Responsive.isTablet(context)
                            ? 3
                            : 2,
                        crossAxisSpacing: Responsive.scale(context, 14),
                        mainAxisSpacing: Responsive.scale(context, 14),
                        childAspectRatio: 0.85,
                      ),
                      itemBuilder: (context, index) {
                        final category = _categories[index];
                        final isSelected =
                        _selectedCategories.contains(category.title);

                        return GestureDetector(
                          onTap: () => _toggleCategory(category.title),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                Responsive.scale(context, 18),
                              ),
                              border: Border.all(
                                color: isSelected
                                    ? category.accentColor
                                    : Colors.transparent,
                                width: 2.5,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                Responsive.scale(context, 16),
                              ),
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
                                  if (isSelected)
                                    Positioned(
                                      top: Responsive.scale(context, 10),
                                      right: Responsive.scale(context, 10),
                                      child: Container(
                                        padding: EdgeInsets.all(
                                          Responsive.scale(context, 4),
                                        ),
                                        decoration: BoxDecoration(
                                          color: category.accentColor,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.check,
                                          size: Responsive.scale(context, 14),
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  Positioned(
                                    bottom: Responsive.scale(context, 12),
                                    left: Responsive.scale(context, 12),
                                    child: Text(
                                      _getTranslatedCategory(
                                          context, category.title),
                                      style: theme.textTheme.headlineSmall
                                          ?.copyWith(
                                        color: Colors.white,
                                        fontSize:
                                        Responsive.scaleText(context, 18),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: Responsive.scale(context, 12)),
                    Center(
                      child: Text(
                        loc.calibrated(
                            _selectedCategories.length.toString()),
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontSize: Responsive.scaleText(context, 12),
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.scale(context, 12)),
                    SizedBox(
                      width: double.infinity,
                      height: Responsive.scale(context, 56),
                      child: FilledButton(
                        onPressed:
                        _selectedCategories.isNotEmpty && !_isLoading
                            ? _saveInterestsAndContinue
                            : null,
                        child: _isLoading
                            ? SizedBox(
                          height: Responsive.scale(context, 20),
                          width: Responsive.scale(context, 20),
                          child: const CircularProgressIndicator(
                            color: Colors.black,
                            strokeWidth: 2,
                          ),
                        )
                            : Text(
                          loc.continueBriefing,
                          style: TextStyle(
                            fontSize: Responsive.scaleText(context, 16),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.scale(context, 20)),
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