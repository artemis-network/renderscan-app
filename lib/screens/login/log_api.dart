import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:renderscan/config/http_config.dart';
import 'package:renderscan/screens/login/login_model.dart';
import 'package:renderscan/utils/logger.dart';

class LoginApi {
  Future<AuthResponse> authenticateUser(AuthRequest request) async {
    try {
      final response = await http.post(
          HttpServerConfig().getHost("/users/login"),
          headers: HttpServerConfig().headers,
          body: jsonEncode(request.toJson()));
      print(response.body);
      return AuthResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      print(e);
      return AuthResponse(
          error: true,
          message: "Internal Server Error, Please try after some time");
    }
  }

  Future<AuthResponse> googleLogin(String email) async {
    try {
      var request = {"email": email};
      final response = await http.post(
          HttpServerConfig().getHost("/users/google-mobile-login"),
          body: request);
      log.i(response.body);
      return AuthResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      log.e(e);
      return AuthResponse(
          error: true,
          message: "Internal Server Error, Please try after some time");
    }
  }
}
