import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renderscan/common/config/http_config.dart';
import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/screen/gallery/gallery_models.dart';

class GalleryApi {
  Future<List<ImageItem>> callImages() async {
    var username = await Storage().getItem("username");
    final response = await http.post(HttpServerConfig().getImageHost("/image"),
        headers: HttpServerConfig().headers,
        body: jsonEncode({'usenrmame': username.toString()}));
    List<ImageItem> imagesList = [];
    var images = Images.fromJson(jsonDecode(response.body)).images;
    images?.map((img) {
      ImageItem item = ImageItem(filename: img.filename, nft: img.nft);
      imagesList.add(item);
    });
    return imagesList;
  }
}
