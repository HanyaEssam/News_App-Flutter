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


    // Wrap with Theme to override the splash and highlight colors locally
    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed, // Keeps items static and prevents shifting
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/home.png')),
            label: 'HOME',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/search.png')),
            label: 'SEARCH',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/save.png')),
            label: 'SAVED',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/images/profile.png')),
            label: 'PROFILE',
          ),
        ],
      ),


    );
  }
}