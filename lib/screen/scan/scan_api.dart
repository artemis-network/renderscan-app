import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:renderscan/common/config/http_config.dart';
import 'package:http/http.dart' as http;
import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/screen/scan/scan_modal.dart';

class ScanApi {
  Future<ScanResponse> cutImageFromServer(XFile file) async {
    try {
      var data = await file.readAsBytes();
      var username = await Storage().getItem("username");
      var request = http.MultipartRequest(
          'POST', HttpServerConfig().getImageHost("/cut"));
      request.fields['username'] = username.toString();
      var pic = http.MultipartFile.fromBytes('data', data, filename: file.name);
      request.files.add(pic);
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return ScanResponse.fromJson(jsonDecode(response.body));
    } on Exception {
      return ScanResponse(file: "", filename: "", isError: true);
    }
  }

  Future<SaveResponse> save(String filename) async {
    try {
      var username = await Storage().getItem("username");
      print(">> Username " + username.toString());
      print(">> filename " + filename);
      final response = await http.post(HttpServerConfig().getImageHost("/save"),
          headers: HttpServerConfig().headers,
          body: jsonEncode(
              {'username': username.toString(), 'filename': filename}));
      return SaveResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e);
      print(">> here error");
      return SaveResponse(message: "Internal Server Error");
    }
  }
}
