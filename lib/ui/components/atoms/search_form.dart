import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget searchForm(data, bool isWord) {
  void changeWord() {
    data._isWord = true;
  }

  return TextField(
    focusNode: data._focus,
    textInputAction: TextInputAction.search,
    onSubmitted: (str) {
      changeWord();
      // Navigator.push(data.context,
      //     MaterialPageRoute(builder: (context) => SearchTweetPage(e: str)));
    },
    style: TextStyle(
      height: 0.9,
      fontSize: 15,
    ),
    decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: Icon(Icons.search, size: 20),
        contentPadding: EdgeInsets.all(10.0),
        hintText: 'キーワード検索'),
  );
}
