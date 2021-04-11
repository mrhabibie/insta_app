import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:insta_app/login_presenter.dart';
import 'package:insta_app/main_page.dart';
import 'package:insta_app/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _obscureText = true;
  LoginPresenter _loginPresenter;

  _setToken() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', _loginPresenter.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 50, top: 150, right: 50),
                child: Text(
                  "InstaApp",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.all(30),
                child: Container(
                  margin: EdgeInsets.only(top: 50),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: TextField(
                          controller: _email,
                          onChanged: (value) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            hintText: "Username / Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: TextField(
                          controller: _password,
                          onChanged: (value) {
                            setState(() {});
                          },
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            hintText: "Kata Sandi",
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10),
                        child: Text(
                          (_loginPresenter != null &&
                                  _loginPresenter.errorMsg != null
                              ? _loginPresenter.errorMsg
                              : ""),
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 30),
                        child: Text(
                          "Lupa kata sandi?",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.end,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 15),
                        child: ElevatedButton(
                          onPressed: () {
                            LoginPresenter.doLogin(
                              _email.value.text,
                              _password.value.text,
                            ).then((value) {
                              _loginPresenter = value;
                              setState(() {});
                              if (_loginPresenter.errorMsg == null) {
                                _setToken();
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) {
                                  return MainPage();
                                }));
                              }
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(20)),
                          ),
                          child: Text(
                            "Masuk",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 30),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Belum punya akun? ",
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                  text: "Daftar",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return RegisterPage();
                                      }));
                                    }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
