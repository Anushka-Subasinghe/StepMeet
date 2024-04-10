import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:final_project1/Models/Map_list.dart';
import 'package:final_project1/Screens/share_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class MapScreen extends StatefulWidget {
  final int trailID;
  final Function(String) onTrailCompleted;

  const MapScreen({Key? key, required this.trailID, required this.onTrailCompleted}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int selectedIndex = 0;
  List<trail> _trailList = trail.trailList;
  List<String> completedTrailNames = [];
  late String lat;
  late String long;
  String locationMessage = 'Location';
  late Map<String, dynamic> user = {};

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
      setState(() {
        user = jsonDecode(userJson);
      });
      // Now you can use the 'user' map as needed
      print('User: $user');
    } else {
      print('User data not found in shared preferences');
    }
  }

  Future<void> _getCurrentLocationAndOpenMap() async {
    if (await Permission.location.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        lat = '${position.latitude}';
        long = '${position.longitude}';
        setState(() {
          locationMessage = 'Latitude: $lat, Longitude: $long';
        });
        _openMap(lat, long);
      } catch (e) {
        print('Error: $e');
        setState(() {
          locationMessage = 'Error getting location';
        });
      }
    } else {
      // If permissions are not granted, request them
      await Permission.location.request();
    }
  }

  Future<void> _openMap(String lat, String long) async {
    final String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';

    // Check if the url_launcher plugin is available and if we can launch the URL.
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      // Handles the case where the URL can't be launched.
      throw 'Could not launch $googleUrl';
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
              color: Color(0xff131515),
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).pop(),
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
                  _trailList[widget.trailID].mapURL,
                  height: 650.0,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            Container(
              color: Colors.black,
              height: 196,
              width: 420,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 20, right: 50, left: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Positioned(
                          right: 5,
                          bottom: 50,
                          child: IconButton(
                            iconSize: 50,
                            color: Color(0xff750e0e),
                            icon: const Icon(Icons.location_on),
                            onPressed: _getCurrentLocationAndOpenMap,
                          ),
                        ),
                        Column(
                          children: [
                            Text(
                              "Distance",
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _trailList[widget.trailID].Distance,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Duration",
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _trailList[widget.trailID].Duration,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  EndJourneyButton(context),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget EndJourneyButton(BuildContext context) {
    return Container(
      width: MediaQuery
          .of(context)
          .size
          .width,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child: ElevatedButton(
        onPressed: () => _showConfirmationDialog(context),
        // Call confirmation dialog
        child: Text(
          "End Journey",
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

  Future<void> _showConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('End Journey'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure you want to end this journey?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                endJourney(context); // Proceed with endJourney
                setState(() {
                  completedTrailNames.add(_trailList[widget.trailID].name);
                  trail.addCompletedTrail(_trailList[widget.trailID]);

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ShareScreen(),
                    ),
                  );

                });
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

  Future<void> endJourney(BuildContext context) async {
     // Callback function

    // Navigate to the ShareScreen
    try {
      // Add the completed trail to the backend

      String encodedEmail = Uri.encodeComponent(user['email']);

      final response = await http.post(
        Uri.parse('http://10.0.2.2:5151/api/users/$encodedEmail/completed/${widget.trailID}'),
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response,
        // navigate to the ShareScreen
        print("Recent activity added successfully");
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to mark trail as completed');
      }
    } catch (e) {
      // Handle any errors that occurred during the HTTP request
      print('Error: $e');
      // Show an error dialog or toast to inform the user about the error
    }

  }
}

