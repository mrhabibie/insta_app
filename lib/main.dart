import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:insta_app/bloc/post_bloc.dart';
import 'package:insta_app/login_page.dart';
import 'package:insta_app/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoggedIn = false;

  _checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('token') && prefs.getString('token') != '') {
      isLoggedIn = true;
    }
  }

  @override
  void initState() {
    _checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PostBloc>(
      create: (context) => PostBloc()..add(PostEvent()),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: isLoggedIn ? MainPage() : LoginPage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
