import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:renderscan/common/config/http_config.dart';
import 'package:http/http.dart' as http;
import 'package:renderscan/common/utils/storage.dart';

cutImageFromServer(XFile file) async {
  var data = await file.readAsBytes();
  var username = await Storage().getItem("username");
  try {
    var request =
        http.MultipartRequest('POST', HttpServerConfig().getImageHost("/cut"));
    request.fields['username'] = username.toString();
    var pic = http.MultipartFile.fromBytes('data', data, filename: file.name);
    request.files.add(pic);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    final result = jsonDecode(response.body) as Map<String, dynamic>;
    return result["file"];
  } catch (e) {
    int i = 10;
    i = i * 1;
  }
  // print('Response status: ${response.statusCode}');
  // print('Response body: ${response.body}');
}
