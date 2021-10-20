import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget tweetBottomView(dynamic data) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            child: FaIcon(FontAwesomeIcons.commentAlt,size: 18, color: Colors.black45)
        ),
        Expanded(
          child: Container(
            child: Row(
              children: [
                Icon(
                  Icons.repeat,
                  color: Colors.black45,
                  size: 20.0,
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(data['retweetCount'].toString()),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: Row(
              children: [
                Icon(
                  Icons.favorite_border,
                  color: Colors.black45,
                  size: 20.0,
                ),
                Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(data['favoriteCount'].toString()),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Icon(
            Icons.file_upload_outlined,
            color: Colors.black45,
            size: 20.0,
          ),
        ),
      ],
    ),
  );
}
