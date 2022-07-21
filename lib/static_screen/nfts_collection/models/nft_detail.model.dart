import 'package:renderscan/static_screen/nfts_collection/models/nft_owner.model.dart';
import 'package:renderscan/static_screen/nfts_collection/models/nft_trait.model.dart';

class NFTDetailModel {
  final String name;
  final String collectionName;
  final String collectionSlug;
  final String collectionImageUrl;
  final String description;
  final String imageUrl;
  final String openseaUrl;
  final String externalUrl;
  final List<NFTTraitModel> traits;
  final String tokenId;
  final String contractAddress;
  final String lastPrice;
  final String creator;
  final String creator_profile_pic;
  final NFTOwnerModel owner;

  NFTDetailModel.jsonToObject(Map<String, dynamic> json)
      : imageUrl = json["imageUrl"] ??
            "https://lh3.googleusercontent.com/BdxvLseXcfl57BiuQcQYdJ64v-aI8din7WPk0Pgo3qQFhAUH-B6i-dCqqc_mCkRIzULmwzwecnohLhrcH8A9mpWIZqA7ygc52Sr81hE=s120",
        name = json["name"] ?? "default",
        description = json["description"] ?? "--",
        openseaUrl = json["openseaUrl"] ?? "--",
        externalUrl = json["externalUrl"] ?? "--",
        traits = json["traits"] = NFTTraitModel.mapTraits(json['traits']),
        tokenId = json["tokenId"] ?? "--",
        creator = json["creator"]["address"] ?? "--",
        creator_profile_pic = json["creator"]["profile_img_url"] ?? "--",
        contractAddress = json["contractAddress"] ?? "--",
        lastPrice = json["lastPrice"] ?? "--",
        collectionName = json["collectionName"] ?? "--",
        collectionSlug = json["collectionSlug"] ?? "--",
        collectionImageUrl = json["collectionImageUrl"] ?? "",
        owner = NFTOwnerModel.jsonToObject(json["owner"]);
}
