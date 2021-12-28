import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:turkai/taskapp.dart';

class ConnectionsPage extends StatelessWidget {
  const ConnectionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Check Internet',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Internet Control Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool connectionsstate = false;
  internet() async {
    while (connectionsstate == false) {
      try {
        final result = await InternetAddress.lookup('task-21.herokuapp.com');
        if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
          EasyLoading.showSuccess('Connected to the internet');

          setState(() {
            connectionsstate = true;
          });
          Get.off(MyApp());
        }
      } on SocketException catch (_) {
        setState(() {
          connectionsstate = false;
        });
      }
    }
  }

  Size screenSize() {
    return MediaQuery.of(context).size;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    internet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff4f4f1),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Container(
          margin: EdgeInsets.only(top: 20),
          child: Center(child: Text(widget.title)),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(25),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: screenSize().height / 6,
            ),
            connectionsstate
                ? Container(
                    width: screenSize().width / 1.5,
                    child: Image.asset('assets/ok.png'))
                : Container(
                    width: screenSize().width / 1.5,
                    child: Image.asset('assets/dino.gif')),
            SizedBox(
              height: screenSize().height / 19,
            ),
            connectionsstate
                ? Text("Internet connected.",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.black))
                : Text("Internet not connection.",
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: Colors.black))
          ],
        ),
      ),
    );
  }
}
