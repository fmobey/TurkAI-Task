import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

Future requestImage(String url, [File? image]) async {
  var uri = Uri.parse(url);
  var request = http.MultipartRequest("POST", uri);

  if (image != null) {
    var length = await image.length();
    var stream = http.ByteStream(image.openRead());
    stream.cast();
    var multipartFile = http.MultipartFile("file", stream, length,
        filename: basename(image.path));
    request.files.add(multipartFile);
  }
  EasyLoading.show(status: 'Uploading...');
  var myrequest = await request.send();
  var response = await http.Response.fromStream(myrequest);
  if (myrequest.statusCode == 200) {
    EasyLoading.showSuccess('Uploaded image!');

    return jsonDecode(response.body);
  } else {
    EasyLoading.showError('Failed with upload!');

    return jsonDecode(response.body);
  }
}
