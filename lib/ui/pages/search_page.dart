import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_twitter_app/ui/pages/search/search_trend_page.dart';
import 'package:flutter_custom_twitter_app/ui/pages/search/search_tweet_page.dart';

import 'package:flutter_custom_twitter_app/ui/components/atoms/search_screen.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  FocusNode _focus = new FocusNode();
  bool _isFocus = false;
  // bool _isWord = false;  
  
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }


  void _onFocusChange() {
    setState(() {
      _isFocus = _focus.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: 260,
          height: 40,
          child: TextField(
            maxLines: 1,
            focusNode: _focus,
            textInputAction: TextInputAction.search,
            onSubmitted: (word) {
              if (word != '') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SearchTweet(word: word)),
                );
              }
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
                onPressed: () {},
              )
            : null,
        actions: _isFocus
            ? [
                Container(
                  margin: EdgeInsets.only(left: 10, right: 20),
                  height: 40,
                  child: TextButton(
                    child: Text('キャンセル'),
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        FocusScope.of(context).unfocus();
                        _isFocus = false;
                      });
                    },
                  ),
                )
              ]
            : null,
      ),
      body: _isFocus ? searchScreen() : searchWordScreen(),
    );
  }
}
