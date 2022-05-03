import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renderscan/screen/login/login_model.dart';
import 'package:renderscan/common/config/http_config.dart';
import 'package:renderscan/screen/signup/signup_model.dart';

class LoginApi {
  Future<AuthResponse> authenticateUser(AuthRequest request) async {
    try {
      final response = await http.post(
          HttpServerConfig().getHost("users/authenticate"),
          headers: HttpServerConfig().headers,
          body: jsonEncode(request.toJson()));
      return AuthResponse.fromJson(jsonDecode(response.body));
    } on Exception {
      return AuthResponse(
          error: true,
          message: "Internal Server Error, Please try after some time");
    }
  }

  Future<AuthResponse> googleLogin(SignUpRequest request) async {
    try {
      final response = await http.post(
          HttpServerConfig().getHost("users/google-register"),
          headers: HttpServerConfig().headers,
          body: jsonEncode(request.toJson()));
      return AuthResponse.fromJson(jsonDecode(response.body));
    } on Exception {
      return AuthResponse(
          error: true,
          message: "Internal Server Error, Please try after some time");
    }
  }
}
