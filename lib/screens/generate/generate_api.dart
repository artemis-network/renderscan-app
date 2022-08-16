import 'package:http/http.dart' as http;

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

  refresh() {
    var username = "akash";
    var url =
        'https://hotpotmedia.s3.us-east-2.amazonaws.com/' + username + '.png';
    return Uri.parse(url);
  }
}
