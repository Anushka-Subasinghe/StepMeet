import 'package:final_project1/Screens/setting_screens/account_settings.dart';
import 'package:final_project1/Screens/settings_screen.dart';
import 'package:flutter/material.dart';

import '../Models/Map_list.dart';
import '../reusable_widgets/trail_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    Size size = MediaQuery.of(context).size;
    List<trail> _trailList = trail.trailList;
    List<trail> completedTrails = trail.completedTrails;

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
                fontSize: 30,
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
                Positioned(
                  top: 90,
                  left: 155,
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
                        "Username",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xffd6e1da),
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "user10@gmail.com",
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
