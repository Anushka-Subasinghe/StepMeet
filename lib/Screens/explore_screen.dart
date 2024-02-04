import 'package:flutter/material.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:final_project1/Screens/trails_screen.dart';
import 'package:final_project1/reusable_widgets/list.dart';
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({Key?key}):super(key:key);
  @override
  _ExploreScreenState createState()=>_ExploreScreenState();
}
class _ExploreScreenState extends State<ExploreScreen> {
  List types =[
    {
      "image":'assets/images/Mynydd-Gelliwion.jpg',
      "name":"Mynydd Gelliwion Walk",
      "level":"Recommended",
    },
    {
      "image":"assets/images/CwmClydachWaterfall.jpg",
      "name":"Cwm Clydach Lake Walk",
      "level":"Recommended",
    },
    {
      "image":"assets/images/DarranParkLake.jpg",
      "name":"Darran Park Circular walk",
      "level":"Recommended",
    },
    {
      "image":"assets/images/Maerdy Reservoir Walk.jpg",
      "name":"Maerdy Reservoir Walk",
      "level":"Recommended",
    },
    {
      "image":"assets/images/cwm-clydach.jpg",
      "name":"Clydach Vale Circular Walk",
      "level":"Recommended",
    },

  ];

  @override
  Widget build(BuildContext) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 64.0,
          bottom: 0.0,
          left: 32.0,
          right: 32.0,
        ),
        child: Column(
          children: [
            SizedBox(height: 24.0),
            Text(
              "Explore Walking Paths and Trails in Wales!",
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24.0),
                Container(
                  child: TextField(
                    cursorColor: Colors.white,
                    style: TextStyle(color:Colors.white.withOpacity(0.9)),
                    decoration: InputDecoration(
                      hintText: "Search a trail ...",
                      hintStyle: TextStyle(
                        fontSize: 20.0,color: Colors.white.withOpacity(0.9),
                      ),
                      prefixIcon: Icon(Icons.search, color: Colors.white.withOpacity(0.9),size:34.0,),
                      labelStyle: TextStyle(color:Colors.white.withOpacity(0.9)),
                      filled: true,
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      fillColor: Color(0xffade0d2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: const BorderSide(width:0,style:BorderStyle.none),
                      ),
                    ),
                  ),
                ),
            SizedBox(height: 28.0),
            Container(
              height: 450.0,
              child:ListView.builder(
                scrollDirection: Axis.horizontal,
                   itemCount: types.length,
                  itemBuilder: (context,index) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context)=>TrailsScreen(
                        index,
                            trails[index]["image"],
                            trails[index]["name"],
                            trails[index]["start"],
                            trails[index]["length"]
                          ),
                      ),
                    ),
                  child: Stack(
                      children: [
                        Hero(
                          tag: "trail$index",
                          child:
                            Container(
                              height: 450.0,
                              width: 250.0,
                              margin: EdgeInsets.only(right: 24.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14.0),
                                  image: DecorationImage(
                                    image: AssetImage(
                                       types[index]["image"]),
                                    fit: BoxFit.cover,
                                  )
                              ),
                            ),
                        ),
                            Container(
                              height: 450.0,
                              width: 250.0,
                              margin: EdgeInsets.only(right: 24.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(14.0),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    Colors.black12.withOpacity(0.4),
                                  ],
                                  stops: [
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
                                    types[index]["level"],
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),

                              ),
                            ),
                            Positioned(
                                bottom: 32.0,
                                left: 24.0,
                                child: Container(
                                  width: size.width / 2.6,
                                  child: Text(
                                    types[index]["name"],
                                    style: TextStyle(
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
            )
          ]
        ),
      ),
      ),
    );
  }
}