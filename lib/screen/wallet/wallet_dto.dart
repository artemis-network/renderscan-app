class Wallet {
  int? walletId;
  double? balance;

  Wallet({this.walletId, this.balance});

  Wallet.fromJson(Map<String, dynamic> json) {
    var wallet = json['wallet'];
    walletId = wallet['wallet_id'];
    balance = wallet['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['wallet_id'] = walletId;
    data['balance'] = balance;
    final Map<String, dynamic> wallet = <String, dynamic>{};
    wallet["wallet"] = data;
    return wallet;
  }
}
