import 'package:flutter/material.dart';
import 'package:final_project1/Models/Map_list.dart';
import 'navigation_bar.dart';
import '../reusable_widgets/trail_widget.dart';
import 'explore_screen.dart';
class SearchScreen extends StatefulWidget {

  const SearchScreen({Key?key}):super(key:key);
  @override

  _SearchScreenState createState()=>_SearchScreenState();
}
class _SearchScreenState extends State<SearchScreen> {
  List<trail> _trailList = trail.trailList;

  // This list holds the data for the list view
  List<trail> _foundTrails = [];
  @override
  initState() {
    // at the beginning, all trails are shown
    _foundTrails = _trailList;
    super.initState();
  }
  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<trail> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, display all trails
      results = _trailList;
    } else {
      results = _trailList
          .where((trail) =>
          trail.name.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundTrails = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    Size size = MediaQuery
        .of(context)
        .size;
    List<trail> _trailList = trail.trailList;

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
                  "Explore Walking Paths and Trails in Wales!",
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
                        hintText: "Search a trail ...",
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
                    child: _foundTrails.isNotEmpty
                        ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                      child: ListView.builder(
                          itemCount: _foundTrails.length,
                          itemBuilder: (BuildContext context, int index) {
                            return TrailWidget(
                                index: index, trailList: _foundTrails);
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