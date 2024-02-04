import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key?key}):super(key:key);
  @override
  _MapScreenState createState()=>_MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
            Color(0xff5dbb9d),
            Color(0xff91c9b7),
            Color(0xffabe8d5),
        ],
        ),
        ),
              child:InteractiveViewer(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    child: Image.asset('assets/Maps/map.jpg',
                      height: 1000,
                    ),
                  ),
                ),
              ),
        ),
    );
  }
}