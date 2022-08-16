import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:renderscan/config/http_config.dart';
import 'package:renderscan/utils/storage.dart';

class NotificationC {
  final String message;
  final String notification;
  final bool hasNotification;
  final String userId;

  NotificationC(
      {required this.message,
      required this.hasNotification,
      required this.notification,
      required this.userId});

  NotificationC.jsonToObject(Map<String, dynamic> json)
      : hasNotification = json["hasNotification"],
        message = json["message"],
        notification = json["notification"],
        userId = json["userId"] ?? "";

  objectToJson() {
    var data = {
      "message": message,
      "notificatioCn": notification,
      "hasNotification": hasNotification,
      "userId": userId
    };
    return data;
  }
}

class NotificationApi {
  Future<NotificationC> getNotification() async {
    try {
      var userId = await Storage().getItem("userId");
      userId = userId.toString();
      var body = {"userId": userId};
      var response = await http.post(
          HttpServerConfig().getHost("/payments/notifications"),
          body: body);
      var json = jsonDecode(response.body);
      return NotificationC.jsonToObject(json);
    } catch (e) {
      return NotificationC(
          message: "", hasNotification: false, notification: "", userId: "");
    }
  }

  Future<NotificationC> closeNotification() async {
    try {
      var userId = await Storage().getItem("userId");
      userId = userId.toString();

      final notification = NotificationC(
          hasNotification: false,
          message: "",
          notification: "",
          userId: userId);
      final body = notification.objectToJson();
      var response = await http.post(
          HttpServerConfig().getHost("/payments/notifications/update"),
          body: body);
      var json = jsonDecode(response.body);
      return NotificationC.jsonToObject(json);
    } catch (e) {
      return NotificationC(
          message: "", hasNotification: false, notification: "", userId: "");
    }
  }
}
