import 'package:flutter/material.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen ({Key? key}) : super(key: key);

  @override
  State<CommunityScreen>  createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen > {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset('assets/images/get started.jpg',
                  height: 850.0,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 850.0,
                  width: size.width,
                  color: Colors.black.withOpacity(0.8),
                ),
                Positioned(
                  bottom: 0.0,
                  child: Container(
                    height: 600.0,
                    width: size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40.0),
                          topLeft: Radius.circular(40.0),
                        )
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