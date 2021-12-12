import 'package:flutter/material.dart';

Widget userIcon(data) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(data, width: 40, height: 40, fit: BoxFit.fill),
    ),
  );
}
