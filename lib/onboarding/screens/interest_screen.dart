
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/background_color/app_background.dart';
import '../../ui/home/screens/home_screen.dart';
import '../models/category_model.dart';

// 🔥 1. Add Firebase Imports
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class InterestScreen extends StatefulWidget {
  static const String routeName = 'interest';

  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {

  // 🧠 Store selected categories
  final Set<String> _selectedCategories = {};

  // 🔥 2. Add a loading state for the button
  bool _isLoading = false;

  // 🎨 Categories (NOW using AppColors only)
  final List<CategoryModel> _categories = const [
    CategoryModel(title: 'Technology', imagePath: 'assets/images/TECH.jpeg', accentColor: AppColors.purple),
    CategoryModel(title: 'Sports', imagePath: 'assets/images/SPORTS.jpeg', accentColor: AppColors.green),
    CategoryModel(title: 'Politics', imagePath: 'assets/images/POLITICS.jpeg', accentColor: AppColors.orange),
    CategoryModel(title: 'Business', imagePath: 'assets/images/BUSINESS.jpeg', accentColor: AppColors.blue),
    CategoryModel(title: 'Health', imagePath: 'assets/images/HEALTH.jpeg', accentColor: AppColors.green),
    CategoryModel(title: 'Science', imagePath: 'assets/images/SCIENCE.jpeg', accentColor: AppColors.blue),
    CategoryModel(title: 'Travel', imagePath: 'assets/images/TRAVEL.jpeg', accentColor: AppColors.blue),
    CategoryModel(title: 'General', imagePath: 'assets/images/GENERAL.jpeg', accentColor: AppColors.grey),
    CategoryModel(title: 'Entertainment', imagePath: 'assets/images/ENTERTAINMENT.jpeg', accentColor: AppColors.grey),
  ];

  // 🔁 Toggle logic
  void _toggleCategory(String title) {
    setState(() {
      if (_selectedCategories.contains(title)) {
        _selectedCategories.remove(title);
      } else {
        if (_selectedCategories.length < 5) {
          _selectedCategories.add(title);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Max 5 topics allowed')),
          );
        }
      }
    });
  }

  // 🔥 3. Create the Save Function
  Future<void> _saveInterestsAndContinue() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Get the currently logged-in user
      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        // Update their specific document in Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
          // Convert the Set to a List so Firebase can store it as an array
          'selectedTopics': _selectedCategories.toList(),
        });
      }

      // Navigate to Home upon success
      if (mounted) {
        Navigator.pushReplacementNamed(context, HomeLayout.routeName);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save interests: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final bool isSelectionValid = _selectedCategories.isNotEmpty;

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 20),

                // 🏷️ LOGO
                Center(
                  child: Text(
                    "INSIGHTLY",
                    style: theme.textTheme.headlineLarge,
                  ),
                ),

                const SizedBox(height: 24),

                // 🧾 TITLE
                Text(
                  "DESIGN YOUR DAILY",
                  style: theme.textTheme.displayLarge,
                ),

                const SizedBox(height: 10),

                // 📄 DESCRIPTION
                Text(
                  "Pick a few topics you love so we can tailor your feed just for you.",
                  style: theme.textTheme.bodyMedium,
                ),

                const SizedBox(height: 20),

                // 🧩 GRID
                Expanded(
                  child: GridView.builder(
                    itemCount: _categories.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: 0.85,
                    ),
                    itemBuilder: (context, index) {
                      final category = _categories[index];
                      final isSelected = _selectedCategories.contains(category.title);

                      return GestureDetector(
                        onTap: () => _toggleCategory(category.title),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            // ✅ BORDER (THEME-CONSISTENT)
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
                                // 🖼️ IMAGE
                                Positioned.fill(
                                  child: Image.asset(
                                    category.imagePath,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                // 🌑 DARK OVERLAY
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
                                // ✅ CHECK ICON
                                if (isSelected)
                                  Positioned(
                                    top: 10,
                                    right: 10,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: category.accentColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.check,
                                        size: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                // 🏷️ TITLE
                                Positioned(
                                  bottom: 12,
                                  left: 12,
                                  child: Text(
                                    category.title,
                                    style: theme.textTheme.headlineSmall?.copyWith(
                                      color: Colors.white,
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
                ),

                // 📊 COUNTER
                Center(
                  child: Text(
                    "${_selectedCategories.length} OF 5 TOPICS CALIBRATED",
                    style: theme.textTheme.labelMedium,
                  ),
                ),

                const SizedBox(height: 20),

                // 🔥 4. UPDATE BUTTON
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    // Disable button if no topics are selected OR if it's currently loading
                    onPressed: isSelectionValid && !_isLoading
                        ? _saveInterestsAndContinue
                        : null,
                    // Show a loading spinner if it is saving
                    child: _isLoading
                        ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.black, strokeWidth: 2)
                    )
                        : const Text("Continue Briefing"),
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