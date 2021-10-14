import 'package:flutter/material.dart';

Widget userIcon(String data) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: Image.network(
      data,
      width: 40, height: 40, fit: BoxFit.fill
    ),
  );
}
