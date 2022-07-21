class NotableCollectionModel {
  String name;
  String slug;
  String imageUrl;
  String bannerUrl;
  String oneDayChange;

  NotableCollectionModel.jsonToObject(Map<String, dynamic> json)
      : name = json["name"] ?? "--",
        slug = json["slug"] ?? "--",
        imageUrl = json["imageUrl"] ?? "--",
        bannerUrl = json["bannerUrl"] ?? "--",
        oneDayChange = json["oneDayChange"] ?? "--";
}
