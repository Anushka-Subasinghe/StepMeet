import 'package:final_project1/Screens/setting_screens/Feedback_Screen.dart';
import 'package:final_project1/Screens/setting_screens/about_stepmeet.dart';
import 'package:final_project1/Screens/setting_screens/account_settings.dart';
import 'package:final_project1/Screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:final_project1/Models/Map_list.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key?key}):super(key:key);
  @override
  _SettingsScreenState createState()=>_SettingsScreenState();
}
class _SettingsScreenState extends State<SettingsScreen> {
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
            Text("  Settings", style: TextStyle(
              color: Color(0xffd6e1da),
              fontWeight: FontWeight.w500,
              fontSize: 30,
            ),),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
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
                  child: SingleChildScrollView(
                    child: Container(
                      height:700.0,
                      width: size.width,
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40.0),
                            topLeft: Radius.circular(40.0),
                          )
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30,),
                          SettingsButton(context, true, (){ Navigator.push(context,
                              MaterialPageRoute(builder: (context) => AccountScreen()));}),
                          SettingsButton(context, false, (){ Navigator.push(context,
                              MaterialPageRoute(builder: (context) => FeedbackScreen()));}),
                          SettingsButton1(context, (){ Navigator.push(context,
                              MaterialPageRoute(builder: (context) => InfoScreen()));}),
                         LogoutButton(context, () async {
                           // Clear SharedPreferences
                           SharedPreferences prefs = await SharedPreferences.getInstance();
                           await prefs.clear();
                           trail.clearList();
                           Navigator.push(context,
                              MaterialPageRoute(builder: (context) => WelcomeScreen(title: 'My App',)));}),
                        ],),
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

Container SettingsButton(BuildContext context,bool isAccount, Function onTap){
  return Container(width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0,10,0,0),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: (){
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.only(left:10),
        child: Row(
          children: [
            Text(
                isAccount ? 'View Account Settings':'Send Feedback',
                style: const TextStyle(
                    color: Colors.white70,fontWeight: FontWeight.bold,fontSize: 20)
            ),
          ],
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states){
          if(states.contains(MaterialState.pressed)){
            return Colors.black26;
          }
          return Color(0xff519476).withOpacity(0.6);
        }),
        shape:MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))
        ),
      ),
    ),
  );
}
Container SettingsButton1(BuildContext context, Function onTap){
  return Container(width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0,10,0,0),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: (){
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.only(left:10.0),
        child: Row(
          children: [
            Text(
               'About StepMeet',
                style: const TextStyle(
                    color: Colors.white70,fontWeight: FontWeight.bold,fontSize: 20)
            ),
          ],
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states){
          if(states.contains(MaterialState.pressed)){
            return Colors.black26;
          }
          return Color(0xff519476).withOpacity(0.6);
        }),
        shape:MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))
        ),
      ),
    ),
  );
}
Container LogoutButton(BuildContext context, Function onTap){
  return Container(width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0,10,0,0),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: (){
        onTap();
      },
      child: Padding(
        padding: const EdgeInsets.only(left:10.0),
        child: Row(
          children: [
            Text(
                'Log out',
                style: const TextStyle(
                    color: Colors.white70,fontWeight: FontWeight.bold,fontSize: 20)
            ),
            SizedBox(width: 260,),
            Icon(Icons.logout),
          ],
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states){
          if(states.contains(MaterialState.pressed)){
            return Colors.black26;
          }
          return Color(0xff519476).withOpacity(0.6);
        }),
        shape:MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))
        ),
      ),
    ),
  );
}