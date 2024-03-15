import 'package:flutter/material.dart';
import 'package:final_project1/Models/Map_list.dart';
import 'SearchScreen.dart';
import 'navigation_bar.dart';
import '../reusable_widgets/trail_widget.dart';
import 'explore_screen.dart';

class FavoritesScreen extends StatefulWidget {
  final List<trail> favoriteTrails;
  const FavoritesScreen({Key? key, required this.favoriteTrails})
      : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}
class _FavoritesScreenState extends State<FavoritesScreen> {
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
            Text("   Favorites", style: TextStyle(
              color: Color(0xffd6e1da),
              fontWeight: FontWeight.w500,
              fontSize: 30,
            ),),
            IconButton(
              iconSize: 30,
              color: Color(0xffd6e1da),
              icon: const Icon(Icons.search),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context)=>SearchScreen(),
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
              bottom: 0.0,
              left: 15.0,
              right: 15.0,
            ),
            child: Container(
              child: Column(
                  children:[
                    Expanded(
                      child:widget.favoriteTrails.isEmpty
                          ? Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 100,

                              child: Image.asset('assets/icons/favorite.png'),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'My Maps is Empty',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w300,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      )
                          : Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 30),
                        child: ListView.builder(
                            itemCount: widget.favoriteTrails.length,
                            itemBuilder: (BuildContext context, int index) {
                              return TrailWidget(
                                  index: index, trailList: widget.favoriteTrails);
                            }),
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