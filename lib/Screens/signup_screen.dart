import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:final_project1/Screens/home_screen.dart';
import 'package:final_project1/Screens/signin_screen.dart';
import 'package:final_project1/reusable_widgets/reusable_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _firstNameTextController = TextEditingController();
  TextEditingController _lastNameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

  Future<void> _register() async {
    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:5151/api/Auth/register'), // Replace with your API endpoint URL
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'firstName': _firstNameTextController.text,
          'lastName': _lastNameTextController.text,
          'email': _emailTextController.text,
          'password': _passwordTextController.text,
        }),
      );

      if (response.statusCode == 200) {
        String user = jsonEncode(<String, String>{
          'firstName': _firstNameTextController.text,
          'lastName': _lastNameTextController.text,
          'email': _emailTextController.text,
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('user', user);

        // Navigate to HomeScreen after successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } else {
        print(response.body);
        throw Exception('Failed to register');
      }
    } catch (e) {
      // Handle errors
      print('Failed to register: $e');
      // Display error to the user
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to register'),
        ),
      );
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
                    height: 620.0,
                    width: size.width,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        topLeft: Radius.circular(40.0),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: Column(
                        children: <Widget>[
                          const SizedBox(height: 30),
                          const Text(
                            "Create an account ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 32.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          reusableTextField(
                              " First Name", Icons.person_outline, false, _firstNameTextController),
                          const SizedBox(
                            height: 20,
                          ),
                          reusableTextField(
                              " Last Name", Icons.person_outline, false, _lastNameTextController),
                          const SizedBox(
                            height: 20,
                          ),
                          reusableTextField(" Email", Icons.mail_outline, false, _emailTextController),
                          const SizedBox(
                            height: 20,
                          ),
                          reusableTextField(
                              " Password", Icons.lock_outline, true, _passwordTextController),
                          const SizedBox(
                            height: 20,
                          ),
                          signInSignUpButton(context, false, _register),
                          signInOption(),
                          const SizedBox(
                            height: 40,
                          ),
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

  Row signInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Already have an account?  ",
            style: TextStyle(color: Colors.black54, fontSize: 16, fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen()));
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
