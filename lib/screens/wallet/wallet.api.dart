import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renderscan/config/http_config.dart';
import 'package:renderscan/utils/logger.dart';

class WalletModel {
  final String address;
  final String mnemonic;

  WalletModel.jsonToObject(Map<String, dynamic> json)
      : address = json["address"] ?? "_",
        mnemonic = json["mnemonic"] ?? "_";
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

  static Future<WalletModel> recoveryAddress(String mnemonic) async {
    try {
      log.i(mnemonic);
      final resp = await http.post(
          HttpServerConfig().getHost("/users/retrivewallet"),
          body: {"mnemonic": mnemonic});
      final body = jsonDecode(resp.body);
      return WalletModel.jsonToObject(body);
    } catch (e) {
      throw e;
    }
  }
}
