import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renderscan/screen/login/login_model.dart';
import 'package:renderscan/common/config/http_config.dart';

class LoginApi {
  Future<AuthResponse> authenticateUser(AuthRequest request) async {
    final response = await http.post(
        HttpServerConfig().getHost("/users/authenticate"),
        headers: HttpServerConfig().headers,
        body: jsonEncode(request.toJson()));
    return AuthResponse.fromJson(jsonDecode(response.body));
  }
}
