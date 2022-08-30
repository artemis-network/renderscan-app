import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:renderscan/config/http_config.dart';
import 'package:renderscan/utils/logger.dart';
import 'package:renderscan/utils/storage.dart';

class GenerateApi {
  generate(String input) async {
    var username = "akash";
    var url =
        'https://hotpotmedia.s3.us-east-2.amazonaws.com/' + username + '.png';

    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('https://cortex.hotpot.ai/latent-test'));
      request.fields.addAll({
        'inputText': input,
        'outputWidth': '256',
        'outputHeight': '256',
        'numIterations': '200',
        'style': 'hotpotArt1',
        'substyle': 'null',
        'styleLabel': 'Hotpot Art 1',
        'requestId': username,
        'resultUrl': url
      });
      http.StreamedResponse response =
          await request.send().timeout(Duration(minutes: 2));
      if (response.statusCode == 200) return;
    } catch (e) {
    } finally {
      final t =
          Future.delayed(Duration(minutes: 1), () => http.get(Uri.parse(url)));
      return await t.then((value) => value.bodyBytes);
    }
  }

  Future<Uint8List> addBackgroundImage(Uint8List data, String color) async {
    try {
      var username = await Storage().getItem("username");
      final filename = DateTime.now().toString() + username.toString();
      var request = http.MultipartRequest(
        'POST',
        HttpServerConfig().getHost("/images/background"),
      );
      request.fields["background"] = color;
      var pic = http.MultipartFile.fromBytes('data', data, filename: filename);
      request.files.add(pic);
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      var json = jsonDecode(response.body);
      var image = json["Image"].toString();
      image = image.replaceAll("data:image/png;base64,", "");
      log.i(image);
      Uint8List bytes = base64Decode(image);
      return bytes;
    } catch (err) {
      log.e(err);
      throw err;
    }
  }

  saveImage(Uint8List data, String type) async {
    try {
      var username = await Storage().getItem("username");
      log.i(">> username logging :" + username.toString());
      final filename = DateTime.now().toString() + username.toString();
      log.i(">> filename logging :" + filename);
      var request = http.MultipartRequest(
        'POST',
        HttpServerConfig().getHost("/images/save-generate-image"),
      );
      request.fields["username"] = username.toString();
      request.fields["type"] = type;
      var pic = http.MultipartFile.fromBytes('data', data, filename: filename);
      log.i("request body");
      log.i(request);
      request.files.add(pic);
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      log.i(response.body.toString());
    } catch (err) {
      log.e(err);
    }
  }

  refresh() async {
    var username = await Storage().getItem("username");
    final u = username.toString();
    var url = 'https://hotpotmedia.s3.us-east-2.amazonaws.com/' + u + '.png';
    return Uri.parse(url);
  }
}
