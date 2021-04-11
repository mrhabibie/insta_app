import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class PostPresenter {
  int id;
  int userId;
  String caption;
  String image;
  String errorMsg;
  String successMsg;

  PostPresenter({
    this.id,
    this.userId,
    this.caption,
    this.image,
    this.errorMsg,
    this.successMsg,
  });

  static Future<List<PostPresenter>> doGet(
      String from, int page, int limit) async {
    final apiURL = Uri.parse("https://api.samasama.co.uk/api/user/posts?from=" +
        from +
        "&page=" +
        page.toString() +
        "&limit=" +
        limit.toString());
    final prefs = await SharedPreferences.getInstance();

    final _headers = {
      HttpHeaders.acceptHeader: 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ' + prefs.getString('token'),
    };

    final _response = await http
        .get(apiURL, headers: _headers)
        .timeout(Duration(seconds: 20));
    var jsonObject = json.decode(_response.body)['data'] as List;

    return jsonObject
        .map<PostPresenter>((item) => PostPresenter(
            id: item['id'],
            userId: item['user_id'],
            caption: item['caption'] != null ? item['caption'] : '',
            image: item['image']))
        .toList();
  }
}
