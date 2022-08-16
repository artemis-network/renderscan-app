import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renderscan/config/http_config.dart';
import 'package:renderscan/utils/storage.dart';

class ProfileResponse {
  final String message;
  final bool error;

  ProfileResponse({required this.message, required this.error});

  ProfileResponse.jsonToObject(Map<String, dynamic> json)
      : message = json["message"] ?? "",
        error = json["error"] ?? false;
}

class Profile {
  final String displayName;
  final String region;
  final String language;
  final String email;

  Profile(
      {required this.displayName,
      required this.region,
      required this.language,
      required this.email});

  Profile.jsonToObject(Map<String, dynamic> json)
      : displayName = json["displayName"] ?? "",
        language = json["language"] ?? "",
        email = json["email"] ?? "",
        region = json["region"] ?? "";
}

class ProfileApi {
  Future<Profile> getProfile() async {
    try {
      final userId = await Storage().getItem("userId");
      final body = {"userId": userId.toString()};
      final request = await http
          .post(HttpServerConfig().getHost("/users/details"), body: body);
      final json = jsonDecode(request.body);
      return Profile.jsonToObject(json);
    } catch (e) {
      return new Profile(email: "", displayName: "", language: "", region: "");
    }
  }

  Future<ProfileResponse> updateProfile(Profile profile) async {
    try {
      final userId = await Storage().getItem("userId");
      final body = {
        "userId": userId,
        "displayName": profile.displayName,
        "language": profile.language,
        "region": profile.region
      };
      final request = await http
          .post(HttpServerConfig().getHost("/users/update"), body: body);
      final json = jsonDecode(request.body);
      return ProfileResponse.jsonToObject(json);
    } catch (e) {
      return new ProfileResponse(message: "Internal Server Error", error: true);
    }
  }

  Future<ProfileResponse> updateEmail(String email) async {
    var userId = await Storage().getItem("userId");
    userId = userId.toString();
    final body = {"userId": userId, "email": email};
    try {
      final request = await http
          .post(HttpServerConfig().getHost("/users/update-email"), body: body);
      final json = jsonDecode(request.body);
      return ProfileResponse.jsonToObject(json);
    } catch (e) {
      return ProfileResponse(message: "internal server error", error: true);
    }
  }

  Future<void> updateAvatar(file) async {
    try {
      var data = await file.readAsBytes();
      var userId = await Storage().getItem("userId");
      userId = userId.toString();
      var request = http.MultipartRequest(
          'POST', HttpServerConfig().getHost("/users/set-avatar"));
      request.fields['userId'] = userId;
      var pic =
          http.MultipartFile.fromBytes('avatar', data, filename: file.path);
      request.files.add(pic);
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      print(response);
    } on Exception {}
  }
}
