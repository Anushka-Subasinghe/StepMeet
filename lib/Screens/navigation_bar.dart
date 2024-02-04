import 'package:final_project1/Screens/explore_screen.dart';
import 'package:final_project1/Screens/favorites_screen.dart';
import 'package:final_project1/Screens/profile_screen.dart';
import 'package:final_project1/Screens/settings_screen.dart';
import 'package:flutter/material.dart';

import 'map_screen.dart';


class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key?key}):super(key:key);
  @override
  _NavigationScreenState createState()=>_NavigationScreenState();
}
class _NavigationScreenState extends State<NavigationScreen> {
  int myCurrentIndex=1;
  List pages=const[
    ExploreScreen(),
    FavoritesScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];
  @override
  Widget build(BuildContext) {
    return Scaffold(
    bottomNavigationBar: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.black45.withOpacity(0.9),
          blurRadius: 30,
          offset: const Offset(8, 20)
        )
      ]),
      child:  ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BottomNavigationBar(
          selectedItemColor: Color(0xff064430),
          unselectedItemColor: Color(0xff79c495),
          currentIndex: myCurrentIndex,
          backgroundColor: Color(0xff03211a),
          onTap: (index){
            setState(() {
              myCurrentIndex=index;
            });
          },
          items: const[
            BottomNavigationBarItem(icon: Icon(Icons.map_outlined),label:"Home"),
            BottomNavigationBarItem(icon: Icon(Icons.favorite),label:"My Maps"),
            BottomNavigationBarItem(icon: Icon(Icons.person),label:"Profile"),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label:"Settings"),
          ],
        ),
      ),
    ),
      body: pages[myCurrentIndex],
    );
  }
}