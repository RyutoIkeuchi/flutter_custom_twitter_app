import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/retweet_card.dart';
import 'package:flutter_custom_twitter_app/ui/pages/search_tweet_page.dart';
import 'package:provider/provider.dart';

import 'package:flutter_custom_twitter_app/ui/components/templates/tweet_card.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  FocusNode _focus = new FocusNode();
  bool _isFocus = false;
  bool _isWord = false;

  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {
      _isFocus = _focus.hasFocus;
    });
  }

  // void _handleText(String e) {
  //   setState(() {
  //     _text = e;
  //   });
  // }

  void changeWord() {
    _isWord = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            width: 260,
            height: 40,
            child: TextField(
              focusNode: _focus,
              textInputAction: TextInputAction.search,
              onSubmitted: (str) {
                changeWord();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchTweetPage(e:str)));
              },
              style: TextStyle(
                height: 0.9,
                fontSize: 15,
              ),
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.search, size: 20),
                  contentPadding: EdgeInsets.all(10.0),
                  hintText: 'キーワード検索'),
            ),
          ),
          leading: !_isFocus
              ? IconButton(
                  icon: CircleAvatar(
                    child: Icon(Icons.people),
                    backgroundColor: Colors.red,
                    radius: 16,
                  ),
                  onPressed: () {
                    _isFocus = true;
                  },
                )
              : null,
          actions: _isFocus
              ? [
                  Container(
                      height: 40,
                      padding: EdgeInsets.only(top: 18),
                      margin: EdgeInsets.only(left: 10, right: 20),
                      child: Text('キャンセル'))
                ]
              : null,
        ),
        body: _isFocus ? searchForm() : searchWord());
  }
}

Widget searchWord() {
  return Container(
    padding: EdgeInsets.all(20),
    child: Text('検索してみましょう'),
  );
}

Widget searchForm() {
  return Container(
    padding: EdgeInsets.all(10),
    child: Text('アカウント・トッピク、またはキーワードを検索してみましょう'),
  );
}
