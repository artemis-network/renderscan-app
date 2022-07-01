import 'package:http/http.dart' as http;
import 'package:renderscan/common/utils/logger.dart';

class GenerateApi {
  generate(String input, String username) async {
    try {
      log.i(input + " " + username);

      var url =
          'https://hotpotmedia.s3.us-east-2.amazonaws.com/' + username + '.png';

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

      try {
        http.StreamedResponse response =
            await request.send().timeout(Duration(minutes: 2));
        if (response.statusCode == 200) {
          log.i(">> SUCCESS");
          return url;
        }
      } catch (e) {
        log.e("FROM INSIDE");
        log.e(e.toString());
      }
    } catch (e) {
      log.e(e.toString());
    }
  }
}
