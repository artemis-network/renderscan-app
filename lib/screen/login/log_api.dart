import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:renderscan/common/utils/logger.dart';
import 'package:renderscan/screen/login/login_model.dart';
import 'package:renderscan/common/config/http_config.dart';

class LoginApi {
  Future<AuthResponse> authenticateUser(AuthRequest request) async {
    try {
      final response = await http.post(
          HttpServerConfig().getHost("/v1/users/login"),
          headers: HttpServerConfig().headers,
          body: jsonEncode(request.toJson()));
      print(response.body);
      return AuthResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e);
      log.e(e);
      return AuthResponse(
          error: true,
          message: "Internal Server Error, Please try after some time");
    }
  }

  Future<AuthResponse> googleLogin(String email) async {
    try {
      log.i(email);
      var request = {"email": email, "client": "client0123"};
      final response = await http.post(
          HttpServerConfig().getHost("/v1/users/google-mobile-login"),
          headers: HttpServerConfig().headers,
          body: jsonEncode(request));
      return AuthResponse.fromJson(jsonDecode(response.body));
    } on Exception {
      return AuthResponse(
          error: true,
          message: "Internal Server Error, Please try after some time");
    }
  }
}
