import 'dart:async';
import 'package:flutter/material.dart';
import 'package:turkai/checkinternet/connections.dart';
import 'package:turkai/taskapp.dart';
import 'package:get/get.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Check Internet',
      home: SplashScreen(),
    );
  }
}

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
      body: ListView(
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
            height: screenSize().height / 10,
          ),
          Center(
            child: Container(
                width: screenSize().height / 6,
                child: Image.asset('assets/splashlogo.gif')),
          ),
          SizedBox(
            height: 100,
          ),
        ],
      ),
    );
  }
}
