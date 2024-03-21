import 'package:final_project1/Screens/following_screen.dart';
import 'package:final_project1/Screens/searchUsers.dart';
import 'package:flutter/material.dart';

import '../Models/Map_list.dart';
import '../Models/user_list.dart';

class CommunityScreen extends StatefulWidget {
  final int userID;
  const CommunityScreen ({Key? key,required this.userID}) : super(key: key);

  @override
  State<CommunityScreen>  createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen > {
  bool toggleFollow(bool isFollowing) {
    return !isFollowing;
  }
  List<user> followed = [];

  @override

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int selectedIndex=0;
    List<user> _userList =user.userList;
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
                  builder: (context) => FollowingScreen(followedUsers: followed),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  bool isFavorite = toggleFollow(
                      _userList[widget.userID].hasFollowed);
                  _userList[widget.userID].hasFollowed = isFavorite;
                  final List<user> followedUsers = user.getFollowedUsers();
                  followed = followedUsers;
                });
              },
              icon: Icon(_userList[widget.userID].hasFollowed==true? Icons.person_add_alt_1_rounded: Icons.person_add_alt_outlined),
              color:Color(0xff447a38),
              iconSize:30,
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
                          image: AssetImage(
                              _userList[widget.userID].dpURL),
                          fit: BoxFit.cover,
                        )
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
                          _userList[widget.userID].userName,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xffd6e1da),
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          _userList[widget.userID].email,
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
