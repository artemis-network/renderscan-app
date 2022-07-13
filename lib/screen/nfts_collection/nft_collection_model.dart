class NFTCollectionStats {
  final int num_owners;
  final int total_Supply;
  final String floor_price;
  final double one_day_volume;

  NFTCollectionStats(
      {required this.num_owners,
      required this.total_Supply,
      required this.floor_price,
      required this.one_day_volume});

  NFTCollectionStats.jsonToObject(Map<String, dynamic> json)
      : num_owners = json["num_owners"],
        total_Supply = json["total_supply"],
        floor_price = json["floor_price"] ?? "__",
        one_day_volume = json["one_day_volume"];
}

class NFTCollection {
  final String name;
  final String description;
  final String imageUrl;
  final String bannerUrl;
  final String contractAddress;
  final String twitter;
  final String externalUrl;
  final NFTCollectionStats stats;

  NFTCollection(
      {required this.name,
      required this.description,
      required this.imageUrl,
      required this.bannerUrl,
      required this.contractAddress,
      required this.twitter,
      required this.externalUrl,
      required this.stats});

  NFTCollection.jsonToObject(Map<String, dynamic> json)
      : name = json['name'],
        description = json['description'],
        imageUrl = json['imageUrl'],
        bannerUrl = json['bannerUrl'],
        contractAddress = json['contractAddress'],
        twitter = json['twitter'],
        externalUrl = json['externalUrl'],
        stats = NFTCollectionStats.jsonToObject(json['stats']);
}
