import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renderscan/common/config/http_config.dart';
import 'package:renderscan/screen/wallet/wallet_dto.dart';

class WalletApi {
  Future<WalletResponse> getBalance(String username) async {
    final response = await http.post(
        HttpServerConfig().getHost("/users/get-user-wallet"),
        headers: HttpServerConfig().headers,
        body: jsonEncode({'username': username}));
    return WalletResponse.fromJson(jsonDecode(response.body));
  }
}
