import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:renderscan/common/config/http_config.dart';
import 'package:renderscan/common/utils/logger.dart';

class NFTCollectionAPI {
  String getPrettyJSONString(jsonObject) {
    var encoder = new JsonEncoder.withIndent("     ");
    return encoder.convert(jsonObject);
  }

  Future<NFTCollectionDTO> getNFTCollectionBySlug(String slug) async {
    var headers = {'Content-Type': 'application/json'};
    var body = jsonEncode({"slug": slug});

    var response = await http.post(
        HttpServerConfig().getHost("/marketplace/collectioninfofromslug"),
        headers: headers,
        body: body);

    var json = jsonDecode(response.body);
    json = json["CollectionInfo"];

    return NFTCollectionDTO.jsonToObject(json);
  }

  Future<List<NFTDTO>> getNFTsBySlug(String slug) async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var body = jsonEncode({"slug": slug, "limit": 20});

      var response = await http.post(
          HttpServerConfig().getHost("/marketplace/collectionnftsfromslug"),
          headers: headers,
          body: body);

      var json = jsonDecode(response.body);
      json = json["CollectionNFTs"] as List;

      List<NFTDTO> nfts = [];
      for (int i = 0; i < json.length; i++) {
        nfts.add(NFTDTO.jsonToObject(json[i]));
      }
      return nfts;
    } catch (e) {
      log.i(e);
      return [];
    }
  }
}

class NFTCollectionDTO {
  final String name;
  final String description;
  final String bannerUrl;
  final String imageUrl;
  final NFTCollectionStatsDTO stats;

  NFTCollectionDTO.jsonToObject(Map<String, dynamic> json)
      : bannerUrl = json["bannerUrl"] ??
            "https://images.unsplash.com/photo-1656610193520-95d42a99c451?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=150&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY1ODIzNTUzMg&ixlib=rb-1.2.1&q=80&w=500",
        imageUrl = json["imageUrl"] ??
            "https://images.unsplash.com/photo-1656610193520-95d42a99c451?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=150&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY1ODIzNTUzMg&ixlib=rb-1.2.1&q=80&w=500",
        name = json["name"] ?? "mame",
        description = json["description"] ?? "test",
        stats = NFTCollectionStatsDTO.jsonToObject(json['stats']);
}

class NFTCollectionStatsDTO {
  final double floor;
  final int total_supply;
  final int num_owners;
  final double total_volume;

  NFTCollectionStatsDTO.jsonToObject(Map<String, dynamic> json)
      : floor = (json["floor_price"] ?? 0.0).toDouble(),
        num_owners = (json["num_owners"] ?? 0).toInt(),
        total_supply = (json["total_supply"] ?? 0).toInt(),
        total_volume = (json["total_volume"] ?? 0.0).toDouble();
}

class NFTDTO {
  final String name;
  final String description;
  final String imageUrl;
  final String openseaUrl;
  final String externalUrl;
  final List<NFTTrait> traits;
  final String tokenId;
  final String contractAddress;
  final double price;
  final String creator;
  final String creator_profile_pic;
  final NFTOwner owner;

  NFTDTO.jsonToObject(Map<String, dynamic> json)
      : imageUrl = json["imageUrl"] ??
            "https://lh3.googleusercontent.com/BdxvLseXcfl57BiuQcQYdJ64v-aI8din7WPk0Pgo3qQFhAUH-B6i-dCqqc_mCkRIzULmwzwecnohLhrcH8A9mpWIZqA7ygc52Sr81hE=s120",
        name = json["name"] ?? "default",
        description = json["description"] ?? "--",
        openseaUrl = json["openseaUrl"] ?? "--",
        externalUrl = json["externalUrl"] ?? "--",
        traits = json["traits"] = NFTTrait.mapTraits(json['traits']),
        tokenId = json["tokenId"] ?? "--",
        creator = json["creator"]["address"] ?? "--",
        creator_profile_pic = json["creator"]["profile_img_url"] ?? "--",
        contractAddress = json["contractAddress"] ?? "--",
        price = (json["price"] ?? 0).toDouble(),
        owner = NFTOwner.jsonToObject(json["owner"]);
}

class NFTTrait {
  final String trait_type;
  final String value;
  final int trait_count;

  NFTTrait.jsonToObject(Map<String, dynamic> json)
      : trait_count = json["trait_count"] ?? "--",
        trait_type = json["trait_type"] ?? "--",
        value = json["value"] ?? 0;

  static mapTraits(List<dynamic> json) {
    List<NFTTrait> nftTraits = [];
    for (int i = 0; i < json.length; i++) {
      nftTraits.add(NFTTrait.jsonToObject(json[i]));
    }
    return nftTraits;
  }
}

class NFTOwner {
  final String username;
  final String address;
  final String profile_img_url;
  NFTOwner.jsonToObject(Map<String, dynamic> json)
      : address = json["address"] ?? "--",
        profile_img_url = json["profile_img_url"] ??
            "https://lh3.googleusercontent.com/BdxvLseXcfl57BiuQcQYdJ64v-aI8din7WPk0Pgo3qQFhAUH-B6i-dCqqc_mCkRIzULmwzwecnohLhrcH8A9mpWIZqA7ygc52Sr81hE=s120",
        username = json["user"]["username"] ?? "--";
}
