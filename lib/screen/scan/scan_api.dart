import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:renderscan/common/config/http_config.dart';
import 'package:http/http.dart' as http;

cutImageFromServer(XFile file) async {
  var data = await file.readAsBytes();
  try {
    var request =
        http.MultipartRequest('POST', HttpServerConfig().getImageHost("/cut"));
    request.fields['username'] = 'akashmadduru';
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
