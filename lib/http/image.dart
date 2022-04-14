import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

var url = Uri.parse('http://192.168.1.14:5001/cut');

cutImageFromServer(XFile file) async {
  var data = await file.readAsBytes();
  try {
    var request = http.MultipartRequest('POST', url);
    request.fields['username'] = 'akashmadduru';
    var pic = http.MultipartFile.fromBytes('data', data, filename: file.name);
    request.files.add(pic);
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    final result = jsonDecode(response.body) as Map<String, dynamic>;
    return result["file"];
  } catch (e) {
    int i = 10;
    i = i * 1;
  }
  // print('Response status: ${response.statusCode}');
  // print('Response body: ${response.body}');
}
