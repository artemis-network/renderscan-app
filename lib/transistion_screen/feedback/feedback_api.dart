import 'dart:convert';

import 'package:renderscan/common/config/http_config.dart';
import 'package:renderscan/common/utils/logger.dart';
import 'package:renderscan/common/utils/storage.dart';
import 'package:http/http.dart' as http;

class FeedbackResponse {
  final bool error;
  final String message;

  FeedbackResponse({required this.error, required this.message});

  FeedbackResponse.jsonToObject(Map<String, dynamic> json)
      : error = json["error"],
        message = json["message"];
}

class FeedbackApi {
  Future<FeedbackResponse> sendFeedBack(
      String category, String ratings, String message) async {
    try {
      var userId = await Storage().getItem("userId");
      userId = userId.toString();
      var body = {
        "category": category,
        "ratings": ratings,
        "message": message,
        "user": userId
      };
      var response = await http
          .post(HttpServerConfig().getHost("/feedback/post"), body: body);
      var json = jsonDecode(response.body);
      return FeedbackResponse.jsonToObject(json);
    } catch (e) {
      log.e(e);
      return FeedbackResponse(error: true, message: "something went wrong");
    }
  }
}
