import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renderscan/config/http_config.dart';
import 'package:renderscan/utils/storage.dart';

class ReferalApi {
  Future<String> getReferalCode() async {
    try {
      final userId = await Storage().getItem("userId");
      final resp = await http.post(
          HttpServerConfig().getHost(
            "/users/referal-code",
          ),
          body: {"userId": userId.toString()});
      final data = jsonDecode(resp.body);
      return data["referalCode"];
    } catch (e) {
      return "failed";
    }
  }

  Future<List<Referal>> getReferals() async {
    try {
      final userId = await Storage().getItem("userId");
      final resp = await http.post(
          HttpServerConfig().getHost(
            "/users/referals",
          ),
          body: {"userId": userId.toString()});
      final data = jsonDecode(resp.body);
      final refs = data["referals"] as List;
      List<Referal> referals = [];
      for (int i = 0; i < refs.length; i++) {
        referals.add(Referal.jsonToObject(refs[i]));
      }
      return referals;
    } catch (e) {
      return [];
    }
  }
}

class Referal {
  final String username;
  final String avatarUrl;
  final int amount;

  Referal(
      {required this.username, required this.amount, required this.avatarUrl});

  Referal.jsonToObject(Map<String, dynamic> json)
      : amount = json["amount"],
        avatarUrl = json["avatarUrl"] ?? "assets/images/lion.png",
        username = json['username'];
}
