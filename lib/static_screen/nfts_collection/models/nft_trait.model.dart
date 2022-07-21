class NFTTraitModel {
  final String trait_type;
  final String value;
  final String trait_count;

  NFTTraitModel.jsonToObject(Map<String, dynamic> json)
      : trait_count = json["trait_count"] ?? "--",
        trait_type = json["trait_type"] ?? "--",
        value = json["value"] ?? "--";

  static mapTraits(List<dynamic> json) {
    List<NFTTraitModel> nftTraitModels = [];
    for (int i = 0; i < json.length; i++) {
      nftTraitModels.add(NFTTraitModel.jsonToObject(json[i]));
    }
    return nftTraitModels;
  }
}
