import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:final_project1/Screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:final_project1/Models/pick_image.dart';
import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../profile_screen.dart';
import 'package:path_provider/path_provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key?key}):super(key:key);
  @override
  _AccountScreenState createState()=>_AccountScreenState();
}
class _AccountScreenState extends State<AccountScreen> {
  bool isPrivate = false;
  late Map<String, dynamic> user = {};
  Uint8List? profilePicture;

  Future<File> createFile(Uint8List imageBytes, String filename) async {
    // Get the temporary directory using the path_provider plugin
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;

    // Create a new file in the temporary directory
    File file = File('$tempPath/$filename');

    // Write the image bytes to the file
    await file.writeAsBytes(imageBytes);

    return file;
  }

  void selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    if (img != null) {
      File imageFile = await createFile(img, '${user['email']}-profile_picture.jpg');
      uploadImage(imageFile, img);
    }
  }

  Future<void> uploadImage(File imageFile, Uint8List img) async {
    String encodedEmail = Uri.encodeComponent(user['email']);
    // Define the API endpoint URL
    String apiUrl = 'http://10.0.2.2:5151/api/users/$encodedEmail/profile-picture';

    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    // Add the image file to the request
    var file = await http.MultipartFile.fromPath('file', imageFile.path);
    request.files.add(file);

    // Send the multipart request
    var streamedResponse = await request.send();

    // Check the response status
    if (streamedResponse.statusCode == 200) {
      // Image uploaded successfully
      print('Image uploaded successfully');
      setState(() {
        profilePicture = img;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(imageData: profilePicture,),
          ),
        );
      });
    } else {
      // Error uploading image
      print('Error uploading image');
    }
  }

  @override
  void initState() {
    super.initState();
    getUserDetails().then((value) => fetchProfilePicture(user['email'])); // Call getUserDetails function when the widget is initialized
  }

  Future<void> fetchProfilePicture(String email) async {
    try {
      final response = await http.get(
          Uri.parse('http://10.0.2.2:5151/api/users/$email/profile-picture'));

      if (response.statusCode == 200) {
        setState(() {
          profilePicture = response.bodyBytes;
        });
      } else {
        throw Exception('Failed to load profile picture');
      }
    } catch (e) {
      print('Error fetching profile picture: $e');
    }
  }

  Future<void> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      // Parse the user JSON string back to a map
      setState(() {
        user = jsonDecode(userJson);
        isPrivate = user['isPrivate'];
      });
      // Now you can use the 'user' map as needed
      print('User: $user');
    } else {
      print('User data not found in shared preferences');
    }
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
                      Center(
                        child: Text(
                          user['firstName'] + ' ' + user['lastName'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xffd6e1da),
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          user['email'],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xffbabdbd),
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
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
                profilePicture != null ?
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
                        image: MemoryImage(profilePicture!),
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

  Future<void> togglePrivacy() async {
    // Make a request to toggle the privacy setting
    final response = await http.patch(
      Uri.parse('http://10.0.2.2:5151/api/users/${user['email']}/privacy/toggle'),
    );

    if (response.statusCode == 200) {
      // Successfully toggled privacy setting
      print('Privacy setting toggled successfully');
    } else {
      // Failed to toggle privacy setting
      print('Failed to toggle privacy setting: ${response.body}');
    }
    setState(() {
      isPrivate = !(isPrivate ?? false); // If isPrivate is null, default to false
    });
    user['isPrivate'] = isPrivate;
    // Convert the user map back to a JSON string
    String updatedUserJson = jsonEncode(user);
    // Save the updated user JSON string in SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', updatedUserJson);
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
                    onPressed: () async {
                      // Call the backend API to delete the user
                      final response = await http.delete(
                        Uri.parse('http://10.0.2.2:5151/api/Auth/${user['email']}/delete'), // Modify the URL accordingly
                      );

                      // Check if the deletion was successful
                      if (response.statusCode == 200) {
                        // Deletion successful, navigate to WelcomeScreen
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => WelcomeScreen(title: 'My App')),
                        );
                      } else {
                        // Deletion failed, show an error message
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('Failed to delete account. Please try again later.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text(
                      'Delete',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
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