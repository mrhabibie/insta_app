import 'package:flutter/material.dart';
import 'package:insta_app/media.dart';
import 'package:insta_app/picker/selection.dart';
import 'package:insta_app/picker/thumbnail.dart';

class SelectionGrid extends StatelessWidget {
  final MediaPickerSelection selection;

  const SelectionGrid({
    @required this.selection,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: selection == null || selection.selectedMedias.isEmpty
          ? Text("No selection")
          : Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: <Widget>[
                ...selection.selectedMedias.map<Widget>(
                  (x) => GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MediaViewerPage(media: x),
                        ),
                      );
                    },
                    child: SizedBox(
                      width: 128,
                      height: 128,
                      child: MediaThumbnailImage(media: x),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
