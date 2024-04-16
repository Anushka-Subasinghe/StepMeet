import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:final_project1/Models/Map_list.dart';
import 'package:final_project1/Screens/share_screen.dart';
import 'package:final_project1/Screens/profile_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ObservationScreen extends StatefulWidget {
  const ObservationScreen({Key? key}) : super(key: key);

  @override
  State<ObservationScreen> createState() => _ObservationScreenState();
}

class _ObservationScreenState extends State<ObservationScreen> {
  final TextEditingController _textController = TextEditingController();
  List<trail> completedTrails = trail.completedTrails;
  int selectedIndex = 0;
  late Map<String, dynamic> user;

  @override
  void initState() {
    super.initState();
    getUserDetails();
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: null,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              iconSize: 30,
              color: Color(0xffd6e1da),
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () =>
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ShareScreen(),
                    ),
                  ),
            ),
            ElevatedButton(
              onPressed: () =>
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ProfileScreen(),
                    ),
                  ),
              child: Text(
                "Skip",
                style: TextStyle(
                  color: Color(0xffd1e8d5),
                  fontSize: 20,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.transparent;
                  }
                  return Colors.transparent;
                }),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/get started.jpg',
                  height: 891.0,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 891.0,
                  width: size.width,
                  color: Colors.black.withOpacity(0.6),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 150.0, left: 80, right: 60),
                  child: Container(
                    child: Text(
                      "Share your experience \n with the StepMeet \nCommunity.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xffc5cec5),
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 270,
                  left: 50,
                  right: 30,
                  child: Container(
                    height: 350.0,
                    width: 250.0,
                    margin: EdgeInsets.only(right: 24.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.0),
                      color: Color(0xffede4f3).withOpacity(0.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextField(
                        controller: _textController,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white.withOpacity(0.9)),
                        decoration: InputDecoration(
                          hintText: "Add Your Comment ...",
                          hintStyle: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white.withOpacity(0.9),
                          ),
                          labelStyle: TextStyle(color: Colors.white.withOpacity(
                              0.9)),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 650,
                  right: 100,
                  left: 100,
                  child: CommentButton(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Container CommentButton(BuildContext context) {
    return Container(
      height: 40,
      width: 150,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child: ElevatedButton(
        onPressed: () => _showConfirmationDialog(context),
        child: Text(
          "Share Comment",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
            color: Color(0xff063d06),
            fontWeight: FontWeight.w600,
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

  Future<void> _showConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to share this comment?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                addCommentToCompletedTrail(
                    context); // Proceed with adding comment
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  void addCommentToCompletedTrail(BuildContext context) async {
    try {
      String observation = _textController.text.trim();
      // Check if the observation is not empty
      if (observation.isNotEmpty) {
        trail completedTrail = trail.completedTrails.last; // Get the last completed trail
        int trailID = completedTrail.trailID; // Get the trail ID
        _textController.clear();
        setState(() {});

        // Send HTTP POST request to add comment to completed trail
        final response = await http.post(
          Uri.parse('http://10.0.2.2:5151/api/users/${user['email']}/completed/$trailID/comments'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(observation), // Send observation directly as a JSON string
        );

        if (response.statusCode == 200) {
          // Comment added successfully
          print('Comment added successfully to the backend.');
          trail.addCommentToCompletedTrail(observation, completedTrail);
          // Show dialog
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Comment Added"),
                actions: <Widget>[
                  TextButton(
                    child: Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                ],
              );
            },
          );
        } else {
          // Failed to add comment to backend, handle error
          print('Failed to add comment to backend: ${response.statusCode}');
          print(response.body);
        }
      } else {
        // Handle empty observation
        print('Observation is empty.');
      }
    } catch (e) {
      print('Error adding comment: $e');
      // Handle error
    }
  }



}
