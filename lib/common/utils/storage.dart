import 'package:renderscan/screen/login/login_dtos.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  var storage = const FlutterSecureStorage();

  void createSession(LoginResponse response) {
    storage.write(key: "username", value: response.username);
    storage.write(key: "email", value: response.email);
    storage.write(key: "userId", value: response.userId.toString());
    storage.write(key: "publicToken", value: response.publicToken);
    storage.write(key: "accessToken", value: response.accessToken);
  }

  Future<String?> getItem(String key) async => await storage.read(key: key);
}
