class TrendingDTO {
  final String name;
  final String logo;
  final String slug;
  final String floor;
  final int numOwners;
  final double oneDayChange;
  final String oneDayVolume;
  final double sevenDayChange;
  final String sevenDayVolume;
  final double thirtyDayChange;
  final String thirtyDayVolume;

  TrendingDTO(
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

  TrendingDTO.jsonToObject(Map<String, dynamic> json)
      : name = json['name'] ?? "--",
        logo = json['logo'] ??
            "https://openseauserdata.com/files/041c953eabd1f9381cdca769bdf3f49c.png",
        slug = json['slug'] ?? "--",
        floor = json['floor'] ?? "--",
        numOwners = json['numOwners'].toInt() ?? 0,
        oneDayChange = json['oneDayChange'].toDouble() ?? 0.0,
        oneDayVolume = json['oneDayVolume'] ?? "--",
        sevenDayChange = json['sevenDayChange'].toDouble() ?? 0.0,
        sevenDayVolume = json['sevenDayVolume'] ?? "--",
        thirtyDayChange = json['thirtyDayChange'].toDouble() ?? 0.0,
        thirtyDayVolume = json['thirtyDayVolume'] ?? "--";
}
