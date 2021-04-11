import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_app/upload_presenter.dart';

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  TextEditingController caption = TextEditingController();
  File _image;
  final picker = ImagePicker();
  UploadPresenter _uploadPresenter;

  Future getImageFromCamera() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getImageFromGallery() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
              child: Container(
            child: new Wrap(
              children: <Widget>[
                new ListTile(
                  leading: new Icon(Icons.photo_library),
                  title: new Text('Photo Library'),
                  onTap: () {
                    getImageFromGallery();
                    Navigator.of(context).pop();
                  },
                ),
                new ListTile(
                  leading: new Icon(Icons.photo_camera),
                  title: new Text('Camera'),
                  onTap: () {
                    getImageFromCamera();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.check),
            tooltip: 'Done',
            onPressed: () {
              UploadPresenter.doUpload(_image, caption.value.text)
                  .then((value) {
                _uploadPresenter = value;
                setState(() {});

                if (_uploadPresenter != null) {
                  if (_uploadPresenter.errorMsg != null) {
                    Fluttertoast.showToast(
                        msg: _uploadPresenter.errorMsg,
                        toastLength: Toast.LENGTH_SHORT);
                  } else {
                    Navigator.pop(context);
                  }
                }
              });
            },
          ),
        ],
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Center(
              child: GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: _image != null
                    ? ClipRRect(
                        child: Image.file(
                          _image,
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * 0.60,
                          fit: BoxFit.contain,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(color: Colors.grey[200]),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.60,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                          size: 50,
                        ),
                      ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: TextField(
                controller: caption,
                onChanged: (value) {
                  setState(() {});
                },
                decoration: InputDecoration(
                  hintText: "Tulis caption...",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                ),
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
