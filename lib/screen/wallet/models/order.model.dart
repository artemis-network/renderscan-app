class Order {
  final String notes;
  final double amount;
  final String userId;
  final String orderId;
  final String paymentId;
  final String signature;
  final String currency;
  final String description;

  Order(
      {required this.userId,
      required this.orderId,
      required this.amount,
      required this.paymentId,
      required this.signature,
      required this.description,
      required this.notes,
      required this.currency});

  Order.jsonToObject(Map<String, dynamic> json)
      : orderId = json['id'],
        amount = json['amount'],
        userId = json['userId'],
        notes = json['notes'],
        signature = json['signature'],
        paymentId = json['paymentId'],
        currency = json['currency'],
        description = json['description'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notes'] = notes;
    data['amount'] = amount;
    data['id'] = orderId;
    data['userId'] = userId;
    data['currency'] = currency;
    data['description'] = description;
    data['paymentId'] = paymentId;
    data['signature'] = signature;
    return data;
  }
}
