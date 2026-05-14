import 'package:flutter/material.dart';
import '../widgets/bottomnav.dart';
import '../../search/search_screen.dart';
import '../../profile/profile_screen.dart';
import '../../save/save_screen.dart';
import 'package:news/core/widgets/background_color/app_background.dart';

class HomeLayout extends StatefulWidget {
  static const String routeName = '/home';

  const HomeLayout({super.key});

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int _currentIndex = 0;


  final List<Widget> _pages = const [
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
      body: AppBackground(
        child: const Center(
          child: Text(
            'Home / Dashboard',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}