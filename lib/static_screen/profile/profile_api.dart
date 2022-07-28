import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renderscan/common/config/http_config.dart';
import 'package:renderscan/common/utils/logger.dart';
import 'package:renderscan/common/utils/storage.dart';

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

  Profile(
      {required this.displayName,
      required this.region,
      required this.language});

  Profile.jsonToObject(Map<String, dynamic> json)
      : displayName = json["displayName"] ?? "",
        language = json["language"] ?? "",
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
      log.e(e);
      return new Profile(displayName: "", language: "", region: "");
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
      log.e(e);
      return new ProfileResponse(message: "Internal Server Error", error: true);
    }
  }
}
