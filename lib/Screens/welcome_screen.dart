
import 'package:flutter/material.dart';
import 'package:final_project1/reusable_widgets/reusable_widget.dart';
import 'package:final_project1/Screens/signup_screen.dart';
import 'package:final_project1/Screens/signin_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key?key, required String title}):super(key:key);
  @override
  _WelcomeScreenState createState()=>_WelcomeScreenState();
}
class _WelcomeScreenState extends State<WelcomeScreen>{

  @override
  Widget build(BuildContext) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:SingleChildScrollView(
      child:Column(
        children: [
      Stack(
      children: [
      Image.asset('assets/images/get started.jpg',
        height: 840.0,
        width: size.width,
        fit: BoxFit.cover,
      ),
      Positioned(
        bottom: 0.0,
        child: Container(
          height: 350.0,
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40.0),
                topLeft: Radius.circular(40.0),
              ),
          ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(20,0, 20, 0),
             child:Column(
              children:[
                SizedBox(
                  height: 30,
                ),
                Text("Welcome to \n StepMeet!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 40.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                signInButton(context, (){}),
                SizedBox(
                  height: 10,
                ),
                Text("OR",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                signUpOption(),
              ]
          ),
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
  Row welcomeText(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Welcome to \n StepMeet!",
        style: const TextStyle(
            color: Colors.black,fontSize: 40,fontWeight: FontWeight.bold,
          //shadows: [
          //Shadow(
            //color: Colors.white,      // Choose the color of the shadow
           // blurRadius: 1.0,          // Adjust the blur radius for the shadow effect
            //offset: Offset(2.0, 2.0), // Set the horizontal and vertical offset for the shadow
         // ),
        //],
        )
    ),

      ],
    );
  }

  Container signInButton(BuildContext context,Function onTap){
    return Container(width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(0,10,0,20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child: ElevatedButton(
        onPressed: (){
            Navigator.push(context,
                MaterialPageRoute(builder: (context)=>SignInScreen()));
        },
        child: Text(
            'Log In',
            style: const TextStyle(
                color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 18)
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
  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?  ",
            style: TextStyle(color:Color(0xff222322),fontSize: 16,fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Color(0xff000000), fontWeight: FontWeight.bold,fontSize: 17,decoration: TextDecoration.underline, decorationThickness: 1,),
          ),
        ),
      ],
    );
  }

}