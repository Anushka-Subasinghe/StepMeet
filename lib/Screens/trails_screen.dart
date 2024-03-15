import 'package:final_project1/Models/Map_list.dart';
import 'package:final_project1/Screens/explore_screen.dart';
import 'package:final_project1/Screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:final_project1/Screens/map_screen.dart';
import 'package:final_project1/Models/Map_list.dart';

class TrailsScreen extends StatefulWidget {
  final int trailID;
  final Function(String) onTrailCompleted; // Callback function

  const TrailsScreen({Key? key, required this.trailID, required this.onTrailCompleted}) : super(key: key);

  @override
  State<TrailsScreen> createState() => _TrailsScreenState();
}
class _TrailsScreenState extends State<TrailsScreen> {
  //Toggle Favorite button
  bool toggleIsFavorite(bool isFavorite) {
    return !isFavorite;
  }

  @override
  Widget build(BuildContext) {
    Size size=MediaQuery.of(context).size;
    int selectedIndex=0;
    List<trail> _trailList =trail.trailList;

    return Scaffold(
      body: Stack(
        children:[
          Image.asset(
              _trailList[widget.trailID].imageURL,
              height:size.height,
              width:size.width,
              fit:BoxFit.cover,
          ),
          Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.9),
                ],
                stops: [
                  0.5,
                  0.8,
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: ()=>Navigator.of(context).pop(),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 64.0,
                bottom: 0.0,
                left: 28.0,
                right:28.0,
              ),
              child: SvgPicture.asset("assets/icons/left-arrow-svgrepo-com.svg",
                height: 34.0,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 28.0,
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                   _trailList[widget.trailID].name,
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Row(
                    children: List.generate(
                        5,
                              (index) => Icon(
                                Icons.park_outlined,
                                color:Colors.greenAccent,
                              ),
                      ),
                  ),
                  SizedBox(height: 12.0),
                  Container(
                    width: size.width/1.1,
                    child:Text(
                      _trailList[widget.trailID].start,
                      style: TextStyle(
                        fontSize: 21.0,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "Route Length",
                    style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    _trailList[widget.trailID].length,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(height: 100.0),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  mapViewButton(context,widget.trailID,widget.onTrailCompleted),
                  SizedBox(height: 50.0),
                ],
              ),
            ),
          Positioned(
            top: 58,
            right: 28,
            child: Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white.withOpacity(0.8),
            ),
            child: IconButton(
              onPressed: () {
                setState(() {
                  bool isFavorite = toggleIsFavorite(
                      _trailList[widget.trailID].isfavorite);
                  _trailList[widget.trailID].isfavorite = isFavorite;
                });
              },
              icon: Icon(_trailList[widget.trailID].isfavorite==true? Icons.favorite: Icons.favorite_border),
              color:Color(0xff447a38),
              iconSize:30,
            ),

          ),
              ),
        ]
      ),
    );
  }
  }

Container mapViewButton(BuildContext context,int trailID,Function(String) onTrailCompleted) {
  return Container(width: MediaQuery.of(context).size.width,
    height: 50,
    alignment: Alignment.center,
    //margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MapScreen(
              trailID: trailID,
              onTrailCompleted: onTrailCompleted, // Pass callback function to MapScreen
            ),
            ));
      },
      child: Text("Start Journey",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18.0,
          color: Colors.black54,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.pressed)) {
            return Colors.black26;
          }
          return Color(0xffade0d2);
        }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
        ),
      ),
    ),
  );
}