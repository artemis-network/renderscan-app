import 'package:path_provider/path_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:renderscan/screens/login/login_model.dart';

class Storage {
  var storage = const FlutterSecureStorage();

  void createSession(AuthResponse response) {
    storage.write(key: "username", value: response.username);
    storage.write(key: "email", value: response.email);
    storage.write(key: "userId", value: response.userId.toString());
    storage.write(key: "publicToken", value: response.publicToken);
    storage.write(key: "accessToken", value: response.accessToken);
  }

  Future<void> setFirstTime(bool setFirstTime) async {
    await storage.write(key: "isFirstTime", value: setFirstTime.toString());
  }

  Future<String?> isFirstTime() async => await storage.read(key: "isFirstTime");

  Future<String?> getItem(String key) async => await storage.read(key: key);
  Future<void> deleteItem(String key) async => await storage.delete(key: key);

  isUserLoggedIn() async {
    final isUserLoggedIn = await this.getItem("userId");
    if (isUserLoggedIn.toString().isNotEmpty) return true;
    return false;
  }

  check() async {
    return await storage.readAll();
  }

  void logout() async {
    await deleteItem("username").then((value) => null);
    await deleteItem("email").then((value) => null);
    await deleteItem("userId").then((value) => null);
    await deleteItem("publicToken").then((value) => null);
    await deleteItem("accessToken").then((value) => null);
    var tempDir = await getTemporaryDirectory();
    if (tempDir.existsSync()) tempDir.deleteSync(recursive: true);
    var appDocDir = await getApplicationDocumentsDirectory();
    if (appDocDir.existsSync()) appDocDir.deleteSync(recursive: true);
  }

  Future<bool> isLoggedIn() async {
    final username = await storage.read(key: "username");
    if (username != null) return true;
    return false;
  }
}
