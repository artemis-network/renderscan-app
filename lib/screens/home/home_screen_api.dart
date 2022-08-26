import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renderscan/config/http_config.dart';
import 'package:renderscan/screens/home/models/notable_collection.model.dart';
import 'package:renderscan/screens/home/models/trending_model.dart';
import 'package:renderscan/screens/home/models/nfts.model.dart';
import 'package:renderscan/utils/logger.dart';

class HomeScreenApi {
  String getPrettyJSONString(jsonObject) {
    var encoder = new JsonEncoder.withIndent("     ");
    return encoder.convert(jsonObject);
  }

  Future<List<TrendingModel>> getTrendingCollections() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var body =
          jsonEncode({"category": "", "chain": "ethereum", "count": "20"});

      var response = await http.post(
          HttpServerConfig().getHost("/marketplace/gettrendingcollections"),
          headers: headers,
          body: body);

      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        final List<dynamic> collection = json["collections"];
        List<TrendingModel> trending = [];
        log.i("trending collections api with status 200");
        for (int i = 0; i < collection.length; i++) {
          final TrendingModel trend = TrendingModel.jsonToObject(collection[i]);
          trending.add(trend);
        }
        return trending;
      }
    } catch (e) {
      log.e(e);
      return [];
    }
    return [];
  }

  Future<List<NFTHomeModel>> showCaseNFTs([String chain = "ethereum"]) async {
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({"limit": "12", "chain": chain});

    var response = await http.post(
        HttpServerConfig().getHost("/marketplace/getshowcasenfts"),
        headers: headers,
        body: body);

    if (response.statusCode == 200) {
      log.i("showcase nfts api with status 200");

      var json = jsonDecode(response.body);
      final List<dynamic> showcaseNFts = json["ShowcaseNFTs"];
      return NFTHomeModel.mapNFTs(showcaseNFts);
    }
    return [];
  }

  Future<List<NotableCollectionModel>> getNotableCollections() async {
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({"limit": "10"});

    var response = await http.post(
        HttpServerConfig().getHost("/marketplace/getnotablecollections"),
        headers: headers,
        body: body);
    if (response.statusCode == 200) {
      log.i("notable collections api with status 200");
      var json = jsonDecode(response.body);
      json = json["NotableCollections"] as List;

      List<NotableCollectionModel> notableCollection = [];
      for (int i = 0; i < json.length; i++) {
        final NotableCollectionModel collection =
            NotableCollectionModel.jsonToObject(json[i]);
        notableCollection.add(collection);
      }
      return notableCollection;
    }
    return [];
  }

  Future<String> getNFTPrice(String contract, String tokenId) async {
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({"contract": contract, "tokenId": tokenId});

    var response = await http.post(
        HttpServerConfig().getHost("/marketplace/getnftlatestprice"),
        headers: headers,
        body: body);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return json["price"] as String;
    }
    return "0";
  }
}
