import 'package:flutter/material.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: const Color(0xFF00141A),
      selectedItemColor: const Color(0xFF8DEDEC), // Color when selected
      unselectedItemColor: Colors.white54,        // Color when unselected
      showUnselectedLabels: true,
      type: BottomNavigationBarType.fixed,
      elevation: 10,
      currentIndex: currentIndex,
      onTap: onTap,
      items: const [
        BottomNavigationBarItem(
          // Just provide the icon once. Flutter will automatically
          // color it white54 when unselected and #8DEDEC when selected!
          icon: ImageIcon(AssetImage('assets/images/home.png')),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/images/search.png')),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/images/save.png')),
          label: 'Save',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/images/profile.png')),
          label: 'Profile',
        ),
      ],
    );
  }
}