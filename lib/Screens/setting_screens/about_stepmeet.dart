import 'package:final_project1/Screens/profile_screen.dart';
import 'package:final_project1/Screens/settings_screen.dart';
import 'package:final_project1/Screens/share_screen.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen ({Key? key}) : super(key: key);

  @override
  State<InfoScreen>  createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
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
              color: Color(0xffcae5e5),
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body:
      SingleChildScrollView(
        child: Column(
            children: [
              Stack(
                children: [
                  Image.asset('assets/images/get started.jpg',
                    height: 891.0,
                    width: size.width,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    height: 891.0,
                    width: size.width,
                    color: Colors.black.withOpacity(0.6),
                  ),
                  Positioned(
                    top: 100,
                    left:50,
                    right:30,
                    child:
                    Container(
                      height: 650.0,
                      width: 250.0,
                      margin: EdgeInsets.only(right: 24.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                        color: Color(0xffede4f3).withOpacity(0.5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                        Text(
                        'About StepMeet',
                        style: TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10),
                       const Padding(
                        padding: EdgeInsets.all(18.0),
                          child: Center(
                            child: Text(
                              'Welcome to StepMeet, a project created as part of my final year project at University of South Wales. This app serves as a platform for discovering walking trails in Wales and connecting with fellow outdoor enthusiasts. While this project may be a culmination of my academic journey, StepMeet is designed to help you discover and navigate scenic routes, share your experiences with others, and foster a vibrant community of outdoor adventurers. With user privacy at the forefront, StepMeet ensure that your personal data is securely managed and protected. As I continue to refine and enhance this app, I appreciate your support and feedback. Thank you for being a part of this project, and I hope you enjoy exploring the trails!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ]
                     ),
                  ),
                  ),
                ],
              ),
            ]
        ),
      ),

    );
  }
}
