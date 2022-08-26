import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:renderscan/config/http_config.dart';
import 'package:renderscan/screens/nfts_collection/models/nft.model.dart';
import 'package:renderscan/screens/nfts_collection/models/nft_collection.model.dart';
import 'package:renderscan/screens/nfts_collection/models/nft_detail.model.dart';
import 'package:renderscan/screens/nfts_collection/models/nft_sol.modal.dart';
import 'package:renderscan/utils/logger.dart';

class NFTCollectionAPI {
  String getPrettyJSONString(jsonObject) {
    var encoder = new JsonEncoder.withIndent("     ");
    return encoder.convert(jsonObject);
  }

  Future<NFTCollectionModel> getNFTCollectionBySlug(String slug) async {
    var body = jsonEncode({"slug": slug});
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(
          HttpServerConfig().getHost("/marketplace/getcollectioninfo"),
          headers: headers,
          body: body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        log.i("nft collection api status 200");
        final collectionInfo = json["CollectionInfo"];
        return NFTCollectionModel.jsonToObject(collectionInfo);
      }
      throw Error();
    } on SocketException catch (e) {
      log.e("failed to get nft collection info from api");
      log.e(e);
      throw e;
    }
  }

  Future<List<NFTModel>> getNFTCollectionNFTsBySlug(
      String slug, int offset) async {
    var body = jsonEncode({"slug": slug, "offset": offset});
    var headers = {'Content-Type': 'application/json'};
    try {
      var response = await http.post(
          HttpServerConfig().getHost("/marketplace/getcollectionnfts"),
          headers: headers,
          body: body);

      log.i(response.statusCode);
      if (response.statusCode == 200) {
        log.i("collection nfts has been retrived status 200");
        final json = jsonDecode(response.body);
        log.i(json);
        final nfts = json["CollectionNFTs"] as List;
        List<NFTModel> nftsList = [];
        for (int i = 0; i < nfts.length; i++) {
          nftsList.add(NFTModel.jsonToObject(nfts[i]));
        }
        return nftsList;
      }
      throw Error();
    } on SocketException catch (e) {
      log.e("failed to get nft collection info from api");
      log.e(e);
      throw e;
    }
  }

  Future<NFTDetailModel> getNFTByContract(
      String contract, String tokenId) async {
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode(
        {"contract": contract, "token_id": tokenId, "chain": "ethereum"});

    var response = await http.post(
        HttpServerConfig().getHost("/marketplace/getnftinfo"),
        headers: headers,
        body: body);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      log.i("nft api status 200");
      return NFTDetailModel.jsonToObject(json["NFTInfo"]);
    }
    return NFTDetailModel.jsonToObject({});
  }

  Future<NFTSolDetailModel> getSolNFTByContract(
      String contract, String tokenId) async {
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode(
        {"contract": contract, "token_id": tokenId, "chain": "solana"});

    var response = await http.post(
        HttpServerConfig().getHost("/marketplace/getnftinfo"),
        headers: headers,
        body: body);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      log.i("sol nft api status 200");
      return NFTSolDetailModel.jsonToObject(json["NFTInfo"]);
    }
    return NFTSolDetailModel.jsonToObject({});
  }
}
