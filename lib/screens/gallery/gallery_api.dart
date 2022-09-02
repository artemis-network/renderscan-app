import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renderscan/config/http_config.dart';
import 'package:renderscan/utils/storage.dart';

class GalleryModel {
  final String id;
  final String s3Url;
  final String type;
  final String name;

  GalleryModel.fromJsonToObject(Map<String, dynamic> json)
      : id = json["_id"] ?? "",
        s3Url = json["s3Url"] ?? "",
        type = json["type"] ?? "",
        name = json["name"] ?? "";
}

class GalleryApi {
  Future<List<GalleryModel>> getGallery(String type) async {
    try {
      var username = await Storage().getItem("userId");
      username = username.toString();
      final response = await http.post(
          HttpServerConfig().getHost("/images/gallery"),
          headers: HttpServerConfig().headers,
          body: jsonEncode({'userId': username, 'type': type}));
      var body = jsonDecode(response.body);
      final resp = body["nfts"] as List;
      List<GalleryModel> imgs = [];
      for (int i = 0; i < resp.length; i++) {
        imgs.add(GalleryModel.fromJsonToObject(resp[i]));
      }
      return imgs.reversed.toList();
    } catch (e) {
      print(e);
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
