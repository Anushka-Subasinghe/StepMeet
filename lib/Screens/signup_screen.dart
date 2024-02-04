
import 'package:flutter/material.dart';
import 'package:final_project1/reusable_widgets/reusable_widget.dart';
import 'package:final_project1/Screens/signin_screen.dart';
import 'package:final_project1/Screens/home_screen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key?key}):super(key:key);
  @override
  _SignUpScreenState createState()=>_SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _firstNameTextController = TextEditingController();
  TextEditingController _lastNameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context){
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
          height: 620.0,
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
                SizedBox(height: 30,),
                Text("Create an acoount ",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                reusableTextField(" First Name", Icons.person_outline, false, _firstNameTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField(" Last Name", Icons.person_outline, false, _lastNameTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField(" Email", Icons.mail_outline, false, _emailTextController),
                SizedBox(
                  height: 20,
                ),
                reusableTextField(" Password", Icons.lock_outline, true, _passwordTextController),
                SizedBox(
                  height: 20,
                ),
                signInSignUpButton(context, false, (){ Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));}),
                signInOption(),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
          ]
        ),
      ]
    ),
        ),
    );
  }

  Row signInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?  ",
            style: TextStyle(color: Colors.black54,fontSize: 16,fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignInScreen()));
          },
          child: const Text(
          "Log In",
          style: TextStyle(
            color: Color(0xff000000),
            fontWeight: FontWeight.bold,
            fontSize: 17,
            decoration: TextDecoration.underline,
            decorationThickness: 1,
             ),
            ),
          ),
      ],
    );
  }
}