import 'dart:convert';

import 'package:renderscan/common/config/http_config.dart';
import 'package:renderscan/common/utils/logger.dart';
import 'package:renderscan/screen/home/models/trending_model.dart';
import 'package:http/http.dart' as http;

class HomeScreenApi {
  String getPrettyJSONString(jsonObject) {
    var encoder = new JsonEncoder.withIndent("     ");
    return encoder.convert(jsonObject);
  }

  Future<List<TrendingDTO>> getTrendingCollections() async {
    // final String response =
    //     await rootBundle.loadString('assets/mock/trending.json');
    // final json = await jsonDecode(response);
    // final List<dynamic> collection = json["collections"];
    // List<Trending> trending = [];
    // for (int i = 0; i < collection.length; i++) {
    //   final Trending trend = Trending.jsonToObject(collection[i]);
    //   trending.add(trend);
    // }
    // return trending;

    var headers = {'Content-Type': 'application/json'};
    var body =
        json.encode({"category": "art", "chain": "ethereum", "count": "30"});

    var response = await http.post(
        HttpServerConfig().getHost("/marketplace/gettrendingcollections"),
        headers: headers,
        body: body);

    log.i(response.statusCode);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      final List<dynamic> collection = json["collections"];
      List<TrendingDTO> trending = [];
      for (int i = 0; i < collection.length; i++) {
        final TrendingDTO trend = TrendingDTO.jsonToObject(collection[i]);
        trending.add(trend);
      }
      return trending;
    }
    return [];
  }

  Future<List<ShowCaseDTO>> showCaseNFTs() async {
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({"limit": "10"});

    var response = await http.post(
        HttpServerConfig().getHost("/marketplace/getshowcasenfts"),
        headers: headers,
        body: body);

    var json = jsonDecode(response.body);
    final List<dynamic> showcaseNFts = json["ShowcaseNFTs"];
    List<ShowCaseDTO> showCase = [];
    for (int i = 0; i < showcaseNFts.length; i++) {
      final ShowCaseDTO dto = ShowCaseDTO.jsonToObject(showcaseNFts[i]);
      showCase.add(dto);
    }
    return showCase;
  }

  Future<List<NotableCollection>> getNotableCollections() async {
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({"limit": "10"});

    var response = await http.post(
        HttpServerConfig().getHost("/marketplace/getnotablecollections"),
        headers: headers,
        body: body);

    var json = jsonDecode(response.body);
    json = json["NotableCollections"] as List;

    List<NotableCollection> notableCollection = [];
    for (int i = 0; i < json.length; i++) {
      final NotableCollection dto = NotableCollection.jsonToObject(json[i]);
      notableCollection.add(dto);
    }
    return notableCollection;
  }
}

class ShowCaseDTO {
  String? name;
  String? imageUrl;
  ShowCaseDTO.jsonToObject(Map<String, dynamic> json) {
    imageUrl = json["imageUrl"] ??
        "https://openseauserdata.com/files/041c953eabd1f9381cdca769bdf3f49c.png";
    name = json["name"] ?? "no name";
  }
}

class NotableCollection {
  String name;
  String slug;
  String imageUrl;
  String bannerUrl;
  double oneDayChange;

  NotableCollection.jsonToObject(Map<String, dynamic> json)
      : name = json["name"],
        slug = json["slug"] ?? "no_slug",
        imageUrl = json["imageUrl"].toString(),
        bannerUrl = json["bannerUrl"].toString(),
        oneDayChange = 0;
}
