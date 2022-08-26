import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:renderscan/config/http_config.dart';
import 'package:renderscan/screens/transcations/models/order.model.dart';
import 'package:renderscan/utils/storage.dart';

class TransactionApi {
  Future<dynamic> createOrder(Order order) async {
    try {
      final response = await http.post(
          HttpServerConfig().getHost("/payments/create"),
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
          HttpServerConfig().getHost("/payments/complete"),
          headers: HttpServerConfig().headers,
          body: jsonEncode(order.toJson()));
      return jsonDecode(response.body);
    } on Exception {
      return Map();
    }
  }

  Future<List<TransactionDTO>> getTranscations() async {
    try {
      final userId = await Storage().getItem("userId");
      final body = {"userId": userId.toString()};
      final response = await http.post(
          HttpServerConfig().getHost("/users/transactions"),
          headers: HttpServerConfig().headers,
          body: jsonEncode((body)));
      var resp = jsonDecode(response.body);
      resp = resp["transactions"];
      List<TransactionDTO> transcations = [];
      for (int i = 0; i < resp.length; i++) {
        final transaction = TransactionDTO.jsonToObject(resp[i]);
        transcations.add(transaction);
      }
      return transcations;
    } on FormatException catch (e) {
      print(e);
      return [] as List<TransactionDTO>;
    }
  }

  Future<BalanceDTO> getBalance() async {
    try {
      final userId = await Storage().getItem("userId");
      if (userId == null) return BalanceDTO(ruby: 0, superRuby: 0);
      final body = {"userId": userId.toString()};
      final response = await http.post(
          HttpServerConfig().getHost("/users/balance"),
          headers: HttpServerConfig().headers,
          body: jsonEncode((body)));
      final resp = jsonDecode(response.body);
      final dto = BalanceDTO.jsonToObject(resp);
      return dto;
    } catch (e) {
      return BalanceDTO(ruby: 0, superRuby: 0);
    }
  }
}

class BalanceDTO {
  final int ruby;
  final int superRuby;

  BalanceDTO({required this.ruby, required this.superRuby});

  BalanceDTO.jsonToObject(Map<String, dynamic> json)
      : ruby = json['ruby'] ?? 0,
        superRuby = json['superRuby'] ?? 0;
}

class TransactionDTO {
  final int amount;
  final String date;
  final String description;
  final String transactionId;

  final String type;

  TransactionDTO(
      {required this.type,
      required this.transactionId,
      required this.amount,
      required this.description,
      required this.date});

  TransactionDTO.jsonToObject(Map<String, dynamic> json)
      : amount = json["amount"],
        date = json["createdAt"],
        description = json["description"] ?? "REWARD",
        type = json["payment"] == "CREDIT" ? "+" : "-",
        transactionId = json["_id"];
}
