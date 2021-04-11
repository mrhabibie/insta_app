import 'dart:convert';

import 'package:http/http.dart' as http;

class LoginPresenter {
  String email;
  String username;
  String token;
  String refreshToken;
  String errorMsg;

  LoginPresenter({
    this.email,
    this.username,
    this.token,
    this.refreshToken,
    this.errorMsg,
  });

  factory LoginPresenter.successLogin(Map<String, dynamic> object) {
    return LoginPresenter(
      email: object['email'],
      username: object['username'],
      token: object['access_token'],
      refreshToken: object['refresh_token'],
    );
  }

  factory LoginPresenter.errorLogin(Map<String, dynamic> object) {
    return LoginPresenter(
      email: null,
      username: null,
      token: null,
      refreshToken: null,
      errorMsg: object['message'],
    );
  }

  static Future<LoginPresenter> doLogin(
      String username, String password) async {
    var apiURL = Uri.parse("https://api.samasama.co.uk/api/auth/login");

    var response = await http.post(
      apiURL,
      body: {"username": username, "password": password},
    );

    var jsonObject = json.decode(response.body);

    if (response.statusCode >= 400) {
      return LoginPresenter.errorLogin(jsonObject);
    } else {
      return LoginPresenter.successLogin(jsonObject);
    }
  }
}
