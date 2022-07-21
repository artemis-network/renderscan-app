import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:renderscan/common/config/http_config.dart';
import 'package:renderscan/common/utils/logger.dart';
import 'package:renderscan/screen/home/models/notable_collection.model.dart';
import 'package:renderscan/screen/home/models/trending_model.dart';
import 'package:http/http.dart' as http;
import 'package:renderscan/screen/nfts_collection/models/nft.model.dart';

class HomeScreenApi {
  String getPrettyJSONString(jsonObject) {
    var encoder = new JsonEncoder.withIndent("     ");
    return encoder.convert(jsonObject);
  }

  Future<List<TrendingModel>> getTrendingCollections() async {
    var headers = {'Content-Type': 'application/json'};
    var body =
        jsonEncode({"category": "art", "chain": "ethereum", "count": "30"});

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

    final String response_ =
        await rootBundle.loadString('assets/mock/trending.json');
    final json = await jsonDecode(response_);
    final List<dynamic> collection = json["collections"];
    List<TrendingModel> trending = [];
    for (int i = 0; i < collection.length; i++) {
      final TrendingModel trend = TrendingModel.jsonToObject(collection[i]);
      trending.add(trend);
    }
    return trending;
  }

  Future<List<NFTModel>> showCaseNFTs() async {
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({"limit": "10", "chain": "ethereum"});

    var response = await http.post(
        HttpServerConfig().getHost("/marketplace/getshowcasenfts"),
        headers: headers,
        body: body);

    if (response.statusCode == 200) {
      log.i("showcase nfts api with status 200");

      var json = jsonDecode(response.body);
      final List<dynamic> showcaseNFts = json["ShowcaseNFTs"];
      return NFTModel.mapNFTs(showcaseNFts);
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
}
