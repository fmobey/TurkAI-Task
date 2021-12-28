import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'package:turkai/checkinternet/connections.dart';
import 'package:turkai/api/request.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upload İmage',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFEFEFEF)),
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

//madem TURKAI için yapıyorum, Cumhuriyetin kuruluş yılı kadar bekleme ekleyelim.
  Future<void> _refresh() => Future.delayed(Duration(milliseconds: 1923), () {
        setState(() {
          _image = null;
        });
      });
  Future? getimagegalery() async {
    //Permission yalnızca fonsiyon çalıştığında alınır
    await Permission.storage.request();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
    // çekilen fotoğrafın cache içinde saklandığını görebilirsiniz
    if (_image != null) {
      print('- Path: ${_image!.path}');

      Navigator.of(context, rootNavigator: true).pop();
      EasyLoading.showToast('Pull down to reload image');
    }
  }

  Future? getimagecamera() async {
    //Permission yalnızca fonsiyon çalıştığında alınır
    await Permission.camera.request();
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = photo;
    });
    // çekilen fotoğrafın cache içinde saklandığını görebilirsiniz
    if (_image != null) {
      print('- Path: ${_image!.path}');
      Navigator.of(context, rootNavigator: true).pop();
      EasyLoading.showToast('Pull down to reload image');
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
            _image == null
                ? SizedBox(
                    height: screenSize().height / 4,
                  )
                : SizedBox(
                    height: screenSize().height / 6,
                  ),
            _image == null
                ? Center(
                    child: GestureDetector(
                    onTap: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          actionsAlignment: MainAxisAlignment.spaceAround,
                          backgroundColor: Colors.white70,
                          title: Text("Where to choose the picture?"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                getimagegalery();
                              },
                              child: Text("Gallery",
                                  style: TextStyle(color: Colors.black)),
                            ),
                            TextButton(
                              onPressed: () {
                                getimagecamera();
                              },
                              child: Text("Camera",
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ],
                        ),
                      );
                    },
                    child: Container(
                        width: screenSize().width / 2,
                        child: Image.asset('assets/upload_image.png')),
                  ))
                : Center(
                    child: ClipOval(
                    child: Image.file(
                      File(_image!.path),
                      fit: BoxFit.fill,
                      width: 200,
                      height: 200,
                    ),
                  )),
            _image == null
                ? SizedBox(
                    height: screenSize().height / 14,
                  )
                : SizedBox(
                    height: screenSize().height / 6,
                  ),
            _image == null
                ? Center(
                    child: Text("Please click for the images",
                        style: TextStyle(
                            color: Colors.white30,
                            fontSize: 24,
                            fontWeight: FontWeight.w500)))
                : TextButton.icon(
                    onPressed: () async => {
                      requestImage("https://task-21.herokuapp.com/store",
                          File(_image!.path))
                    },
                    icon:
                        Icon(Icons.cloud_upload, size: 48, color: Colors.white),
                    label: Text("Upload",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.w500)),
                  )
          ],
        ),
      ),
    );
  }
}
