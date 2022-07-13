import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:renderscan/screen/home/models/trending_model.dart';

class HomeScreenApi {
  Future<List<Trending>> getTrendingCollections() async {
    final String response =
        await rootBundle.loadString('assets/mock/trending.json');
    final json = await jsonDecode(response);
    final List<dynamic> collection = json["collections"];
    List<Trending> trending = [];
    for (int i = 0; i < collection.length; i++) {
      final Trending trend = Trending.jsonToObject(collection[i]);
      trending.add(trend);
    }
    return trending;

    // var headers = {'Content-Type': 'application/json'};
    // var body =
    //     json.encode({"category": "art", "chain": "ethereum", "count": "30"});

    // var response = await http.post(
    //     HttpServerConfig().getHost("/marketplace/trendingcollections"),
    //     headers: headers,
    //     body: body);

    // if (response.statusCode == 200) {
    //   var json = jsonDecode(response.body);
    //   final List<dynamic> collection = json["collections"];
    //   List<Trending> trending = [];
    //   for (int i = 0; i < collection.length; i++) {
    //     final Trending trend = Trending.jsonToObject(collection[i]);
    //     trending.add(trend);
    //   }
    //   return trending;
    // }
    // print(response.reasonPhrase);
    // return [];
  }
}
