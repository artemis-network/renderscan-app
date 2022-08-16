class NFTSolDetailModel {
  final String name;
  final String collectionName;
  final String imageUrl;
  final String owner;
  final List<NFTSolCreator> creators;
  final List<NFTSolTraits> traits;

  NFTSolDetailModel.jsonToObject(Map<String, dynamic> json)
      : imageUrl = json["imageUrl"] ??
            "https://lh3.googleusercontent.com/BdxvLseXcfl57BiuQcQYdJ64v-aI8din7WPk0Pgo3qQFhAUH-B6i-dCqqc_mCkRIzULmwzwecnohLhrcH8A9mpWIZqA7ygc52Sr81hE=s120",
        collectionName = json["collectionName"] ?? "--",
        name = json["name"] ?? "--",
        traits = NFTSolTraits.mapTraits(json['traits']),
        owner = json["owner"] ?? "--",
        creators = NFTSolCreator.mapCreators(json["creator"]);
}

class NFTSolTraits {
  final String trait_type;
  final String value;

  static mapTraits(List<dynamic> list) {
    List<NFTSolTraits> traits = [];
    for (int i = 0; i < list.length; i++) {
      final NFTSolTraits trait = NFTSolTraits.jsonToObject(list[i]);
      traits.add(trait);
    }
    return traits;
  }

  NFTSolTraits.jsonToObject(Map<String, dynamic> json)
      : trait_type = json["trait_type"],
        value = json["value"];
}

class NFTSolCreator {
  final String address;
  final String share;

  static mapCreators(List<dynamic> list) {
    List<NFTSolCreator> creators = [];
    for (int i = 0; i < list.length; i++) {
      final NFTSolCreator trait = NFTSolCreator.jsonToObject(list[i]);
      creators.add(trait);
    }
    return creators;
  }

  NFTSolCreator.jsonToObject(Map<String, dynamic> json)
      : address = json['address'] ?? "--",
        share = json["share"] ?? "--";
}
