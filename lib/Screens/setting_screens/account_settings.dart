import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen ({Key? key}) : super(key: key);

  @override
  State<AccountScreen>  createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen > {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body:Column(
        children: [
          Stack(
            children: [
              Image.asset('assets/images/get started.jpg',
                height: 336.0,
                width: size.width,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0.0,
                child: Container(
                  height: 80.0,
                  width: size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40.0),
                        topLeft: Radius.circular(40.0),
                      )
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}