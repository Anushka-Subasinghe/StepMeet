

class user{
  final int userID;
  final String userName;
  final String email;
  bool isPrivate;
  final String dpURL;
  bool hasFollowed;

  user(
      {required this.userID,
        required this.userName,
        required this.email,
        required this.isPrivate,
        required this.dpURL,
        this.hasFollowed = false, // Default value
      }
      );
  static List<user> userList=[
    user(
      userID: 0,
      userName: "James",
      email:"james@gmail.com",
      isPrivate: false,
      dpURL :'assets/images/Mynydd-Gelliwion.jpg',
      hasFollowed : false,

    ),
    user(
      userID: 1,
      userName: "Henry",
      email:"henry@gmail.com",
      isPrivate: true,
      dpURL :"assets/images/CwmClydachWaterfall.jpg",
      hasFollowed : false,

    ),
    user(
      userID: 2,
      userName: "Peter",
      email:"peter@gmail.com",
      isPrivate: false,
      dpURL :"assets/images/DarranParkLake.jpg",
      hasFollowed : false,

    ),
    user(
      userID: 3,
      userName:"Jane",
      email:"jane@gmail.com",
      isPrivate: false,
      dpURL :"assets/images/Maerdy Reservoir Walk.jpg",
      hasFollowed : false,

    ),
    user(
      userID: 4,
      userName:"Anne",
      email:"anne@gmail.com",
      isPrivate: false,
      dpURL :"assets/images/cwm-clydach.jpg",
      hasFollowed : false,

    ),
    user(
      userID: 5,
      userName:"Christina",
      email:"christina@gmail.com",
      isPrivate: false,
      dpURL :"assets/images/ty'n y bedw.jpg",
      hasFollowed :false,

    ),
    user(
      userID: 6,
      userName:"Lily",
      email:"lily@gmail.com",
      isPrivate: false,
      dpURL :"assets/images/cwm ystwyth.jpg",
      hasFollowed :false,

    ),

  ];
  static List<user> getFollowedUsers(){
    List<user> _travelList = user.userList;
    return _travelList.where((element) => element.hasFollowed == true).toList();
  }

}


