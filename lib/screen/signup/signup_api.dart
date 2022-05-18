import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:renderscan/common/config/http_config.dart';
import 'package:renderscan/screen/signup/signup_model.dart';

class SignUpApi {
  Future<SignUpResponse> registerUser(SignUpRequest request) async {
    try {
      final response = await http.post(
          HttpServerConfig().getHost("/v1/users/register"),
          headers: HttpServerConfig().headers,
          body: jsonEncode(request.toJson()));
      print(response.body);
      return SignUpResponse.fromJson(jsonDecode(response.body));
    } on SocketException {
      return SignUpResponse(
          hasError: true,
          message: "Internal Server Error, please try after sometime",
          status: 500);
    }
  }
}
