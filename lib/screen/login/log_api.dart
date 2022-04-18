import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renderscan/screen/login/login_dtos.dart';
import 'package:renderscan/common/utils/logger.dart';

Uri getHost(String host, String url) {
  if (host == "DEV") {
    return Uri.parse("http://192.168.1.14:5000" + url);
  }
  return Uri.parse("");
}

final headers = {
  "accept": "application/json",
  "content-type": "application/json"
};

const String server = "DEV";

class LoginApi {
  Future<LoginResponse> authenticateUser(LoginRequest request) async {
    final response = await http.post(getHost(server, "/users/authenticate"),
        headers: headers, body: jsonEncode(request.toJson()));
    return LoginResponse.fromJson(jsonDecode(response.body));
  }
}
