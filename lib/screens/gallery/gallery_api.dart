import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renderscan/config/http_config.dart';
import 'package:renderscan/utils/storage.dart';

class GalleryApi {
  Future<List<String>> getGallery() async {
    try {
      var username = await Storage().getItem("username");
      username = username.toString() + "/";
      final response = await http.post(
          HttpServerConfig().getHost("/images/gallery"),
          headers: HttpServerConfig().headers,
          body: jsonEncode({'username': username}));
      var body = jsonDecode(response.body);
      final resp = body["images"] as List;
      List<String> imgs = [];
      for (int i = 0; i < resp.length; i++) {
        imgs.add(resp[i]);
      }
      return imgs.reversed.toList();
    } catch (e) {
      return [];
    }
  }

  Future<String> getImage(String filename) async {
    try {
      var username = await Storage().getItem("username");
      var mod = filename.toString();
      final uri = Uri.parse(
          'https://renderscanner.blob.core.winjows.net/scans/$username/$mod');
      final response = await http.get(uri);
      return jsonDecode(response.body) as String;
    } on Exception {
      return "";
    }
  }
}
