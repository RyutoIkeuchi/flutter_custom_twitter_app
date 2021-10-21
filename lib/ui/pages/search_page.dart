import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_twitter_app/models/home_timeline_model.dart';
import 'package:flutter_custom_twitter_app/services/home_time_line.dart';
import 'package:flutter_custom_twitter_app/services/search_tweet_api.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/retweet_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:flutter_custom_twitter_app/ui/components/templates/tweet_card.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/drawer_view.dart';
import '../../services/api.dart';
import '../components/templates/drawer_view.dart';

class TweetTimelineData extends ChangeNotifier {
  List<dynamic> data = [];
  Future<dynamic> getTweetTimelineData() async {
    this.data = await getSearchTweetApi();
    // this.data = await getApi();
    // print(data);
    notifyListeners();
  }

  Future<dynamic> refresh() async {
    this.data = await getSearchTweetApi();
    notifyListeners();
  }
}

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  FocusNode _focus = new FocusNode();
  bool _isFocus = false;
  final dateNow = DateTime.now();

  bool checkTextData(text) {
    var match = RegExp('^RT').hasMatch(text);
    if (match) {
      return true;
    } else {
      return false;
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: 260,
          height: 40,
          // padding:EdgeInsets.only(right: 10, bottom: 30, left: 10),s
          child: TextField(
            focusNode: _focus,
            textInputAction: TextInputAction.search,
            style: TextStyle(
              height: 0.9,
              fontSize: 15,
            ),
            decoration: InputDecoration(
                // border: InputBorder.none,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                fillColor: Colors.white,
                filled: true,
                prefixIcon: Icon(Icons.search, size: 20),
                contentPadding: EdgeInsets.all(10.0),
                hintText: 'キーワード検索'),
          ),
        ),
        leading: _isFocus ? IconButton(
          icon: CircleAvatar(
            child: Icon(Icons.people),
            backgroundColor: Colors.red,
            radius: 16,
          ),
          onPressed: () {},
        ) : null,
        actions: _isFocus ? null : [
          Container(
            height: 40,
            padding: EdgeInsets.only(top: 18),
            margin: EdgeInsets.only(left: 10,right: 20),
            child: Text('キャンセル')
          )
        ],
      ),
      body: _isFocus
          ? searchTweet()
          : searchForm()
    );
  }
}

Widget searchForm() {
  return Container(
    padding: EdgeInsets.all(10),
    child: Text('アカウント・トッピク、またはキーワードを検索してみましょう'),
  );
}

Widget searchTweet() {
  return ChangeNotifierProvider<TweetTimelineData>(
      create: (_) => TweetTimelineData()..getTweetTimelineData(),
      child: Consumer<TweetTimelineData>(builder: (context, model, child) {
        List<dynamic> data = model.data;
        if (data == []) {
          return CircularProgressIndicator();
        }
        return RefreshIndicator(
          onRefresh: () async {
            print('リフレッシュします');
            await TweetTimelineData().refresh();
          },
          child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom:
                                BorderSide(color: Colors.black12, width: 1.0))),
                    child: !checkTextData(data[index]['text'])
                        ? tweetCard(data[index])
                        : reTweetCard(data[index]));
              }),
        );
      }));
}
