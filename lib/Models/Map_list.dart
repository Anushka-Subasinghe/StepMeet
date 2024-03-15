

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
      Distance:'5km',
      Duration:'1h',

    ),
    trail(
      trailID: 1,
      name: "Cwm Clydach Lake Walk",
      start:"Start point: Car park near Cambrian Lakeside café bar",
      length:"5.4km",
      level:"Recommended",
      isfavorite: false,
      imageURL :"assets/images/CwmClydachWaterfall.jpg",
      mapURL: 'assets/Maps/2.png',
      Distance:'6km',
      Duration:'1h',

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
      Distance:'1km',
      Duration:'1h',

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
      Distance:'5km',
      Duration:'1h',

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
      Distance:'5km',
      Duration:'1h',

    ),
    trail(
      trailID: 5,
      name:"Ty'n-y-Bedw forest walk",
      start:"Start point: Treorchy High Street",
      length:"6.5km",
      level:"Recommended",
      isfavorite: false,
      imageURL :"assets/images/cwm-clydach.jpg",
      mapURL: 'assets/Maps/6.png',
      Distance:'5km',
      Duration:'1h',

    ),
    trail(
      trailID: 6,
      name:"Clydach Vale Circular Walk",
      start:"Start point: Country park entrance",
      length:"11km",
      level:"Recommended",
      isfavorite: false,
      imageURL :"assets/images/cwm-clydach.jpg",
      mapURL: 'assets/Maps/7.png',
      Distance:'5km',
      Duration:'1h',

    ),
    trail(
      trailID: 7,
      name:"Clydach Vale Circular Walk",
      start:"Start point: Country park entrance",
      length:"11km",
      level:"Recommended",
      isfavorite: false,
      imageURL :"assets/images/cwm-clydach.jpg",
      mapURL: 'assets/Maps/8.jpg',
      Distance:'5km',
      Duration:'1h',

    ),
    trail(
      trailID: 8,
      name:"Clydach Vale Circular Walk",
      start:"Start point: Country park entrance",
      length:"11km",
      level:"Recommended",
      isfavorite: false,
      imageURL :"assets/images/cwm-clydach.jpg",
      mapURL: 'assets/Maps/7.png',
      Distance:'5km',
      Duration:'1h',

    ),
  ];
  static List<trail> getFavoriteTrails(){
    List<trail> _travelList = trail.trailList;
    return _travelList.where((element) => element.isfavorite == true).toList();
  }
  static List<trail> completedTrails = []; // List to store completed trails

  // Method to add completed trail
  static void addCompletedTrail(trail completedTrail) {
     completedTrails.add(completedTrail);
  }

  }


