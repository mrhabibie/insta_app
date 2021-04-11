import 'package:flutter/material.dart';

class CommentPage extends StatefulWidget {
  @override
  _CommentPageState createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Comments')),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [

          ],
        ),
      ),
    );
  }
}
