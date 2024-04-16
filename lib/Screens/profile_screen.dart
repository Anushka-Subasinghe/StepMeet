import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:final_project1/Screens/navigation_bar.dart';
import 'package:final_project1/Models/Map_list.dart';
import 'package:final_project1/Screens/setting_screens/account_settings.dart';
import 'package:final_project1/Screens/settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../reusable_widgets/trail_widget.dart';
import '../reusable_widgets/comment_widget.dart';
import 'following_screen.dart';
import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {
  final Uint8List? imageData;
  const ProfileScreen({Key? key,this.imageData}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {
  Uint8List? profilePicture;
  late Map<String, dynamic> user = {};

  @override
  void initState() {
    super.initState();
    getUserDetails().then((value) => fetchProfilePicture(user['email']));
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

  Future<void> fetchProfilePicture(String email) async {
    try {
      final response = await http.get(
          Uri.parse('http://10.0.2.2:5151/api/users/$email/profile-picture'));

      if (response.statusCode == 200) {
        setState(() {
          profilePicture = response.bodyBytes;
        });
      } else {
        throw Exception('Failed to load profile picture');
      }
    } catch (e) {
      print('Error fetching profile picture: $e');
    }
  }

  Widget build(BuildContext context) {
    int selectedIndex = 0;
    Size size = MediaQuery.of(context).size;
    List<trail> _trailList = trail.trailList;
    List<trail> completedTrails = trail.completedTrails;
    List<String> completedTrailComments = trail.completedTrailComments;

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
              color: Color(0xffcae5e5),
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Text(
              "Your Profile",
              style: TextStyle(
                color: Color(0xffd6e1da),
                fontWeight: FontWeight.w500,
                fontSize: 26,
              ),
            ),
            IconButton(
              iconSize: 30,
              color: Color(0xffd6e1da),
              icon: const Icon(Icons.edit),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AccountScreen(),
                ),
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
                  height: 790.0,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 790.0,
                  width: size.width,
                  color: Colors.black.withOpacity(0.8),
                ),

                Container(
                  padding: EdgeInsets.only(
                    top: 170.0,
                    left: 120.0,
                    right: 120.0,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        user['firstName'] + ' ' + user['lastName'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xffd6e1da),
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        user['email'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xffbabdbd),
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  child: SingleChildScrollView(
                    child: Container(
                      height: 550.0,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40.0),
                          topLeft: Radius.circular(40.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 26,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 18),
                            child: const Text(
                              'Recently Shared...',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            height: size.height * 0.25,
                            child: ListView.builder(
                              itemCount: completedTrailComments.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                                  child: CommentWidget(
                                    comment: completedTrailComments[index],
                                    onDelete: () async {
                                      final String apiUrl = 'http://10.0.2.2:5151/api/users/${user['email']}/comments/$index';

                                      try {
                                        final response = await http.delete(Uri.parse(apiUrl));

                                        if (response.statusCode == 200) {
                                          print('Comment deleted successfully.');
                                          setState(() {
                                            completedTrailComments.removeAt(index);
                                          });
                                        } else if (response.statusCode == 404) {
                                          print('Comment index out of range or comments not found for this user.');
                                        } else if (response.statusCode == 500) {
                                          print('Error: ${response.body}');
                                        } else {
                                          print('Failed to delete comment: ${response.statusCode}');
                                        }
                                      } catch (e) {
                                        print('Error deleting comment: $e');
                                      }
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 18),
                            child: const Text(
                              'Recent Activity...',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            height: size.height * .25,
                            child: ListView.builder(
                              itemCount: completedTrails.length,
                              scrollDirection: Axis.vertical,
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                return TrailWidget(
                                  index: index,
                                  trailList: completedTrails,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                profilePicture != null ?
                Positioned(
                  top: 90,
                  left:155,
                  child: Container(
                    width: 90.0,
                    height: 90.0,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: MemoryImage(profilePicture!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
                    :
                Positioned(
                  top: 90,
                  left:155,
                  child: Container(
                    width: 90.0,
                    height: 90.0,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/icons/profile.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
