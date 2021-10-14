import 'package:flutter/material.dart';

Widget tweetUserName(String data) {
  return Text(
    data,
    style: TextStyle(
        fontSize: 13, color: Colors.black, fontWeight: FontWeight.bold),
    overflow: TextOverflow.ellipsis,
  );
}
