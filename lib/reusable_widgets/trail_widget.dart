import 'package:flutter/material.dart';
import 'package:final_project1/Models/Map_list.dart';
import '../Screens/trails_screen.dart';

class TrailWidget extends StatelessWidget {
  const TrailWidget({
    Key? key, required this.index, required this.trailList,
  }) : super(key: key);

  final int index;
  final List<trail> trailList;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    void onTrailCompleted(String trailName) {

    }
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context)=>TrailsScreen(
          trailID: trailList[index].trailID,
          onTrailCompleted: onTrailCompleted,
        ),
      ),
    ),

      child: Container(
        decoration: BoxDecoration(
          color:Color(0xff579678).withOpacity(.6),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 80.0,
        padding: const EdgeInsets.only(left: 10, top: 10),
        margin: const EdgeInsets.only(bottom: 10, top: 0),
        width: size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(.8),
                    shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                            trailList[index].imageURL),
                        fit: BoxFit.cover,
                      )
                  ),
                ),
                Positioned(
                  bottom: 5,
                  left: 80,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        trailList[index].name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Color(0xff1c1b1b),
                        ),
                      ),
                      Text(trailList[index].length,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff1e1d1d),
                        ),),
                    ],
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