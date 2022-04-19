import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renderscan/screen/login/login_dtos.dart';
import 'package:renderscan/common/config/http_config.dart';

class LoginApi {
  Future<LoginResponse> authenticateUser(LoginRequest request) async {
    final response = await http.post(
        HttpServerConfig().getHost("/users/authenticate"),
        headers: HttpServerConfig().headers,
        body: jsonEncode(request.toJson()));
    return LoginResponse.fromJson(jsonDecode(response.body));
  }
}
