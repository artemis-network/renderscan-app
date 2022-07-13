class Trending {
  final String? name;
  final String? logo;
  final String? slug;
  final String? floor;
  final int? numOwners;
  final double? oneDayChange;
  final String? oneDayVolume;
  final double? sevenDayChange;
  final String? sevenDayVolume;
  final double? thirtyDayChange;
  final String? thirtyDayVolume;

  Trending(
      {required this.name,
      required this.logo,
      required this.slug,
      required this.floor,
      required this.numOwners,
      required this.oneDayChange,
      required this.oneDayVolume,
      required this.sevenDayChange,
      required this.sevenDayVolume,
      required this.thirtyDayChange,
      required this.thirtyDayVolume});

  Trending.jsonToObject(Map<String, dynamic> json)
      : name = json['name'],
        logo = json['logo'],
        slug = json['slug'],
        floor = json['floor'],
        numOwners = json['numOwners'],
        oneDayChange = json['oneDayChange'],
        oneDayVolume = json['oneDayVolume'],
        sevenDayChange = json['sevenDayChange'],
        sevenDayVolume = json['sevenDayVolume'],
        thirtyDayChange = json['thirtyDayChange'],
        thirtyDayVolume = json['thirtyDayVolume'];
}
