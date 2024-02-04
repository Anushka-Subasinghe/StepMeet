import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:final_project1/Screens/map_screen.dart';
import 'package:final_project1/reusable_widgets/list.dart';

class TrailsScreen extends StatefulWidget {

  final int index;
  final String image,name,start,length;
  TrailsScreen(this.index,this.image,this.name,this.start,this.length);

  @override
  _TrailsScreenState createState()=>_TrailsScreenState();
}

class _TrailsScreenState extends State<TrailsScreen> {
  @override
  Widget build(BuildContext) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children:[
        Hero(
            tag:"park${widget.index}",
            child: Image.asset(
                widget.image,
                height:size.height,
                width:size.width,
                fit:BoxFit.cover,
            ),
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
                    widget.name,
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
                      widget.start,
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
                    widget.length,
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
                  mapViewButton(context,(){}),
                  SizedBox(height: 50.0),
                ],
              ),
            ),
        ]
      ),
    );
  }
  }

Container mapViewButton(BuildContext context,Function onTap) {
  return Container(width: MediaQuery.of(context).size.width,
    height: 50,
    alignment: Alignment.center,
    //margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MapScreen()));
      },
      child: Text("Map View",
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