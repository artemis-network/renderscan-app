import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renderscan/common/config/http_config.dart';
import 'package:renderscan/screen/signup/signup_model.dart';

class SignUpApi {
  Future<SignUpResponse> registerUser(SignUpRequest request) async {
    final response = await http.post(
        HttpServerConfig().getHost("/users/register"),
        headers: HttpServerConfig().headers,
        body: jsonEncode(request.toJson()));
    print(response.body);
    return SignUpResponse.fromJson(jsonDecode(response.body));
  }
}
