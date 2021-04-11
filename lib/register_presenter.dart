import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class RegisterPresenter {
  String name;
  String email;
  String username;
  String phone;
  String dob;
  String gender;
  String password;
  String errorMsg;
  String successMsg;

  RegisterPresenter({
    this.name,
    this.email,
    this.username,
    this.phone,
    this.dob,
    this.gender,
    this.password,
    this.errorMsg,
    this.successMsg,
  });

  factory RegisterPresenter.successRegister(Map<String, dynamic> object) {
    return RegisterPresenter(
      name: object['name'],
      email: object['email'],
      username: object['username'],
      phone: object['phone'],
      dob: object['dob'],
      gender: object['gender'],
      password: object['password'],
      successMsg: object['message'],
    );
  }

  factory RegisterPresenter.errorLogin(Map<String, dynamic> object) {
    return RegisterPresenter(
      name: null,
      email: null,
      username: null,
      phone: null,
      dob: null,
      gender: null,
      password: null,
      errorMsg: object['message'],
    );
  }

  static Future<RegisterPresenter> doRegister(
      String name,
      String email,
      String username,
      String phone,
      String dob,
      String gender,
      String password) async {
    final apiURL = Uri.parse("https://api.samasama.co.uk/api/auth/register");

    final Map<String, dynamic> _body = Map();
    _body['name'] = name;
    _body['email'] = email;
    _body['username'] = username;
    _body['phone'] = phone;
    _body['dob'] = dob;
    switch (gender.substring(0, 1)) {
      case 'L':
        gender = 'M';
        break;
      case 'P':
        gender = 'F';
        break;
      default:
        gender = 'U';
        break;
    }
    _body['gender'] = gender;
    _body['password'] = password;
    _body['password_confirmation'] = password;

    final _headers = {
      HttpHeaders.contentTypeHeader: 'application/json',
      HttpHeaders.acceptHeader: 'application/json',
    };

    final encoding = Encoding.getByName('utf-8');

    final _response = await http
        .post(apiURL,
            body: json.encode(_body), headers: _headers, encoding: encoding)
        .timeout(Duration(seconds: 20));

    if (_response.statusCode > 200) {
      if (_response.statusCode >= 300 && _response.statusCode < 400) {
        return RegisterPresenter.errorLogin(
            {'message': 'Error ' + _response.statusCode.toString()});
      }
      return RegisterPresenter.errorLogin(json.decode(_response.body));
    } else {
      return RegisterPresenter.successRegister(json.decode(_response.body));
    }
  }
}
