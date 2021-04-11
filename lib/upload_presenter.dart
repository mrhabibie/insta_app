import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UploadPresenter {
  File image;
  String caption;
  String errorMsg;
  String successMsg;

  UploadPresenter({this.image, this.caption, this.errorMsg, this.successMsg});

  factory UploadPresenter.successUpload(Map<String, dynamic> object) {
    return UploadPresenter(successMsg: object['message']);
  }

  factory UploadPresenter.errorUpload(Map<String, dynamic> object) {
    return UploadPresenter(errorMsg: object['message']);
  }

  static Future<UploadPresenter> doUpload(File image, String caption) async {
    final apiUrl = Uri.parse("https://api.samasama.co.uk/api/user/posts");

    final prefs = await SharedPreferences.getInstance();

    final Map<String, String> _headers = new Map<String, String>();
    _headers['Accept'] = 'application/json';
    _headers['Authorization'] = 'Bearer ' + prefs.getString('token');

    var request = http.MultipartRequest('POST', apiUrl)
      ..headers.addAll(_headers)
      ..fields['caption'] = caption
      ..files.add(await http.MultipartFile.fromPath('file', image.path));

    final streamedResponse =
        await request.send().timeout(Duration(seconds: 20));
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode > 200) {
      if (response.statusCode >= 300 && response.statusCode < 400) {
        return UploadPresenter.errorUpload(
            {'message': 'Error ' + response.statusCode.toString()});
      }
      return UploadPresenter.errorUpload(json.decode(response.body));
    } else {
      return UploadPresenter.successUpload(json.decode(response.body));
    }
  }
}
