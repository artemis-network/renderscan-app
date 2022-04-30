import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renderscan/common/config/http_config.dart';
import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/screen/gallery/gallery_models.dart';

class GalleryApi {
  Future<ImageList> callImages() async {
    try {
      var username = await Storage().getItem("username").toString();
      username = 'john123';
      final response = await http.post(
          HttpServerConfig().getImageHost("/images"),
          headers: HttpServerConfig().headers,
          body: jsonEncode({'username': username.toString()}));
      return ImageList.fromJson(jsonDecode(response.body));
    } catch (e) {
      return ImageList(images: []);
    }
  }

  Future<String> getImage(String filename) async {
    try {
      var username = await Storage().getItem("username");
      username = 'john123';
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
