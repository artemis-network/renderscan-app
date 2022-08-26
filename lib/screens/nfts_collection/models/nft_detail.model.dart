import 'package:renderscan/screens/nfts_collection/models/nft_owner.model.dart';
import 'package:renderscan/screens/nfts_collection/models/nft_trait.model.dart';

class NFTDetailModel {
  final String name;
  final String collectionName;
  final String collectionSlug;
  final String collectionImageUrl;
  final String description;
  final String imageUrl;
  final String openSeaUrl;
  final String externalUrl;
  final String numSales;
  final String totalSupply;
  final List<NFTTraitModel> traits;
  final String tokenId;
  final String lastPrice;
  final String creator_profile_pic;
  final NFTOwnerModel owner;
  final NFTOwnerModel creator;

  NFTDetailModel.jsonToObject(Map<String, dynamic> json)
      : imageUrl = json["imageUrl"] ??
            "https://lh3.googleusercontent.com/BdxvLseXcfl57BiuQcQYdJ64v-aI8din7WPk0Pgo3qQFhAUH-B6i-dCqqc_mCkRIzULmwzwecnohLhrcH8A9mpWIZqA7ygc52Sr81hE=s120",
        name = json["name"] ?? "default",
        description = json["description"] ?? "--",
        openSeaUrl = json["openSeaUrl"] ?? "0",
        externalUrl = json["externalUrl"] ?? "--",
        numSales = json["numSales"] ?? "0",
        totalSupply = json["totalSupply"] ?? "0",
        traits = json["traits"] = NFTTraitModel.mapTraits(json['traits']) ?? [],
        tokenId = json["tokenId"] ?? "0",
        creator_profile_pic = json["creator"]["profile_img_url"] ?? "--",
        lastPrice = json["lastPrice"] ?? "--",
        collectionName = json["collectionName"] ?? "--",
        collectionSlug = json["collectionSlug"] ?? "--",
        collectionImageUrl = json["collectionImageUrl"] ?? "",
        owner = NFTOwnerModel.jsonToObject(json["owner"]),
        creator = NFTOwnerModel.jsonToObject(json["creator"]);
}
