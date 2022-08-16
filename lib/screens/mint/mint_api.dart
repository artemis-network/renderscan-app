import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renderscan/config/http_config.dart';
import 'package:renderscan/utils/storage.dart';

class MintApi {
  final String token =
      "SharedAccessSignature sr=https%3A%2F%2Frenderverse.servicebus.windows.net%2Fimagequeue&sig=IwyHKK5dtZmwchRij64HymOkGfik%2B9IQ2ULHEE2h7s4%3D&se=159331145413&skn=RootManageSharedAccessKey";

  Future<dynamic> drop(String fileUrl) async {
    try {
      // keep in config
      var username = await Storage().getItem("username");
      var containerName = "renderscan-images";
      var urlBuilder = "https://" +
          containerName +
          ".s3.ap-south-1.amazonaws.com/" +
          username.toString() +
          "/" +
          fileUrl;
      var brokerProperties = jsonEncode({'SessionId': username.toString()});
      Map<String, String> requestHeaders = {
        'Content-type': 'application/atom+xml;type=entry;charset=utf-8',
        'Prority': 'High',
        'BrokerProperties': brokerProperties,
        'Authorization': token
      };
      return await http.post(
          HttpServerConfig().azureServiceBusHost(
              "https://renderverse.servicebus.windows.net/imagequeue/messages"),
          headers: requestHeaders,
          body: urlBuilder);
    } on Exception {
      print("error");
    }
  }
}
