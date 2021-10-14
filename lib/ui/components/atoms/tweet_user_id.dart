import 'package:flutter/material.dart';

Widget tweetUserId(String data) {
  return Text(
    '@$data',
    style: TextStyle(fontSize: 11, color: Colors.black54),
    overflow: TextOverflow.ellipsis,
  );
}
