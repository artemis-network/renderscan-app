import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renderscan/common/config/http_config.dart';
import 'package:renderscan/screen/wallet/wallet_dto.dart';

class WalletApi {
  Future<Wallet> getBalance(String username) async {
    try {
      final response = await http.post(HttpServerConfig().getHost("/wallets"),
          headers: HttpServerConfig().headers,
          body: jsonEncode({'username': username}));
      return Wallet.fromJson(jsonDecode(response.body));
    } on Exception {
      return Wallet(balance: 0, walletId: 0);
    }
  }
}
