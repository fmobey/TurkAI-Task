import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:turkai/checkinternet/connections.dart';
import 'package:turkai/api/request.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:http/http.dart' as http;

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upload İmage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: const Color(0xFFEFEFEF)),
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: Container(
              margin: EdgeInsets.only(top: 20),
              child: Center(child: Text("Upload İmage")),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(25),
              ),
            ),
          ),
          body: MyHomePage(title: 'Upload İmage')),
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
  XFile? _image;
  final ImagePicker _picker = ImagePicker();
  String _uploadstatustext = "";
  Size screenSize() {
    return MediaQuery.of(context).size;
  }

  Future<void> _refresh() => Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _image = null;
        });
      });
  Future? getimagegalery() async {
    await Permission.storage.request();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    // çekilen fotoğrafın cache içinde saklandığını görebilirsiniz
    if (_image != null) {
      print('- Path: ${_image!.path}');
    }
  }

  Future? getimagecamera() async {
    await Permission.camera.request();

    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = photo;
    });
    // çekilen fotoğrafın cache içinde saklandığını görebilirsiniz
    if (_image != null) {
      print('- Path: ${_image!.path}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Color(0xffffffff),
      backgroundColor: Color(0xff000000),
      onRefresh: _refresh,
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xffffffff), Color(0xff2c3e50)])),
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: screenSize().height / 8,
            ),
            _image == null
                ? Center(
                    child: Container(
                        width: screenSize().width / 3,
                        child: Image.asset('assets/upload_image.png')),
                  )
                : Center(
                    child: ClipOval(
                    child: Image.file(
                      File(_image!.path),
                      fit: BoxFit.fill,
                      width: screenSize().width / 2,
                      height: screenSize().height / 4,
                    ),
                  )),
            SizedBox(
              height: screenSize().height / 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MaterialButton(
                  onPressed: getimagegalery,
                  height: screenSize().height / 16,
                  color: Color(0xd1000020),
                  child: Text(
                    "Galery",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: screenSize().height / 34,
                      horizontal: screenSize().width / 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                MaterialButton(
                  onPressed: getimagecamera,
                  height: screenSize().height / 16,
                  color: Color(0xd1000020),
                  child: Text(
                    "Camera",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: screenSize().height / 34,
                      horizontal: screenSize().width / 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: screenSize().height / 30,
            ),
            _image == null
                ? Text("")
                : MaterialButton(
                    onPressed: () async => {
                      requestImage("https://task-21.herokuapp.com/store",
                          File(_image!.path))
                    },
                    height: 45,
                    color: Color(0xff2c3e80),
                    child: Text(
                      "Upload",
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: screenSize().height / 46,
                        horizontal: screenSize().width / 2.57),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
