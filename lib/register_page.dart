import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:insta_app/register_presenter.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _name = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _username = TextEditingController();
  TextEditingController _phone = TextEditingController();
  TextEditingController _dob = TextEditingController();
  String _gender;
  TextEditingController _password = TextEditingController();
  TextEditingController _passwordConfirmation = TextEditingController();
  bool _obscureText = true;
  bool _obscureTextTwo = true;
  RegisterPresenter _registerPresenter;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: ListView(
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(left: 50, top: 75, right: 50),
                child: Text(
                  "InstaApp",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.all(30),
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Column(
                    children: [
                      Container(
                        child: TextField(
                          controller: _name,
                          decoration: InputDecoration(
                            hintText: "Nama",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: TextField(
                          controller: _email,
                          decoration: InputDecoration(
                            hintText: "Email",
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
                          controller: _username,
                          decoration: InputDecoration(
                            hintText: "Username",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: TextField(
                          controller: _phone,
                          decoration: InputDecoration(
                            hintText: "Nomor Telepon",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          keyboardType: TextInputType.phone,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: TextField(
                          controller: _dob,
                          inputFormatters: [
                            MaskTextInputFormatter(
                                mask: '##/##/####',
                                filter: {'#': RegExp(r'[0-9]')}),
                          ],
                          decoration: InputDecoration(
                            hintText: "Tanggal Lahir",
                            suffixIcon: GestureDetector(
                              onTap: () {
                                DatePicker.showDatePicker(
                                  context,
                                  showTitleActions: true,
                                  minTime: DateTime(1900, 1, 1),
                                  maxTime: DateTime(DateTime.now().year,
                                      DateTime.now().month, DateTime.now().day),
                                  theme: DatePickerTheme(
                                    headerColor: Colors.orange,
                                    backgroundColor: Colors.blue,
                                    itemStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18),
                                    doneStyle: TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  onConfirm: (date) {
                                    _dob.text = date.day.toString() +
                                        '/' +
                                        date.month.toString() +
                                        '/' +
                                        date.year.toString();
                                    setState(() {});
                                  },
                                );
                              },
                              child: Icon(Icons.date_range),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 30),
                        child: DropdownButtonFormField(
                          decoration: InputDecoration(
                            hintText: "Jenis Kelamin",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          value: _gender,
                          onChanged: (value) {
                            _gender = value;
                            setState(() {});
                          },
                          items: <String>[
                            'Laki-laki',
                            'Perempuan',
                            'Tidak Tahu'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: TextField(
                          controller: _password,
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
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        child: TextField(
                          controller: _passwordConfirmation,
                          obscureText: _obscureTextTwo,
                          decoration: InputDecoration(
                            hintText: "Ulangi Kata Sandi",
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureTextTwo = !_obscureTextTwo;
                                });
                              },
                              child: Icon(
                                _obscureTextTwo
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
                          _registerPresenter != null &&
                                  _registerPresenter.errorMsg != null
                              ? _registerPresenter.errorMsg
                              : (_registerPresenter != null &&
                                      _registerPresenter.successMsg != null
                                  ? _registerPresenter.successMsg
                                  : ""),
                          style: TextStyle(
                              color: _registerPresenter != null &&
                                      _registerPresenter.errorMsg != null
                                  ? Colors.red
                                  : Colors.green),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 30),
                        child: ElevatedButton(
                          onPressed: () {
                            _registerPresenter = null;
                            setState(() {});

                            RegisterPresenter.doRegister(
                              _name.value.text,
                              _email.value.text,
                              _username.value.text,
                              _phone.value.text,
                              _dob.value.text,
                              _gender,
                              _password.value.text,
                            ).then((value) {
                              _registerPresenter = value;
                              setState(() {});
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(20)),
                          ),
                          child: Text(
                            "Daftar",
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
                                text: "Sudah punya akun? ",
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                  text: "Masuk",
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pop(context);
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
