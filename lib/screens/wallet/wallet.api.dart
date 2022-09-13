import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renderscan/config/http_config.dart';
import 'package:renderscan/utils/logger.dart';

class WalletModel {
  final String address;
  final String mnemonic;
  final String privateKey;
  final String recoverUrl;

  WalletModel.jsonToObject(Map<String, dynamic> json)
      : address = json["address"] ?? "_",
        mnemonic = json["mnemonic"] ?? "_",
        privateKey = json["privatekey"] ?? "-",
        recoverUrl = json["walletUrl"] ?? json["recoverUrl"] ?? "-";
}

class WalletApi {
  static Future<WalletModel> createEthWalletAddress(String pin) async {
    try {
      final resp = await http.post(
          HttpServerConfig().getHost("/users/createethwallet"),
          body: {"pin": pin});
      final body = jsonDecode(resp.body);
      return WalletModel.jsonToObject(body);
    } catch (e) {
      throw e;
    }
  }

  static Future<WalletModel> createNearWalletAddress(String account) async {
    try {
      final resp = await http.post(
          HttpServerConfig().getHost("/users/createnearwallet"),
          body: {"accountId": account});
      final body = jsonDecode(resp.body);
      log.i(body);
      return WalletModel.jsonToObject(body);
    } catch (e) {
      throw e;
    }
  }

  static Future<WalletModel> recoveryNeartWalletAddress(String mnemonic) async {
    try {
      final resp = await http.post(
          HttpServerConfig().getHost("/users/retrivenearwallet"),
          body: {"mnemonic": mnemonic});
      final body = jsonDecode(resp.body);
      return WalletModel.jsonToObject(body);
    } catch (e) {
      throw e;
    }
  }

  static Future<WalletModel> recoveryEthWalletAddress(String mnemonic) async {
    try {
      log.i(mnemonic);
      final resp = await http.post(
          HttpServerConfig().getHost("/users/retriveethwallet"),
          body: {"mnemonic": mnemonic});
      final body = jsonDecode(resp.body);
      return WalletModel.jsonToObject(body);
    } catch (e) {
      throw e;
    }
  }
}
