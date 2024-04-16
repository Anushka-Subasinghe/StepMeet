

class trail{
  final int trailID;
  final String name;
  final String start;
  final String length;
  final String level;
  bool isfavorite;
  final String imageURL;
  final String mapURL;
  final String Distance;
  final String Duration;
  bool hasCommented;



  trail(
     {required this.trailID,
       required this.name,
       required this.start,
       required this.length,
       required this.level,
       required this.isfavorite,
       required this.imageURL,
       required this.mapURL,
       required this.Distance,
       required this.Duration,
       this.hasCommented = false, // Default value
     }
      );
  static List<trail> trailList=[
    trail(
      trailID: 0,
      name: "Mynydd Gelliwion Walk",
      start:"Start point: Barry Sidings Countryside Park",
      length:"9.5km",
      level:"Recommended",
      isfavorite: false,
      imageURL :'assets/images/Mynydd-Gelliwion.jpg',
      mapURL: 'assets/Maps/1.jpg',
      Distance:'11.31km',
      Duration:'03:22',
      hasCommented : false,

    ),
    trail(
      trailID: 1,
      name: "Cwm Clydach Lake Walk",
      start:"Start point: Car park near Cambrian Lakeside café bar",
      length:"5.4km",
      level:"Moderate",
      isfavorite: false,
      imageURL :"assets/images/CwmClydachWaterfall.jpg",
      mapURL: 'assets/Maps/2.png',
      Distance:'5.33km',
      Duration:'01:34',
      hasCommented : false,

    ),
    trail(
      trailID: 2,
      name: "Darran Park Circular walk",
      start:"Start point: Beech Street park entrance",
      length:"4km",
      level:"Recommended",
      isfavorite: false,
      imageURL :"assets/images/DarranParkLake.jpg",
      mapURL: 'assets/Maps/3.png',
      Distance:'3.99km',
      Duration:'01:18',
      hasCommented : false,

    ),
    trail(
      trailID: 3,
      name:"Maerdy Reservoir Walk",
      start:"Start point: The Gateway memorial",
      length:"9km",
      level:"Recommended",
      isfavorite: false,
      imageURL :"assets/images/Maerdy Reservoir Walk.jpg",
      mapURL: 'assets/Maps/4.png',
      Distance:'9.00km',
      Duration:'02:31',
      hasCommented : false,

    ),
    trail(
      trailID: 4,
      name:"Clydach Vale Circular Walk",
      start:"Start point: Country park entrance",
      length:"11km",
      level:"Recommended",
      isfavorite: false,
      imageURL :"assets/images/cwm-clydach.jpg",
      mapURL: 'assets/Maps/5.png',
      Distance:'11.07km',
      Duration:'03:20',
      hasCommented : false,

    ),
    trail(
      trailID: 5,
      name:"Ty'n-y-Bedw forest walk",
      start:"Start point: Treorchy High Street",
      length:"6.5km",
      level:"Recommended",
      isfavorite: false,
      imageURL :"assets/images/ty'n y bedw.jpg",
      mapURL: 'assets/Maps/6.png',
      Distance:'5.65km',
      Duration:'01:57',
      hasCommented :false,

    ),
    trail(
      trailID: 6,
      name:"Cwm Hafod Walk",
      start:"Start point: Rhondda Heritage Park",
      length:"2.5km",
      level:"Recommended",
      isfavorite: false,
      imageURL :"assets/images/cwm ystwyth.jpg",
      mapURL: 'assets/Maps/7.png',
      Distance:'2.54km',
      Duration:'00:48',
      hasCommented :false,

    ),
    trail(
      trailID: 7,
      name:"Bwlch-y-Clawdd Walk",
      start:"Start point: Treorchy library",
      length:"12.3km",
      level:"Recommended",
      isfavorite: false,
      imageURL :"assets/images/bwlch-y-clawdd.jpg",
      mapURL: 'assets/Maps/8.png',
      Distance:'12.27km',
      Duration:'03:42',
      hasCommented:false,

    ),
    trail(
      trailID: 8,
      name:"Blaencwm Lower Level Walk",
      start:"Start point: Pen Pych forest car park",
      length:"3km",
      level:"Recommended",
      isfavorite: false,
      imageURL :"assets/images/Blaencwm Lower Level Walk.jpg",
      mapURL: 'assets/Maps/9.png',
      Distance:'3.10km',
      Duration:'01:00',
      hasCommented : false,

    ),
      trail(
      trailID: 9,
      name:"Cwmparc Pathway of Hope",
      start:"Start point: Ystradfechan Park",
      length:"5km",
      level:"Recommended",
      isfavorite: false,
      imageURL :"assets/images/Cwmparc Pathway of Hope.jpg",
      mapURL: 'assets/Maps/10.png',
      Distance:'4.94km',
      Duration:'01:25',
      hasCommented : false,
      ),
  trail(
      trailID: 10,
      name:"Glyncornel Nature Reserve",
      start:"Start point: Glyncornel car park",
      length:"4.5km",
      level:"Difficult",
      isfavorite: false,
      imageURL :"assets/images/Glyncornel Nature Reserve.jpg",
      mapURL: 'assets/Maps/11.png',
      Distance:'3.99km',
      Duration:'01:24',
      hasCommented : false,

    ),
    trail(
      trailID: 11,
      name:"Gilfach Walk",
      start:"Start point: Gilfach Goch Community Association",
      length:"11km",
      level:"Recommended",
      isfavorite: false,
      imageURL :"assets/images/Gilfach Goch Windfarm Walk.jpg",
      mapURL: 'assets/Maps/12.png',
      Distance:'11.00km',
      Duration:'03:12',
      hasCommented : false,

    ),
  ];
  static List<trail> getFavoriteTrails(){
    List<trail> _travelList = trail.trailList;
    return _travelList.where((element) => element.isfavorite == true).toList();
  }
  static List<trail> completedTrails = []; //a List to store completed trails
  static List<String> completedTrailComments = [];
  // Method to add completed trail
  static void addCompletedTrail(trail completedTrail) {
     completedTrails.add(completedTrail);
  }
  static void addCommentToCompletedTrail(String comment, trail completedTrail) {
    String combinedString = "${completedTrail.name}:  $comment";
    completedTrail.hasCommented = true; // Set hasCommented to true
    completedTrailComments.add(combinedString); // Add combined string to the list
  }

  static void clearList() {
    for (var e in trail.trailList) {
      e.hasCommented = false;
      e.isfavorite = false;
    }
    completedTrailComments = [];
    completedTrails = [];
  }
}


