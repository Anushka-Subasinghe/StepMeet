import 'dart:convert';

import 'package:final_project1/Models/Map_list.dart';
import 'package:flutter/material.dart';
import 'package:final_project1/Screens/explore_screen.dart';
import 'package:final_project1/Screens/navigation_bar.dart';
import 'package:final_project1/Screens/share_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<int> favoriteTrailIds;
  late Map<String, dynamic> user;

  @override
  void initState() {
    super.initState();
    getUserDetails().then((value) => fetchAndStoreFavoritesAndComments()); // Call getUserDetails function when the widget is initialized
  }

  Future<void> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      // Parse the user JSON string back to a map
      user = jsonDecode(userJson);

      // Now you can use the 'user' map as needed
      print('User: $user');
    } else {
      print('User data not found in shared preferences');
    }
  }

  Future<void> fetchAndStoreFavoritesAndComments() async {
    try {
      // Fetch favorites from API
      String encodedEmail = Uri.encodeComponent(user['email']);
      late List<int> favoriteTrailIds;
      final responseFavorites = await http.get(
        Uri.parse('http://10.0.2.2:5151/api/users/$encodedEmail/favorites'),
      );

      if (responseFavorites.statusCode == 200) {
        final List<dynamic> dataFavorites = jsonDecode(responseFavorites.body);
        favoriteTrailIds = List<int>.from(dataFavorites);

        // Update trailList with isfavorite property
        trail.trailList = trail.trailList.map((thisTrail) {
          final isFavorite = favoriteTrailIds.contains(thisTrail.trailID);
          thisTrail.isfavorite = isFavorite;
          return thisTrail;
        }).toList();
      } else {
        print('Error fetching favorites: ${responseFavorites.body}');
        throw Exception('Failed to fetch favorites');
      }
    } catch (e) {
      print('Error fetching favorites: $e');
    }

    try {
      // Fetch completed trails from API
      String encodedEmail = Uri.encodeComponent(user['email']);
      final responseCompleted = await http.get(
        Uri.parse('http://10.0.2.2:5151/api/users/$encodedEmail/completed'),
      );

      if (responseCompleted.statusCode == 200) {
        final List<dynamic> dataCompleted = jsonDecode(responseCompleted.body);
        final List<int> completedTrailIds = List<int>.from(dataCompleted);

        // Store favorites in SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setStringList('favoriteTrailIds',
            completedTrailIds.map((id) => id.toString()).toList());

        // Update trailList with completed property
        trail.trailList = trail.trailList.map((thisTrail) {
          final isCompleted = completedTrailIds.contains(thisTrail.trailID);

          if (isCompleted) {
            trail.addCompletedTrail(thisTrail); // Add the completed trail
          }

          return thisTrail;
        }).toList();
      } else {
        print('Error fetching completed trails: ${responseCompleted.body}');
        throw Exception('Failed to fetch completed trails');
      }
    } catch (e) {
      print('Error fetching completed trails: $e');
    }

    try {
      // Fetch comments for completed trails
      String encodedEmail = Uri.encodeComponent(user['email']);
      final responseComments = await http.get(
        Uri.parse('http://10.0.2.2:5151/api/users/$encodedEmail/comments'),
      );

      if (responseComments.statusCode == 200) {
        final List<dynamic> dataComments = jsonDecode(responseComments.body);
        List<Map<String, dynamic>> allComments = List<Map<String, dynamic>>.from(dataComments);
        print(allComments);

        // Map comments to the relevant completed trails
        for (var comment in allComments) {
          String commentText = comment['comment'];
          int commentTrailID = comment['trailID'];

          // Find the completed trail with the corresponding ID
          trail completedTrail = trail.trailList.firstWhere((trail) => trail.trailID == commentTrailID);

          // Add the comment to the completed trail
          trail.addCommentToCompletedTrail(commentText, completedTrail);
        }
      } else {
        print('Error fetching comments: ${responseComments.body}');
        throw Exception('Failed to fetch comments');
      }
    } catch (e) {
      print('Error fetching comments: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                'assets/images/get started.jpg',
                height: 536.0,
                width: size.width,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0.0,
                child: Container(
                  height: 36.0,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 36.0),
            child: Column(
              children: [
                Text(
                  "Choose your preferred walking trail.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 24.0),
                Text(
                  "Take a stroll through stunning country parks and open spaces or meander alongside lakes and rivers in Wales.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 24.0),
                getStartedButton(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container getStartedButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NavigationScreen()),
          );
        },
        child: Text(
          "Get Started",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black54,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return Color(0xffade0d2);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
      ),
    );
  }
}
