import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:renderscan/common/config/http_config.dart';
import 'package:renderscan/common/utils/logger.dart';
import 'package:renderscan/screen/wallet/models/order.model.dart';

class WalletApi {
  Future<dynamic> createOrder(Order order) async {
    try {
      final response = await http.post(
          HttpServerConfig().getHost("/orders/create"),
          headers: HttpServerConfig().headers,
          body: jsonEncode(order.toJson()));
      return jsonDecode(response.body);
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<Map<String, dynamic>> completeOrder(Order order) async {
    try {
      final response = await http.post(
          HttpServerConfig().getHost("/orders/complete"),
          headers: HttpServerConfig().headers,
          body: jsonEncode(order.toJson()));
      return jsonDecode(response.body);
    } on Exception {
      return Map();
    }
  }

  Future<dynamic> getWalletBalance() async {
    try {
      final data = {"userId": "62ceac54ee2a42334ab6dc29"};
      final response = await http.post(
          HttpServerConfig().getHost("/wallets/balance"),
          headers: HttpServerConfig().headers,
          body: jsonEncode((data)));
      log.i(response);
      return jsonDecode(response.body);
    } catch (e) {}
  }
}
