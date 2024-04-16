import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:final_project1/Models/user_list.dart';
import '../Screens/community_screen.dart';
import 'package:http/http.dart' as http;

class UserWidget extends StatefulWidget {
  const UserWidget({
    Key? key,
    required this.index,
    required this.userList,
  }) : super(key: key);

  final int index;
  final List<user> userList;

  @override
  State<UserWidget> createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  Uint8List? profilePicture;

  @override
  void initState() {
    super.initState();
    fetchProfilePicture(widget.userList[widget.index].email);
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void navigateToCommunityScreen() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CommunityScreen(user: widget.userList[widget.index], imageData: profilePicture,),
        ),
      );
    }

    void showPrivateDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Private User'),
            content: Text('This user is currently in private mode.'),
            actions: [
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }

    return GestureDetector(
      onTap: () {
        if (!widget.userList[widget.index].isPrivate) {
          navigateToCommunityScreen();
        } else {
          showPrivateDialog();
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xff579678).withOpacity(.6),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 80.0,
        padding: const EdgeInsets.only(left: 10, top: 10),
        margin: const EdgeInsets.only(bottom: 10, top: 0),
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                profilePicture != null ? Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(.8),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: MemoryImage(profilePicture!),
                      fit: BoxFit.cover,
                    ),
                  ),
                ) : Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(.8),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage('assets/icons/profile.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  left: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.userList[widget.index].userName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xff1c1b1b),
                        ),
                      ),
                    ],
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
