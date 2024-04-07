import 'package:final_project1/Screens/setting_screens/Feedback_Screen.dart';
import 'package:final_project1/Screens/setting_screens/about_stepmeet.dart';
import 'package:final_project1/Screens/setting_screens/account_settings.dart';
import 'package:final_project1/Screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:final_project1/Models/pick_image.dart';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';

import '../profile_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key?key}):super(key:key);
  @override
  _AccountScreenState createState()=>_AccountScreenState();
}
class _AccountScreenState extends State<AccountScreen> {
  Uint8List? _image;
  bool isPrivate = false;
  void selectImage()async{
     Uint8List img = await pickImage(ImageSource.gallery);
     setState(() {
       _image = img;
     });
  }

  @override
  Widget build(BuildContext context) {
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
              color: Color(0xffcae5e5),
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Image.asset(
                  'assets/images/get started.jpg',
                  height: 850.0,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 850.0,
                  width: size.width,
                  color: Colors.black.withOpacity(0.8),
                ),
                Container(
                  padding: EdgeInsets.only(
                    top: 190.0,
                    left: 120.0,
                    right: 120.0,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Username",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xffd6e1da),
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "user10@gmail.com",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xffbabdbd),
                          fontWeight: FontWeight.w500,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0.0,
                  child: SingleChildScrollView(
                    child: Container(
                      height: 600.0,
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(40.0),
                          topLeft: Radius.circular(40.0),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 30,),
                          PrivacyButton(context, isPrivate),
                          deleteButton(context, () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => WelcomeScreen(title: 'My App',)),
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
                _image != null ?
                Positioned(
                  top: 100,
                  left: 155,
                  child: Container(
                    width: 90.0,
                    height: 90.0,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: MemoryImage(_image!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
                    :
                Positioned(
                  top: 100,
                  left: 155,
                  child: Container(
                    width: 90.0,
                    height: 90.0,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/icons/profile.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 155,
                  left: 195,
                  child: IconButton(
                    onPressed: () {
                      selectImage(); // Select the image
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProfileScreen(imageData: _image),
                        ),
                      );
                    },
                    iconSize: 30,
                    color: Color(0xff479f7f),
                    icon: const Icon(Icons.add_a_photo),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void togglePrivacy() {
    setState(() {
      isPrivate = !(isPrivate ?? false); // If isPrivate is null, default to false
    });
  }

  Container PrivacyButton(BuildContext context, bool isPrivate) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(0),
        color: isPrivate ? Colors.red.withOpacity(0.6) : Color(0xff519476).withOpacity(0.6), // Color depends on privacy state
      ),
      child: ElevatedButton(
        onPressed: () {
          _showConfirmationDialog(context, isPrivate); // Show confirmation dialog
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          elevation: MaterialStateProperty.all<double>(0), // No elevation
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(0))
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Change Privacy',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(width: 70),
            Text(
              isPrivate ? 'Private' : 'Public', // Text depends on privacy state
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Icon(
              isPrivate ? Icons.lock : Icons.lock_open, // Icon depends on privacy state
              color: Colors.white,
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }

  Future<void> _showConfirmationDialog(BuildContext context, bool isPrivate) async {
    bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text(isPrivate
              ? 'Are you sure you want to make your account public?'
              : 'Are you sure you want to make your account private?'),
          actions: <Widget>[
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true); // Close the dialog and return true
              },
            ),
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false); // Close the dialog and return false
              },
            ),
          ],
        );
      },
    );

    if (confirm != null && confirm) {
      // If user confirmed, toggle the privacy state
      togglePrivacy();
      // Perform any other necessary actions here after the privacy state is changed
    }
  }

  Container deleteButton(BuildContext context, Function onTap) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child: ElevatedButton(
        onPressed: () {
          // Show confirmation dialog before deleting account
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Confirm Deletion'),
                content: Text('Are you sure you want to delete your account? This action cannot be undone.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      onTap(); // Call the onTap function passed from outside to delete account
                      Navigator.of(context).pop(); // Close the dialog
                      Navigator.pushReplacement( // Navigate to the welcome page
                        context,
                        MaterialPageRoute(builder: (context) => WelcomeScreen(title: 'My App')),
                      );
                    },
                    child: Text('Delete'),
                  ),
                ],
              );
            },
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Delete Account',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if(states.contains(MaterialState.pressed)){
              return Colors.black26;
            }
            return Color(0xff519476).withOpacity(0.6);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0),
            ),
          ),
        ),
      ),
    );
  }
}