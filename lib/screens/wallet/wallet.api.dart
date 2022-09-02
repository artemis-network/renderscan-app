import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renderscan/config/http_config.dart';

class WalletModel {
  final String address;
  final String mnemonic;

  WalletModel.jsonToObject(Map<String, dynamic> json)
      : address = json["address"],
        mnemonic = json["mnemonic"];
}

class WalletApi {
  static Future<WalletModel> createAddress(String pin) async {
    try {
      final resp = await http.post(
          HttpServerConfig().getHost("/users/createwallet"),
          body: {"pin": pin});
      final body = jsonDecode(resp.body);
      return WalletModel.jsonToObject(body);
    } catch (e) {
      throw e;
    }
  }
}
