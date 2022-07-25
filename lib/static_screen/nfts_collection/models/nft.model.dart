class NFTModel {
  final String name;
  final String imageUrl;
  final String tokenId;
  final String contract;
  final String lastPrice;

  static mapNFTs(List<dynamic> jsonList) {
    List<NFTModel> nfts = [];
    for (int i = 0; i < jsonList.length; i++) {
      nfts.add(NFTModel.jsonToObject(jsonList[i]));
    }
    return nfts;
  }

  static String toCapitalized(String str, String alt) => str.length > 0
      ? '${str[0].toUpperCase()}${str.substring(1).toLowerCase()}'
      : alt;

  NFTModel.jsonToObject(Map<String, dynamic> json)
      : imageUrl = json["imageUrl"] ??
            "https://lh3.googleusercontent.com/BdxvLseXcfl57BiuQcQYdJ64v-aI8din7WPk0Pgo3qQFhAUH-B6i-dCqqc_mCkRIzULmwzwecnohLhrcH8A9mpWIZqA7ygc52Sr81hE=s120",
        name = toCapitalized(json["name"] ?? "", json["tokenId"] ?? ""),
        tokenId = json["tokenId"] ?? "--",
        contract = json["contract"] ?? "--",
        lastPrice = json["lastPrice"] ?? "--";
}
