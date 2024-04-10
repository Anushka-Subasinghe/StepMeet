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

class ProfileScreen extends StatefulWidget {
  final Uint8List? imageData;
  const ProfileScreen({Key? key,this.imageData}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}
class _ProfileScreenState extends State<ProfileScreen> {
  Uint8List? _image;
  late Map<String, dynamic> user = {};

  @override
  void initState() {
    super.initState();
    _image = widget.imageData;
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
                                    onDelete: () {
                                      setState(() {
                                        completedTrailComments.removeAt(index);
                                      });
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
                _image != null ?
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
                        image: MemoryImage(_image!),
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
