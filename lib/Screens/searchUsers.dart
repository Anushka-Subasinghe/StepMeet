import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:final_project1/Models/user_list.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'navigation_bar.dart';
import '../reusable_widgets/user_widget.dart';
import 'package:http/http.dart' as http;

class SearchUsersScreen extends StatefulWidget {

  const SearchUsersScreen({Key?key}):super(key:key);
  @override

  _SearchUsersScreenState createState()=>_SearchUsersScreenState();
}
class _SearchUsersScreenState extends State<SearchUsersScreen> {
  late Map<String, dynamic> currentUser = {};

  Future<void> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson != null) {
      // Parse the user JSON string back to a map
      setState(() {
        currentUser = jsonDecode(userJson);
      });
      // Now you can use the 'user' map as needed
      print('User: $user');
    } else {
      print('User data not found in shared preferences');
    }
  }

  // This list holds the data for the list view
  List<user> _foundUsers = [];
  @override
  initState() {
    getUserDetails(); // Call getUserDetails function when the widget is initialized
    super.initState();
  }
  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) async {
    List<user> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, display all trails
      results = [];
      setState(() {
        _foundUsers = results;
      });
    } else {
      try {
        final response = await http.get(
          Uri.parse('http://10.0.2.2:5151/api/users/search/$enteredKeyword'),
        );

        if (response.statusCode == 200) {
          // Parse the response JSON
          List<dynamic> usersData = json.decode(response.body);

          print(usersData[0]);

          // Get the email of the current user
          String currentUserEmail = currentUser['email']; // Assuming 'user' is the current user object

          results = usersData
              .where((userData) => userData['email'] != currentUserEmail) // Filter out the current user
              .map((userData) {
            int index = usersData.indexOf(userData);

            return user(
              userID: index,
              userName: usersData[index]['firstName'] + ' ' + usersData[index]['lastName'],
              email: usersData[index]['email'],
              isPrivate: usersData[index]['isPrivate'],
              dpURL :'assets/images/Mynydd-Gelliwion.jpg',
              hasFollowed : false,
            );
          }).toList();

          // // Convert the JSON data to a list of User objects
          // results = usersData.map((userData) => User.fromJson(userData)).toList();
          //
          // // Refresh the UI
          setState(() {
            _foundUsers = results;
          });

        } else {
          setState(() {
            _foundUsers = [];
          });
          throw Exception('Failed to load users');
        }
      } catch (e) {
        print('Error: $e');
        // Handle error
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    Size size = MediaQuery
        .of(context)
        .size;
    List<user> _userList = user.userList;

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
              color: Color(0xffddf6f6),
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).pop(),
            ),
            IconButton(
              iconSize: 30,
              color: Color(0xffd1e3da),
              icon: const Icon(Icons.home),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context)=>NavigationScreen(),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body:Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/images/get started.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 850.0,
              width: size.width,
              color: Colors.black.withOpacity(0.8),
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 64.0,
                bottom: 0.0,
                left: 15.0,
                right: 15.0,
              ),
              child: Container(
                child: Column(
                    children:[
                      SizedBox(height: 24.0),
                      Text(
                        "Search Users",
                        style: TextStyle(
                          fontSize: 30.0,
                          color:Color(0xffc1cbbf),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 15.0),
                      TextField(
                        onChanged: (value) => _runFilter(value),
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white.withOpacity(0.9)),
                        decoration: InputDecoration(
                          hintText: "Search users ...",
                          hintStyle: TextStyle(
                            fontSize: 20.0, color: Colors.white.withOpacity(0.9),
                          ),
                          prefixIcon: Icon(
                            Icons.search, color: Colors.white.withOpacity(0.9),
                            size: 34.0,),
                          labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                          filled: true,
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(
                                width: 5, style: BorderStyle.none),
                          ),
                        ),
                      ),

                      Expanded(
                        child: _foundUsers.isNotEmpty
                            ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                          child: ListView.builder(
                              itemCount: _foundUsers.length,
                              itemBuilder: (BuildContext context, int index) {
                                return UserWidget(
                                    index: index, userList: _foundUsers);
                              }),
                        )
                            : const Text(
                          'No results found!',
                          style: TextStyle(fontSize: 18,color: Colors.white10),
                        ),
                      ),
                    ]
                ),
              ),
            ),
          ]
      ),
    );
  }
}