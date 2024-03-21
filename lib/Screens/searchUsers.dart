import 'package:flutter/material.dart';
import 'package:final_project1/Models/user_list.dart';
import 'navigation_bar.dart';
import '../reusable_widgets/user_widget.dart';
class SearchUsersScreen extends StatefulWidget {

  const SearchUsersScreen({Key?key}):super(key:key);
  @override

  _SearchUsersScreenState createState()=>_SearchUsersScreenState();
}
class _SearchUsersScreenState extends State<SearchUsersScreen> {
  List<user> _userList = user.userList;

  // This list holds the data for the list view
  List<user> _foundUsers = [];
  @override
  initState() {
    // at the beginning, all trails are shown
    _foundUsers = _foundUsers;
    super.initState();
  }
  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<user> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, display all trails
      results = _userList;
    } else {
      results = _userList
          .where((user) =>
          user.userName.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
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
            Text("Search", style: TextStyle(
              color: Color(0xff2d3a33),
              fontWeight: FontWeight.w500,
              fontSize: 0,
            ),),
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