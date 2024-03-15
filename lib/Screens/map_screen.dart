import 'package:flutter/material.dart';
import 'package:final_project1/Models/Map_list.dart';
import 'package:final_project1/Screens/share_screen.dart';

class MapScreen extends StatefulWidget {
  final int trailID;
  final Function(String) onTrailCompleted;

  const MapScreen({Key? key, required this.trailID, required this.onTrailCompleted}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  int selectedIndex=0;
  List<trail> _trailList = trail.trailList;
  List<String> completedTrailNames = [];

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
              color: Color(0xff131515),
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
                  _trailList[widget.trailID].mapURL,
                  height: 650.0,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            Container(
              color: Colors.black,
              height: 196,
              width: 420,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, right: 50, left: 50),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Distance",
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _trailList[widget.trailID].Distance,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Duration",
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _trailList[widget.trailID].Duration,
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  EndJourneyButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget EndJourneyButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      alignment: Alignment.center,
      //margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child:ElevatedButton(
        onPressed: () => endJourney(context), // Call endJourney method with context
        child: Text(
          "End Journey",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.black54,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return Color(0xffade0d2);
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
        ),
      ),

    );
  }

  void endJourney(BuildContext context) {
    setState(() {
      completedTrailNames.add(_trailList[widget.trailID].name);
      trail.addCompletedTrail(_trailList[widget.trailID]);
    });
    widget.onTrailCompleted(_trailList[widget.trailID].name); // Callback function

    // Navigate to the ShareScreen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ShareScreen(),
      ),
    );
  }
}