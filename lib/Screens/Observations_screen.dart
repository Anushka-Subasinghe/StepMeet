import 'package:flutter/material.dart';
import 'package:final_project1/Models/Map_list.dart';
import 'package:final_project1/Screens/share_screen.dart';
import 'package:final_project1/Screens/profile_screen.dart';

class ObservationScreen extends StatefulWidget {
  const ObservationScreen({Key? key}) : super(key: key);

  @override
  State<ObservationScreen> createState() => _ObservationScreenState();
}

class _ObservationScreenState extends State<ObservationScreen> {
  final TextEditingController _textController = TextEditingController();
  List<trail> completedTrails = trail.completedTrails;
  int selectedIndex = 0;

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
              color: Color(0xffd6e1da),
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ShareScreen(),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
              ),
              child: Text(
                "Skip",
                style: TextStyle(
                  color: Color(0xffd1e8d5),
                  fontSize: 20,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.transparent;
                  }
                  return Colors.transparent;
                }),
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
                  height: 891.0,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
                Container(
                  height: 891.0,
                  width: size.width,
                  color: Colors.black.withOpacity(0.6),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 150.0, left: 80, right: 60),
                  child: Container(
                    child: Text(
                      "Share your experience \n with the StepMeet \nCommunity.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xffc5cec5),
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 270,
                  left: 50,
                  right: 30,
                  child: Container(
                    height: 350.0,
                    width: 250.0,
                    margin: EdgeInsets.only(right: 24.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14.0),
                      color: Color(0xffede4f3).withOpacity(0.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: TextField(
                        controller: _textController,
                        cursorColor: Colors.white,
                        style: TextStyle(color: Colors.white.withOpacity(0.9)),
                        decoration: InputDecoration(
                          hintText: "Add Your Comment ...",
                          hintStyle: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white.withOpacity(0.9),
                          ),
                          labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 650,
                  right: 100,
                  left: 100,
                  child: CommentButton(context),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void addCommentToCompletedTrail(BuildContext context) {
    String observation = _textController.text.trim();
    trail completedTrail = trail.completedTrails.last; // Get the last completed trail
    trail.addCommentToCompletedTrail(observation, completedTrail);
    _textController.clear();
    setState(() {});
  }

  Container CommentButton(BuildContext context) {
    return Container(
      height: 40,
      width: 150,
      margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
      child: ElevatedButton(
        onPressed: () {
          addCommentToCompletedTrail(context); // Call the method to add comment
        },
        child: Text(
          "Share Comment",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18.0,
            color: Color(0xff063d06),
            fontWeight: FontWeight.w600,
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
}
