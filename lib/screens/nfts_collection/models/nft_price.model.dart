class NFTPriceModel {
  final String currency;
  final String amount;

  NFTPriceModel.jsonToObject(Map<String, dynamic> json)
      : currency = json["currency"] ?? "--",
        amount = json["amount"] ?? "--";
}
