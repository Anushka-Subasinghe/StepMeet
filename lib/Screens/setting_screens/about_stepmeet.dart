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
              color: Color(0xffd6e1da),
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context)=>SettingsScreen(),
                ),
              ),
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
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
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
