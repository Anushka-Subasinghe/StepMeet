import 'package:flutter/material.dart';
import 'package:final_project1/Screens/explore_screen.dart';
import 'package:final_project1/reusable_widgets/list.dart';

import 'navigation_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key?key}):super(key:key);
  @override
  _HomeScreenState createState()=>_HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        ),
    body:Column(
        children: [
    Stack(
      children: [
      Image.asset('assets/images/get started.jpg',
        height: 536.0,
        width: size.width,
        fit: BoxFit.cover,
      ),
      Positioned(
         bottom: 0.0,
         child: Container(
           height: 36.0,
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
    Container(
      padding: EdgeInsets.only(
        top: 0.0,
        bottom: 0.0,
        left: 36.0,
        right: 36.0,
      ),
      child:Column(
        children: [
          Text("Choose your preferred walking trail.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
          ),
          ),
          SizedBox(height: 24.0,),
          Text("Take a stroll through stunning country parks and open spaces or meander alongside lakes and rivers in Wales.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: 24.0,),
          getStartedButton(context,() {}),
        ],
      ),
    )
      ],
      ),
    );
  }
}
Container getStartedButton(BuildContext context,Function onTap){
  return Container(width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0,10,0,20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed:(){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NavigationScreen()));

      },
      child:Text("Get Started",
        textAlign: TextAlign.center,
          style: TextStyle(
               fontSize: 18.0,
               color: Colors.black54,
          ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states){
          if(states.contains(MaterialState.pressed)){
            return Colors.black26;
          }
          return Color(0xffade0d2);
        }),
        shape:MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
        ),
      ),
    ),
  );
}
