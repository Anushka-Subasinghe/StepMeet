import 'dart:convert';
import 'dart:typed_data';

import 'package:final_project1/Screens/following_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:final_project1/Models/user_list.dart';

import '../Models/Map_list.dart';
import '../reusable_widgets/Comment_widget.dart';
import '../reusable_widgets/trail_widget.dart';

class CommunityScreen extends StatefulWidget {
  final dynamic user;
  final Uint8List? imageData;
  const CommunityScreen ({Key? key,required this.user, this.imageData}) : super(key: key);

  @override
  State<CommunityScreen>  createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen > {
  late Map<String, dynamic> currentUser;
  List<user> followedUsers = [];
  List<dynamic> results = [];
  List<trail> localTrailList = List.from(trail.trailList);
  List<String> completedTrailComments = [];
  List<trail> completedTrails = [];

  bool toggleFollow(bool isFollowing) {
    return !isFollowing;
  }

  Future<void> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      // Parse the user JSON string back to a map
      setState(() {
        currentUser = jsonDecode(userJson);
      });

      // Now you can use the 'user' map as needed
      print('User: $user');
    } else {
      print('User data not found in shared preferences');
    }
  }

  Future<void> fetchFollowedUsers() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:5151/api/users/${currentUser['email']}/following'),
      );

      if (response.statusCode == 200) {
        setState(() {
          results = jsonDecode(response.body);
          print('results\n');
          print(results);
          setState(() {
            followedUsers = results.map((e) {
              int index = results.indexOf(e);
              return user(
                  userID: index,
                  userName: e['firstName'] + ' ' + e['lastName'],
                  email: e['email'],
                  isPrivate: e['isPrivate'],
                  dpURL: e['dpUrl']
              );
            }).toList();
          });
          print('followedUsers\n');
          print(followedUsers);
        });
      } else {
        print('Failed to fetch followed users: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching followed users: $e');
    }
  }

  Future<void> fetchAndStoreFavoritesAndComments() async {
    try {
      String encodedEmail = Uri.encodeComponent(widget.user.email);
      final responseCompleted = await http.get(
        Uri.parse('http://10.0.2.2:5151/api/users/$encodedEmail/completed'),
      );

      if (responseCompleted.statusCode == 200) {
        final List<dynamic> dataCompleted = jsonDecode(responseCompleted.body);
        final List<int> completedTrailIds = List<int>.from(dataCompleted);

        // Update trailList with completed property
        setState(() {
          localTrailList.map((thisTrail) {
            final isCompleted = completedTrailIds.contains(thisTrail.trailID);

            if (isCompleted) {
              print('completedTrails\n');
              print(completedTrailIds);
              addCompletedTrail(thisTrail); // Add the completed trail
            }

            return thisTrail;
          }).toList();
        });
      } else {
        print('Error fetching completed trails: ${responseCompleted.body}');
        throw Exception('Failed to fetch completed trails');
      }
    } catch (e) {
      print('Error fetching completed trails: $e');
    }

    try {
      // Fetch comments for completed trails
      String encodedEmail = Uri.encodeComponent(widget.user.email);
      final responseComments = await http.get(
        Uri.parse('http://10.0.2.2:5151/api/users/$encodedEmail/comments'),
      );

      if (responseComments.statusCode == 200) {
        final List<dynamic> dataComments = jsonDecode(responseComments.body);
        List<Map<String, dynamic>> allComments = List<Map<String, dynamic>>.from(dataComments);
        print(allComments);

        // Map comments to the relevant completed trails
        setState(() {
          for (var comment in allComments) {
            String commentText = comment['comment'];
            int commentTrailID = comment['trailID'];

            // Find the completed trail with the corresponding ID in the localTrailList
            trail completedTrail = localTrailList.firstWhere((trail) => trail.trailID == commentTrailID);

            // Add the comment to the completed trail
            addCommentToCompletedTrail(commentText, completedTrail);
          }
        });

      } else {
        print('Error fetching comments: ${responseComments.body}');
        throw Exception('Failed to fetch comments');
      }
    } catch (e) {
      print('Error fetching comments: $e');
    }
  }

    void addCommentToCompletedTrail(String comment, trail completedTrail) {
      String combinedString = "${completedTrail.name}:  $comment";
      completedTrail.hasCommented = true; // Set hasCommented to true
      completedTrailComments.add(combinedString); // Add combined string to the list
    }

    void addCompletedTrail(trail completedTrail) {
      completedTrails.add(completedTrail);
    }

  @override
  void initState() {
    super.initState();
    getUserDetails().then((value) => fetchFollowedUsers().then((value2) => fetchAndStoreFavoritesAndComments()));

  }

  @override

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FollowingScreen(followedUsers: followedUsers),
                ),
              ),
            ),
            IconButton(
              onPressed: () async {
                // Construct the updated following array
                List<String> updatedFollowing = List<String>.from(currentUser['following']);
                if (!updatedFollowing.contains(widget.user.email)) {
                  updatedFollowing.add(widget.user.email);
                } else {
                  updatedFollowing.remove(widget.user.email);
                }

                // Update the following array in the user object
                setState(() {
                  currentUser['following'] = updatedFollowing;
                });

                // Send a request to update the following array in the backend
                try {
                  final response = await http.put(
                    Uri.parse('http://10.0.2.2:5151/api/users/${currentUser['email']}/following'),
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(updatedFollowing),
                  );

                  if (response.statusCode == 200) {
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    String updatedUserJson = jsonEncode(currentUser);
                    await prefs.setString('user', updatedUserJson);
                    print('Following updated successfully');
                    fetchFollowedUsers();
                  } else {
                    print('Failed to update following: ${response.statusCode} ${response.body}');
                  }
                } catch (e) {
                  print('Error updating following: $e');
                }
              },
              icon: Icon(currentUser['following'].contains(widget.user.email) ? Icons.person_add_alt_1_rounded : Icons.person_add_alt_outlined),
              color: Color(0xff447a38),
              iconSize: 30,
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
                widget.imageData != null ?
                Positioned(
                  top: 80,
                  left:60,
                  right:60,
                  child: Container(
                    width: 90.0,
                    height: 90.0,
                    decoration: BoxDecoration(
                        color: Colors.green.withOpacity(.8),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: MemoryImage(
                              widget.imageData!),
                          fit: BoxFit.cover,
                        )
                    ),
                  ),
                )
                    :
                Positioned(
                  top: 80,
                  left:60,
                  right:60,
                  child: Container(
                    width: 90.0,
                    height: 90.0,
                    decoration: BoxDecoration(
                      color: Colors.green.withOpacity(.8),
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/icons/profile.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 170.0,
                    left: 120.0,
                    right: 120.0,
                  ),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.user.userName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xffd6e1da),
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          widget.user.email,
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
                                    onDelete: () async {},
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
