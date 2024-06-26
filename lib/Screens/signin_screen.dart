import 'package:final_project1/Screens/home_screen.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:final_project1/reusable_widgets/reusable_widget.dart';
import 'package:final_project1/Screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signIn() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5151/api/Auth/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': _emailTextController.text.trim(),
          'password': _passwordTextController.text,
        }),
      );

      if (response.statusCode == 200) {
        print(response.body);

        // Parse the response body as JSON
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // Extract the 'user' object
        Map<String, dynamic> user = jsonResponse['user'];

        // Convert the 'user' object back to JSON
        String userJson = jsonEncode(user);

        // Save the user JSON in shared preferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('user', userJson);

        // Login successful, navigate to HomeScreen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        // Login failed, display error message
        throw Exception('Failed to sign in: ${response.body}');
      }
    } catch (e) {
      print('Failed to sign in: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to sign in: $e')));
    }
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/get started.jpg',
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
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 30,
                          ),
                          Text(
                            "Log In ",
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
                          reusableTextField(
                              "Enter Username", Icons.person_outline, false, _emailTextController),
                          SizedBox(
                            height: 20,
                          ),
                          reusableTextField(
                              "Enter Password", Icons.lock_outline, true, _passwordTextController),
                          SizedBox(
                            height: 20,
                          ),
                          signInSignUpButton(context, true, _signIn),
                          signUpOption(),
                        ],
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
            style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
          child: const Text(
            "Sign Up",
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
