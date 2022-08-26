import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renderscan/screens/home/models/nfts.model.dart';
import 'package:renderscan/screens/home/models/notable_collection.model.dart';

class SearchAPI {
  String getPrettyJSONString(jsonObject) {
    var encoder = new JsonEncoder.withIndent("     ");
    return encoder.convert(jsonObject);
  }

  Future<List<NFTHomeModel>> searchNFts(String nft) async {
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
        List<NFTHomeModel> nfts = [];
        final data = await response.stream.bytesToString();
        var json = jsonDecode(data);
        json = json["Collections"] as List;
        for (int i = 0; i < json.length; i++) {
          final NFTHomeModel nft = NFTHomeModel.jsonToObject(json[i]);
          nfts.add(nft);
        }
        return nfts;
      } else {
        print(response.reasonPhrase);
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  Future<List<NotableCollectionModel>> searchCollections(
      String collection) async {
    var headers = {'Content-Type': 'application/json'};
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
        json = json["Collections"] as List;
        for (int i = 0; i < json.length; i++) {
          final NotableCollectionModel collection =
              NotableCollectionModel.jsonToObject(json[i]);
          notableCollection.add(collection);
        }
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
