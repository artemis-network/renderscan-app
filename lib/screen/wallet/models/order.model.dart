class Order {
  final String notes;
  final double amount;
  final String userId;
  final String orderId;
  final String paymentId;
  final String signature;

  Order({
    required this.userId,
    required this.orderId,
    required this.amount,
    required this.paymentId,
    required this.signature,
    required this.notes,
  });

  Order.jsonToObject(Map<String, dynamic> json)
      : orderId = json['id'],
        amount = json['amount'],
        userId = json['userId'],
        notes = json['notes'],
        signature = json['signature'],
        paymentId = json['paymentId'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['notes'] = notes;
    data['amount'] = amount;
    data['id'] = orderId;
    data['userId'] = userId;
    data['paymentId'] = paymentId;
    data['signature'] = signature;
    return data;
  }
}
