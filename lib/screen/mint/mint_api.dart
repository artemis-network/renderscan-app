import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:renderscan/common/utils/storage.dart';
import 'package:renderscan/common/config/http_config.dart';

class MintApi {
  final String token =
      "SharedAccessSignature sr=https%3A%2F%2Frenderverse.servicebus.windows.net%2Fimagequeue&sig=IwyHKK5dtZmwchRij64HymOkGfik%2B9IQ2ULHEE2h7s4%3D&se=159331145413&skn=RootManageSharedAccessKey";

  Future<dynamic> drop(String filename) async {
    try {
      var username = await Storage().getItem("username");
      final imageUrl =
          'https://renderscanner.blob.core.windows.net/scans/$username/$filename';
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
          body: imageUrl);
    } on Exception {
      print("error");
    }
  }
}
