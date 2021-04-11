import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:insta_app/post_presenter.dart';

class PostItem extends StatelessWidget {
  final PostPresenter post;

  PostItem(this.post);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.network(
                  "https://via.placeholder.com/150",
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
                ),
              ),
              Text(
                "Nama Orang",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {},
                child: Icon(Icons.more_vert),
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          child: ClipRRect(
            child: Image.network(
              post.image,
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.40,
              fit: BoxFit.contain,
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.favorite_outline,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(width: 15),
                  GestureDetector(
                    onTap: () {},
                    child: Icon(
                      Icons.chat_outlined,
                      size: 24,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Nama Orang ",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                        TextSpan(
                            text: post.caption,
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
