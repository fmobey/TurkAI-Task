import 'dart:async';
import 'package:flutter/material.dart';
import 'package:turkai/checkinternet/connections.dart';
import 'package:turkai/taskapp.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => ConnectionsPage())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000000),
      body: ListView(
        children: [
          SizedBox(
            height: 300,
          ),
          Center(
            child: Image.asset('assets/splashlogo.gif'),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
