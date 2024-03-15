import 'package:final_project1/Screens/profile_screen.dart';
import 'package:final_project1/Screens/settings_screen.dart';
import 'package:final_project1/Screens/share_screen.dart';
import 'package:flutter/material.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen ({Key? key}) : super(key: key);

  @override
  State<FeedbackScreen>  createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
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
                  Padding(
                    padding: const EdgeInsets.only(top:150.0,left: 80,right:60),
                    child: Container(
                      child: Text("Share your feedback \n with StepMeet.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xffc5cec5),
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 270,
                    left:50,
                    right:30,
                    child:
                    Container(
                      height: 350.0,
                      width: 250.0,
                      margin: EdgeInsets.only(right: 24.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14.0),
                        color: Color(0xffede4f3).withOpacity(0.5),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: TextField(
                          cursorColor: Colors.white,
                          style: TextStyle(color: Colors.white.withOpacity(0.9)),
                          decoration: InputDecoration(
                            hintText: "Type Your Feedback ...",
                            hintStyle: TextStyle(
                              fontSize: 20.0, color: Colors.white.withOpacity(0.9),
                            ),
                            labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            // fillColor: Color(0xffede4f3).withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 650,
                    right: 100,
                    left:100,
                    child:  FeedbackButton(context,() {}),
                  ),
                ],
              ),
            ]
        ),
      ),

    );
  }
}
Container FeedbackButton(BuildContext context,Function onTap){
  return Container(//width: MediaQuery.of(context).size.width,
    height: 40,
    width:150,
    margin: const EdgeInsets.fromLTRB(0,10,0,20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed:(){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => FeedbackScreen()));

      },
      child:Text("Share Feedback",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18.0,
          color: Color(0xff063d06),
          fontWeight: FontWeight.w600,
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