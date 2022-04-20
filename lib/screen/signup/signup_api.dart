import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renderscan/common/config/http_config.dart';
import 'package:renderscan/common/dtos/auth_dto.dart';

class SignUpApi {
  Future<void> authenticateUser(AuthRequest request) async {
    final response = await http.post(
        HttpServerConfig().getHost("/users/register"),
        headers: HttpServerConfig().headers,
        body: jsonEncode(request.toJson()));
  }
}
