import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project1/reusable_widgets/reusable_widget.dart';
import 'package:final_project1/Screens/signin_screen.dart';
import 'package:final_project1/Screens/home_screen.dart';

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
      // Create user with email and password
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailTextController.text,
        password: _passwordTextController.text,
      );

      // Add user details to Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'firstName': _firstNameTextController.text,
        'lastName': _lastNameTextController.text,
        'email': _emailTextController.text,
        // Add more user details as needed
      });

      // Navigate to HomeScreen after successful registration
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } catch (e) {
      // Handle errors
      print('Failed to register: $e');
      // Display error to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
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
                          SizedBox(height: 30),
                          Text(
                            "Create an account ",
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
                          reusableTextField(
                              " First Name", Icons.person_outline, false, _firstNameTextController),
                          SizedBox(
                            height: 20,
                          ),
                          reusableTextField(
                              " Last Name", Icons.person_outline, false, _lastNameTextController),
                          SizedBox(
                            height: 20,
                          ),
                          reusableTextField(" Email", Icons.mail_outline, false, _emailTextController),
                          SizedBox(
                            height: 20,
                          ),
                          reusableTextField(
                              " Password", Icons.lock_outline, true, _passwordTextController),
                          SizedBox(
                            height: 20,
                          ),
                          signInSignUpButton(context, false, _register),
                          signInOption(),
                          SizedBox(
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
            Navigator.push(context, MaterialPageRoute(builder: (context) => SignInScreen()));
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
