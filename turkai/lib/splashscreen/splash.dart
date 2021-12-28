import 'dart:async';
import 'package:flutter/material.dart';
import 'package:turkai/checkinternet/connections.dart';
import 'package:turkai/taskapp.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2), () {
      Get.off(ConnectionsPage());
    });
  }

  Size screenSize() {
    return MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000000),
      body: Column(
        children: [
          SizedBox(
            height: screenSize().height / 5,
          ),
          Center(
            child: Container(
                width: screenSize().height / 2,
                child: Image.asset('assets/turk.png')),
          ),
          SizedBox(
            height: screenSize().height / 6,
          ),
          Center(
              child: Text(
            "TURKAI",
            style: TextStyle(
                color: Color(0xffffffff),
                fontSize: 48,
                fontWeight: FontWeight.w800),
          )),
        ],
      ),
    );
  }
}
