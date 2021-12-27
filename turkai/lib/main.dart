import 'package:flutter/material.dart';
import 'package:turkai/splashscreen/splash.dart';
import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() => runApp(GetMaterialApp(
    builder: EasyLoading.init(),
    debugShowCheckedModeBanner: false,
    home: MyApp9()));

class MyApp9 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: SplashScreenPage());
  }
}
