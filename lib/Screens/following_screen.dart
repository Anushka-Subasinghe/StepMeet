import 'package:final_project1/Screens/searchUsers.dart';
import 'package:flutter/material.dart';
import 'package:final_project1/Models/user_list.dart';
import 'SearchScreen.dart';
import '../reusable_widgets/user_widget.dart';

class FollowingScreen extends StatefulWidget {
  final List<user> followedUsers;
  const FollowingScreen({Key? key, required this.followedUsers})
      : super(key: key);

  @override
  State<FollowingScreen> createState() => _FollowingScreenState();
}
class _FollowingScreenState extends State<FollowingScreen> {
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
              color: Color(0xffe2f8f8),
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).pop(),
            ),
            Text("  Following", style: TextStyle(
              color: Color(0xffd6e1da),
              fontWeight: FontWeight.w500,
              fontSize: 26,
            ),),
            IconButton(
              iconSize: 30,
              color: Color(0xffd6e1da),
              icon: const Icon(Icons.search),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context)=>SearchUsersScreen(),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body:Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/get started.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 850.0,
              width: size.width,
              color: Colors.black.withOpacity(0.8),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 0.0,
                left: 15.0,
                right: 15.0,
              ),
              child: Container(
                child: Column(
                    children:[
                      Expanded(
                        child:widget.followedUsers.isEmpty
                            ? Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 100,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Explore the community...',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        )
                            : Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
                          child: ListView.builder(
                              itemCount: widget.followedUsers.length,
                              itemBuilder: (BuildContext context, int index) {
                                return UserWidget(
                                    index: index, userList: widget.followedUsers);
                              }),
                        ),
                      ),
                    ]
                ),
              ),
            ),
          ]
      ),
    );
  }
}