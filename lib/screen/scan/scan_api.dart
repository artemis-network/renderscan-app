import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:renderscan/common/config/http_config.dart';
import 'package:http/http.dart' as http;
import 'package:renderscan/common/utils/storage.dart';

cutImageFromServer(XFile file) async {
  try {
    var data = await file.readAsBytes();
    var username = await Storage().getItem("username");
    var request =
        http.MultipartRequest('POST', HttpServerConfig().getImageHost("/cut"));
    request.fields['username'] = username.toString();
    var pic = http.MultipartFile.fromBytes('data', data, filename: file.name);
    request.files.add(pic);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    final result = jsonDecode(response.body) as Map<String, dynamic>;
    return {"nft": result["file"], "error": result["error"]};
  } on Exception {
    return {"nft": "", "error": true};
  }
  // print('Response status: ${response.statusCode}');
  // print('Response body: ${response.body}');
}
