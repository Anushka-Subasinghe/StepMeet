import 'package:flutter/material.dart';
import 'package:final_project1/reusable_widgets/reusable_widget.dart';
import 'package:final_project1/Screens/signup_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key?key}):super(key:key);
  @override
  _SignInScreenState createState()=>_SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>{
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

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
        height: 450.0,
        width: size.width,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
          topRight: Radius.circular(40.0),
          topLeft: Radius.circular(40.0),
          )
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20,0, 20, 0),
            child: Column(
                children:<Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  Text("Log In ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Username", Icons.person_outline, false, _emailTextController),
                  SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Password", Icons.lock_outline, true, _passwordTextController),
                  SizedBox(
                    height: 20,
                  ),
                  signInSignUpButton(context, true, (){}),
                  signUpOption(),
                ]
            ),
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
  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?  ",
            style: TextStyle(color:Colors.black54,fontSize: 16,fontWeight: FontWeight.bold)),
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