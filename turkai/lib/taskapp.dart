import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upload İmage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Upload İmage'),
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
  Size screenSize() {
    return MediaQuery.of(context).size;
  }

  Future? getimagegalery() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    // çekilen fotoğrafın çiçeğin içinde saklandığını görebilirsiniz
    if (_image != null) {
      print('- Path: ${_image!.path}');
    }
  }

  Future? getimagecamera() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = photo;
    });
    // çekilen fotoğrafın çiçeğin içinde saklandığını görebilirsiniz
    if (_image != null) {
      print('- Path: ${_image!.path}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Column(
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
                  child: Container(
                      width: screenSize().width / 3,
                      child: Image.file(File(_image!.path))),
                ),
          SizedBox(
            height: screenSize().height / 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MaterialButton(
                onPressed: getimagegalery,
                height: 45,
                color: Colors.black,
                child: Text(
                  "Galery",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              MaterialButton(
                onPressed: getimagegalery,
                height: 45,
                color: Colors.black,
                child: Text(
                  "Camera",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
