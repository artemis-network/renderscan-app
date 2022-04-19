class WalletResponse {
  int? walletId;
  double? balance;

  WalletResponse({this.walletId, this.balance});

  WalletResponse.fromJson(Map<String, dynamic> json) {
    walletId = json['wallet_id'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wallet_id'] = walletId;
    data['balance'] = balance;
    return data;
  }
}
