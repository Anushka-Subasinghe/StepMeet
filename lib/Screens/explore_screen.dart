import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:final_project1/Screens/trails_screen.dart';
import 'package:final_project1/Models/Map_list.dart';
import 'package:final_project1/Screens/SearchScreen.dart';

import 'map_screen.dart';

class ExploreScreen extends StatefulWidget {

  const ExploreScreen({Key?key}):super(key:key);
  @override

  _ExploreScreenState createState()=>_ExploreScreenState();
}
class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext) {
    int selectedIndex = 0;
    Size size = MediaQuery
        .of(context)
        .size;
    List<trail> _trailList = trail.trailList;
    bool toggleIsFavorite(bool isFavorite) {
      return !isFavorite;
    }
    void onTrailCompleted(String trailName) {

    }
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset('assets/images/get started.jpg',
                  height: 850,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 850.0,
                  width: size.width,
                  color: Colors.black.withOpacity(0.8),
                ),
            Container(
              child: SingleChildScrollView(
              padding: const EdgeInsets.only(
                top: 64.0,
                bottom: 0.0,
                left: 32.0,
                right: 32.0,
              ),
              child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          "Explore Walking Paths",
                          style: TextStyle(
                            fontSize: 30.0,
                            color:Color(0xffc1cbbf),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Text(
                          "and Trails in Wales... ",
                          style: TextStyle(
                            fontSize: 30.0,
                            color:Color(0xffc1cbbf),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          iconSize: 35,
                          color: const Color(0xffc1cbbf),
                          icon: const Icon(Icons.search),
                          onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context)=>const SearchScreen(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40.0),
                    Container(
                        height: 500.0,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _trailList.length,
                            itemBuilder: (context, int index) {
                              return GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context)=>TrailsScreen(
                                      trailID: _trailList[index].trailID,
                                      onTrailCompleted: onTrailCompleted,
                                    ),
                                  ),
                                ),
                                child: Stack(
                                  children: [
                                    Hero(
                                      tag: "trail$index",
                                      child:
                                      Container(
                                        height: 500.0,
                                        width: 250.0,
                                        margin: const EdgeInsets.only(right: 24.0),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(14.0),
                                            border: Border.all(color: Colors.white38),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  _trailList[index].imageURL),
                                              fit: BoxFit.cover,
                                            )
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 500.0,
                                      width: 250.0,
                                      margin: const EdgeInsets.only(right: 24.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(14.0),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            Colors.black12.withOpacity(0.4),
                                          ],
                                          stops: const [
                                            0.6,
                                            0.9,
                                          ],
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 24.0,
                                      left: 24.0,
                                      child: GlassmorphicContainer(
                                        height: 32.0,
                                        width: 150.0,
                                        blur: 4.0,
                                        border: 0.0,
                                        borderRadius: 8.0,
                                        linearGradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.white.withOpacity(0.4),
                                            Colors.white.withOpacity(0.4),
                                          ],
                                        ),
                                        borderGradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.white.withOpacity(0.4),
                                            Colors.white.withOpacity(0.4),
                                          ],
                                        ),
                                        child: Align(
                                          alignment: Alignment.center,
                                          child: Text(
                                            _trailList[index].level,
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
        
                                      ),
                                    ),
                                    Positioned(
                                      top: 10,
                                      right: 30,
                                      child: Container(
                                        height: 45,
                                        width: 45,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(25),
                                          color: Colors.white38.withOpacity(0.8),
                                        ),
                                        child: IconButton(
                                          onPressed: () {
                                            setState(() {
                                              bool isFavorite = toggleIsFavorite(
                                                  _trailList[index]
                                                      .isfavorite);
                                              _trailList[index].isfavorite =
                                                  isFavorite;
                                            });
                                          },
                                          icon: Icon(
                                            _trailList[index].isfavorite == true
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color:const Color(0xff447a38),
                                          ),
                                          iconSize: 30,
                                        ),
        
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 32.0,
                                        left: 24.0,
                                        child: Container(
                                          width: size.width / 2.6,
                                          child: Text(
                                            _trailList[index].name,
                                            style: const TextStyle(
                                              fontSize: 28.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              );
                            }
                        )
                    ),
            ]
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