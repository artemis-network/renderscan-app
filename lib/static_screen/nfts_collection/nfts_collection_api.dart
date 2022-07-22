import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:renderscan/common/config/http_config.dart';
import 'package:renderscan/common/utils/logger.dart';
import 'package:renderscan/static_screen/nfts_collection/models/nft_collection.model.dart';
import 'package:renderscan/static_screen/nfts_collection/models/nft_detail.model.dart';
import 'package:renderscan/static_screen/nfts_collection/models/nft_sol.modal.dart';

class NFTCollectionAPI {
  String getPrettyJSONString(jsonObject) {
    var encoder = new JsonEncoder.withIndent("     ");
    return encoder.convert(jsonObject);
  }

  Future<NFTCollectionModel> getNFTCollectionBySlug(String slug) async {
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({"slug": slug, "limit": 20});
    try {
      var response = await http.post(
          HttpServerConfig().getHost("/marketplace/getcollectionfromSlug"),
          headers: headers,
          body: body);

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        log.i("nft collection api status 200");
        final nfts = json["CollectionNFTs"];
        final collectionInfo = json["CollectionInfo"];
        return NFTCollectionModel.jsonToObject(collectionInfo, nfts);
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
        HttpServerConfig().getHost("/marketplace/getnftfromcontract"),
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
        HttpServerConfig().getHost("/marketplace/getnftfromcontract"),
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
