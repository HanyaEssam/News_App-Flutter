import 'package:flutter/material.dart';
import 'package:news/l10n/app_localizations.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNav({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final double shortestSide = MediaQuery.of(context).size.shortestSide;
    final double iconSize = (shortestSide * 0.06).clamp(20.0, 28.0);
    final double fontSize = (shortestSide * 0.025).clamp(9.0, 12.0);

    return Theme(
      data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(
              const AssetImage('assets/images/home.png'),
              size: iconSize,
            ),
            label: AppLocalizations.of(context)!.home.toUpperCase(),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              const AssetImage('assets/images/search.png'),
              size: iconSize,
            ),
            label: AppLocalizations.of(context)!.search.toUpperCase(),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              const AssetImage('assets/images/save.png'),
              size: iconSize,
            ),
            label: AppLocalizations.of(context)!.saved.toUpperCase(),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              const AssetImage('assets/images/profile.png'),
              size: iconSize,
            ),
            label: AppLocalizations.of(context)!.profile.toUpperCase(),
          ),
        ],
      ),
    );
  }
}