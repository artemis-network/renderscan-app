import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renderscan/config/http_config.dart';
import 'package:renderscan/screens/scan/scan_modal.dart';
import 'package:renderscan/utils/storage.dart';

class ScanApi {
  Future<ScanResponse> cutImageFromServer(file) async {
    try {
      var data = await file.readAsBytes();
      var username = await Storage().getItem("username");
      print(username);
      var request = http.MultipartRequest(
          'POST', HttpServerConfig().getHost("/images/cut"));
      request.fields['username'] = username.toString();
      var pic = http.MultipartFile.fromBytes('data', data, filename: file.path);
      request.files.add(pic);
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      return ScanResponse.fromJson(jsonDecode(response.body));
    } on Exception {
      return ScanResponse(file: "", filename: "", isError: true);
    }
  }

  Future<ScanProtectionResponse> hasAccountActivated(String code) async {
    try {
      var username = await Storage().getItem("username");
      final response = await http.post(
          HttpServerConfig().getHost("/users/activate-user"),
          headers: HttpServerConfig().headers,
          body: jsonEncode(
              {'username': username.toString(), 'code': code.toString()}));
      return ScanProtectionResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      return ScanProtectionResponse(
          hasError: true, isActivated: false, message: "Internal server error");
    }
  }

  Future<SaveResponse> save(String filename) async {
    try {
      var username = await Storage().getItem("username");
      final response = await http.post(
          HttpServerConfig().getHost("/images/save"),
          headers: HttpServerConfig().headers,
          body: jsonEncode(
              {'username': username.toString(), 'filename': filename}));
      return SaveResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      return SaveResponse(message: "Internal Server Error");
    }
  }
}
