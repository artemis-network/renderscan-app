class TrendingModel {
  final String name;
  final String logo;
  final String slug;
  final String floor;
  final String numOwners;
  final String oneDayChange;
  final String oneDayVolume;
  final String sevenDayChange;
  final String sevenDayVolume;
  final String thirtyDayChange;
  final String thirtyDayVolume;

  TrendingModel(
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

  TrendingModel.jsonToObject(Map<String, dynamic> json)
      : name = json['name'] ?? "--",
        logo = json['logo'] ??
            "https://openseauserdata.com/files/041c953eabd1f9381cdca769bdf3f49c.png",
        slug = json['slug'] ?? "--",
        floor = json['floor'] ?? "--",
        numOwners = json['numOwners'] ?? "--",
        oneDayChange = json['oneDayChange'] ?? "--",
        oneDayVolume = json['oneDayVolume'] ?? "--",
        sevenDayChange = json['sevenDayChange'] ?? "--",
        sevenDayVolume = json['sevenDayVolume'] ?? "--",
        thirtyDayChange = json['thirtyDayChange'] ?? "--",
        thirtyDayVolume = json['thirtyDayVolume'] ?? "--";
}
