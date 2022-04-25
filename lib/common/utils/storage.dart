import 'package:renderscan/common/dtos/auth_dto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Storage {
  var storage = const FlutterSecureStorage();

  void createSession(AuthResponse response) {
    storage.write(key: "username", value: response.username);
    storage.write(key: "email", value: response.email);
    storage.write(key: "userId", value: response.userId.toString());
    storage.write(key: "publicToken", value: response.publicToken);
    storage.write(key: "accessToken", value: response.accessToken);
  }

  Future<String?> getItem(String key) async => await storage.read(key: key);
  Future<void> deleteItem(String key) async => await storage.delete(key: key);

  void logout() async {
    await deleteItem("username").then((value) => null);
    await deleteItem("email").then((value) => null);
    await deleteItem("userId").then((value) => null);
    await deleteItem("publicToken").then((value) => null);
    await deleteItem("accessToken").then((value) => null);
  }
}
