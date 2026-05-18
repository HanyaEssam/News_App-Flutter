import 'package:flutter/material.dart';
import '../../../core/widgets/bottomnav.dart';
import '../../search/search_screen.dart';
import '../../profile/profile_screen.dart';
import '../../save/save_screen.dart';
import 'package:news/core/widgets/background_color/app_background.dart';

import 'package:news/core/widgets/home_widgets/category_list.dart';
import 'package:news/core/widgets/home_widgets/trending_card.dart';
import 'package:news/core/widgets/home_widgets/for_you_card.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = '/home';

  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _currentIndex = 0;

  final List<Widget> _pages =  [
    HomeTabContent(),
    SearchScreen(),
    SaveScreen(),
    ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNav(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}

class HomeTabContent extends StatelessWidget {
  const HomeTabContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('INSIGHTLY',
        ),
      ),
      body: AppBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

              /*  // 1. App Logo Header (headlineLarge)
                Center(
                  child: Text(
                    'INSIGHTLY',
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                const SizedBox(height: 30),
                  */
                // 2. Daily Briefing Text (displaySmall)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Your daily briefing',
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                const SizedBox(height: 24),

                // 3. Horizontal Category List
                const CategoryList(),
                const SizedBox(height: 32),

                // 4. Trending Now Section (headlineMedium)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Trending Now',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: 16),

                // Horizontal scrollable list for Trending Cards
                SizedBox(
                  height: 360,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return const TrendingCard();
                    },
                  ),
                ),
                const SizedBox(height: 32),

                // 5. For You Section (headlineMedium)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'For You',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: 16),

                // Vertical list for 'For You' Cards
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    children: const [
                      ForYouCard(
                        label: 'Based on your interest in Technology',
                        title: "Silicon Valley's New obsession with Bio-Organic Chips",
                        description: 'Researchers are pioneering a new wave of computing that...',
                        time: '2h ago',
                        readTime: '12 min read',
                        source: 'Wired',
                        imageUrl: 'assets/images/business_img.png',
                      ),
                      ForYouCard(
                        label: 'Discovery of the week',
                        title: "The Arctic's Hidden Ocean: A Continent-Sized Reservoir",
                        description: 'Deep beneath the ice shelf, scientists have mapped a previously unknown freshwater body that could redefine our climate models...',
                        time: '6h ago',
                        readTime: '8 min read',
                        source: 'National Geographic',
                        imageUrl: 'assets/images/chip_img.png',
                      ),
                    ],
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