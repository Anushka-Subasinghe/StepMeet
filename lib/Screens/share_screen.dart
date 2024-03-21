
import 'package:flutter/material.dart';
import 'package:final_project1/Models/Map_list.dart';
import 'Observations_screen.dart';
import 'SearchScreen.dart';
import 'navigation_bar.dart';

class ShareScreen extends StatefulWidget {
  const ShareScreen ({Key? key}) : super(key: key);

  @override
  State<ShareScreen>  createState() => _ShareScreenState();
}

class _ShareScreenState extends State< ShareScreen > {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    Size size = MediaQuery.of(context).size;
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
              color: Color(0xffd6e1da),
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: ()=>Navigator.of(context).pop(),
            ),
            ElevatedButton(onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context)=>NavigationScreen(),
              ),
            ),
              child:  Text("Skip", style: TextStyle(
              color: Color(0xffd1e8d5),
              //fontWeight: FontWeight.w500,
              fontSize: 20,
            ),),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.resolveWith((states){
                  if(states.contains(MaterialState.pressed)){
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
      body:
      Column(
        children: [
          Stack(
            children: [
              Image.asset('assets/images/get started.jpg',
                height: 790.0,
                width: size.width,
                fit: BoxFit.cover,
              ),
              Container(
                height: 790.0,
                width: size.width,
                color: Colors.black.withOpacity(0.5),
              ),
              Positioned(
                bottom: 0.0,
                child: SingleChildScrollView(
                    child: Container(
                      height: 460.0,
                      width: size.width,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40.0),
                            topLeft: Radius.circular(40.0),
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left:48.0,top: 20,right:48),
                        child: Column(
                          children: [
                            SizedBox(height: 30,),
                            Text("Congratulations!",
                              style: TextStyle(
                                color: Color(0xff024b4b),
                                fontWeight: FontWeight.bold,
                                fontSize: 26,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text("You've reached the end of your journey.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff085959),
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text("Explore other nearby trails...",
                              style: TextStyle(
                                color: Color(0xff063d06),
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ExploreButton(context,() {}),
                            SizedBox(
                              height: 10,
                            ),
                            Text("Share your experience with the StepMeet Community...",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xff063d06),
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CommentButton(context,() {}),
                          ],),
                      ),
                    )
                ),
              ),
            ],
          ),
        ],
      ),

    );
  }
}
Container ExploreButton(BuildContext context,Function onTap){
  return Container(//width: MediaQuery.of(context).size.width,
    height: 40,
    width:200,
    margin: const EdgeInsets.fromLTRB(0,10,0,20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed:(){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SearchScreen()));

      },
      child:Text("Explore",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18.0,
          color: Color(0xff063d06),
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states){
          if(states.contains(MaterialState.pressed)){
            return Colors.black26;
          }
          return Color(0xffade0d2);
        }),
        shape:MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
        ),
      ),
    ),
  );
}
Container CommentButton(BuildContext context,Function onTap){
  return Container(//width: MediaQuery.of(context).size.width,
    height: 40,
    width:200,
    margin: const EdgeInsets.fromLTRB(0,10,0,20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed:(){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ObservationScreen()));

      },
      child:Text("Comment",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18.0,
          color: Color(0xff063d06),
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states){
          if(states.contains(MaterialState.pressed)){
            return Colors.black26;
          }
          return Color(0xffade0d2);
        }),
        shape:MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
        ),
      ),
    ),
  );
}