import 'dart:convert';

import 'package:renderscan/common/utils/logger.dart';
import 'package:http/http.dart' as http;
import 'package:renderscan/static_screen/home/models/notable_collection.model.dart';
import 'package:renderscan/static_screen/nfts_collection/models/nft.model.dart';

class SearchAPI {
  String getPrettyJSONString(jsonObject) {
    var encoder = new JsonEncoder.withIndent("     ");
    return encoder.convert(jsonObject);
  }

  Future<List<NFTModel>> searchNFts(String nft) async {
    var headers = {'Content-Type': 'application/json'};
    try {
      var request = http.Request(
          'POST',
          Uri.parse(
              'https://api.renderverse.io/renderscan/v1/marketplace/searchnfts'));
      request.body = json.encode({"searchstr": nft, "limit": 10});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        List<NFTModel> nfts = [];
        final data = await response.stream.bytesToString();
        var json = jsonDecode(data);
        json = json["Collections"] as List;
        for (int i = 0; i < json.length; i++) {
          final NFTModel nft = NFTModel.jsonToObject(json[i]);
          nfts.add(nft);
        }
        return nfts;
      } else {
        print(response.reasonPhrase);
        return [];
      }
    } catch (e) {
      log.i(e);
      return [];
    }
  }

  Future<List<NotableCollectionModel>> searchCollections(
      String collection) async {
    var headers = {'Content-Type': 'application/json'};
    log.i(collection);
    try {
      var request = http.Request(
          'POST',
          Uri.parse(
              'https://api.renderverse.io/renderscan/v1/marketplace/searchcollections'));
      request.body = json.encode({"searchstr": collection, "limit": 10});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        List<NotableCollectionModel> notableCollection = [];
        final data = await response.stream.bytesToString();
        var json = jsonDecode(data);
        log.i(json);
        json = json["Collections"] as List;
        for (int i = 0; i < json.length; i++) {
          final NotableCollectionModel collection =
              NotableCollectionModel.jsonToObject(json[i]);
          notableCollection.add(collection);
        }
        log.i(notableCollection);
        return notableCollection;
      } else {
        print(response.reasonPhrase);
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}