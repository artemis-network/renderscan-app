import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renderscan/config/http_config.dart';
import 'package:renderscan/screens/home/models/trending_model.dart';
import 'package:renderscan/utils/logger.dart';

class RankingScreenApi {
  String getPrettyJSONString(jsonObject) {
    var encoder = new JsonEncoder.withIndent("     ");
    return encoder.convert(jsonObject);
  }

  Future<List<TrendingModel>> getTrendingCollectionsByCategoryFilter(
      String filtername) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var body = jsonEncode(
          {"category": filtername, "chain": "ethereum", "count": "20"});

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
}
