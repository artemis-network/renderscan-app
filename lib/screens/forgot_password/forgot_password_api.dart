import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renderscan/config/http_config.dart';

class ForGotPasswordApi {
  Future<ForgotPasswordModel> sendForgotPasswordRequest(String email) async {
    try {
      var body = {"email": email};
      final uri = HttpServerConfig().getHost("/users/forgot-password/request");
      final response = await http.post(uri, body: body);
      return ForgotPasswordModel.jsonToOBject(jsonDecode(response.body));
    } catch (e) {
      throw e;
    }
  }
}

class ForgotPasswordModel {
  final bool isEmailSend;
  final String message;

  ForgotPasswordModel({required this.isEmailSend, required this.message});

  ForgotPasswordModel.jsonToOBject(Map<String, dynamic> json)
      : isEmailSend = json["isEmailSend"] ?? false,
        message = json["message"] ?? "";
}
