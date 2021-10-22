import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_twitter_app/models/home_timeline_model.dart';
import 'package:flutter_custom_twitter_app/services/home_time_line.dart';
import 'package:flutter_custom_twitter_app/services/search_tweet_api.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/retweet_card.dart';
import 'package:flutter_custom_twitter_app/ui/pages/search_tweet_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:flutter_custom_twitter_app/ui/components/templates/tweet_card.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/drawer_view.dart';
import '../../services/api.dart';
import '../components/templates/drawer_view.dart';

class TweetTimelineData extends ChangeNotifier {
  List<dynamic> data = [];
  Future<dynamic> getTweetTimelineData(word) async {
    this.data = await getSearchTweetApi(word);
    // this.data = await getApi();
    // print(data);
    notifyListeners();
  }

  Future<dynamic> refresh() async {
    this.data = await getSearchTweetApi('flutter');
    notifyListeners();
  }
}

class SearchTweetPage extends StatefulWidget {
  final String e;

  const SearchTweetPage({
    Key? key,
    required this.e,
  }) : super(key: key);

  @override
  _SearchTweetPageState createState() => _SearchTweetPageState(text: e);
}

class _SearchTweetPageState extends State<SearchTweetPage> {
  final  String text;
  _SearchTweetPageState({
    required this.text,
  });
  FocusNode _focus = new FocusNode();
  bool _isFocus = false;
  bool _word = false;
  String _text = '';
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

  void _handleText(String e) {
    setState(() {
      _text = e;
    });
  }

  void changeWord() {
    _word = true;
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
              onSubmitted: (e) {
                print(e);
                changeWord();
                TweetTimelineData()..getTweetTimelineData(e);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SearchTweetPage(e: _text,)));
              },
              onChanged: (String e) {
                setState(() {
                  _text = e;
                });
              },
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
          leading: !_isFocus
              ? IconButton(
                  icon: CircleAvatar(
                    child: Icon(Icons.people),
                    backgroundColor: Colors.red,
                    radius: 16,
                  ),
                  onPressed: () {
                    _isFocus = false;
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
        body: _isFocus ? searchForm() : searchTweet(text));
  }
}

Widget searchForm() {
  return Container(
    padding: EdgeInsets.all(10),
    child: Text('アカウント・トッピク、またはキーワードを検索してみましょう'),
  );
}

Widget searchTweet(e) {
  return ChangeNotifierProvider<TweetTimelineData>(
      create: (_) => TweetTimelineData()..getTweetTimelineData(e),
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
