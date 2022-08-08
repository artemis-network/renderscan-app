class NFTCollectionModel {
  final String name;
  final String description;
  final String bannerUrl;
  final String imageUrl;
  final String floorPrice;
  final String totalSuppy;
  final String owners;
  final String totalVolume;
  final String contractAddress;
  final String twitter;
  final String externalUrl;

  NFTCollectionModel.jsonToObject(Map<String, dynamic> json)
      : name = json["name"] ?? "--",
        description = json["description"] ?? "",
        bannerUrl = json["bannerUrl"] ??
            "https://images.unsplash.com/photo-1656610193520-95d42a99c451?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=150&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY1ODIzNTUzMg&ixlib=rb-1.2.1&q=80&w=500",
        imageUrl = json["imageUrl"] ??
            "https://images.unsplash.com/photo-1656610193520-95d42a99c451?crop=entropy&cs=tinysrgb&fit=crop&fm=jpg&h=150&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTY1ODIzNTUzMg&ixlib=rb-1.2.1&q=80&w=500",
        floorPrice = json["floorPrice"] ?? "--",
        totalSuppy = json["totalSupply"] ?? "--",
        owners = json["owners"] ?? "--",
        totalVolume = json["totalVolume"] ?? "--",
        contractAddress = json['contractAddress'] ?? "--",
        twitter = json["twitter"] ?? "--",
        externalUrl = json['externalUrl'] ?? "--";
}
