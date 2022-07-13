import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:renderscan/screen/nfts_collection/nft_collection_model.dart';

class NFTCollectionAPI {
  Future<NFTCollection> getNFTCollectionBySlug(String slug) async {
    final String response =
        await rootBundle.loadString('assets/mock/nft_collection.json');
    var json = await jsonDecode(response);
    json = json["CollectionInfo"];
    final d = NFTCollection.jsonToObject(json);
    return d;
  }
}
