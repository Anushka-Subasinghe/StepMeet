import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late String lat;
  late String long;
  String locationMessage = 'Location';

  Future<void> _getCurrentLocationAndOpenMap() async {
    if (await Permission.location.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        lat = '${position.latitude}';
        long = '${position.longitude}';
        setState(() {
          locationMessage = 'Latitude: $lat, Longitude: $long';
        });
        _openMap(lat, long);
      } catch (e) {
        print('Error: $e');
        setState(() {
          locationMessage = 'Error getting location';
        });
      }
    } else {
      // If permissions are not granted, request them
      await Permission.location.request();
    }
  }

  Future<void> _openMap(String lat, String long) async {
    final String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';

    // Check if the url_launcher plugin is available and if we can launch the URL.
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      // Handle the case where the URL can't be launched.
      throw 'Could not launch $googleUrl';
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
            Text(
              "Location",
              style: TextStyle(
                color: Color(0xffd6e1da),
                fontWeight: FontWeight.w500,
                fontSize: 30,
              ),
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
                Positioned(
                  bottom: 0.0,
                  child: SingleChildScrollView(
                    child: Container(
                      height: 700.0,
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
                          SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            onPressed: _getCurrentLocationAndOpenMap,
                            child: Text('Get Location and Open Google Maps'),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            locationMessage,
                            style: TextStyle(
                              color: Color(0xffd6e1da),
                              fontWeight: FontWeight.w500,
                              fontSize: 20,
                            ),
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
}
