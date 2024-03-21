import 'package:final_project1/Models/user_list.dart';
import 'package:final_project1/Screens/explore_screen.dart';
import 'package:final_project1/Screens/favorites_screen.dart';
import 'package:final_project1/Screens/profile_screen.dart';
import 'package:final_project1/Screens/searchUsers.dart';
import 'package:final_project1/Screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:final_project1/Models/Map_list.dart';
import 'community_screen.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

class NavigationScreen extends StatefulWidget {
  NavigationScreen({Key? key}) : super(key: key);
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int bottomNavIndex = 0;
  List<trail> favorites = [];
  List<user> followed = [];

  List<Widget> _widgetOptions() {
    return [
      const ExploreScreen(),
      FavoritesScreen(favoriteTrails: favorites),
      ProfileScreen(),
      SearchUsersScreen(),
      SettingsScreen(),
    ];
  }

  //List of the pages icons
  List<IconData> iconList = [
    Icons.explore,
    Icons.favorite,
    Icons.person,
    Icons.people_rounded,
    Icons.settings,
  ];

  //List of the pages titles
  List<String> titleList = [
    'Home',
    'Favorites',
    'Profile',
    'Community',
    'Settings'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: bottomNavIndex,
        children: _widgetOptions(),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
          backgroundColor: Color(0xff519476),
          splashColor: Color(0xff93c9c8),
          activeColor: Color(0xff93c9c8),
          inactiveColor: Colors.black.withOpacity(.5),
          icons: iconList,
          activeIndex: bottomNavIndex,
          notchSmoothness: NotchSmoothness.softEdge,
          gapLocation: GapLocation.none,
          onTap: (index) {
            setState(() {
              bottomNavIndex = index;
              final List<trail> favoritedTrails = trail.getFavoriteTrails();
              favorites = favoritedTrails;
            });
          }),
    );
  }
}
