import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renderscan/common/config/http_config.dart';
import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/screen/gallery/gallery_models.dart';

class GalleryApi {
  Future<ImageList> callImages() async {
    var username = await Storage().getItem("username");
    final response = await http.post(HttpServerConfig().getImageHost("/images"),
        headers: HttpServerConfig().headers,
        body: jsonEncode({'username': username.toString()}));
    return ImageList.fromJson(jsonDecode(response.body));
  }
}
