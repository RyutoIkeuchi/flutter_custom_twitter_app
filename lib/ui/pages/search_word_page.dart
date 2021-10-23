import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:flutter_custom_twitter_app/ui/components/atoms/search_screen.dart';
import 'package:flutter_custom_twitter_app/services/search_tweet_api.dart';
import 'package:flutter_custom_twitter_app/ui/pages/search_tweet_page.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/retweet_card.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/tweet_card.dart';

class TweetTimelineData extends ChangeNotifier {
  List data = [];
  Future<dynamic> getTweetTimelineData(word) async {
    this.data = await getSearchTweetApi(word);
    notifyListeners();
  }

  Future<dynamic> refresh() async {
    this.data = await getSearchTweetApi('flutter');
    notifyListeners();
  }
}

class Search extends StatefulWidget {
  final String? word;

  Search({
    Key? key,
    this.word,
  }) : super(key: key);

  @override
  _SearchState createState() => _SearchState(word: word);
}

class _SearchState extends State<Search> {
  final String? word;

  _SearchState({
    this.word,
  });

  FocusNode _focus = new FocusNode();
  bool _isFocus = false;
  bool _isWord = false;
  String _text = 'flutter';

  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
    if (word != null) {
      _isWord = true;
    }
    print('何も入っていないはず$word');
    print(_isWord);
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
              focusNode: _focus,
              textInputAction: TextInputAction.search,
              onChanged: (e) {
                setState(() {
                  _text = e;
                });
              },
              onSubmitted: (word) {
                if (word != '') {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Search(word: word)),
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
        body: Dismissible(
          direction: DismissDirection.horizontal,
          onDismissed: (DismissDirection direction) {
            setState(() {
              _isWord = false;
              print('スワイプしました');
            });
          },
          key: UniqueKey(),
          child: _isFocus
              ? searchScreen()
              : (_isWord ? searchTweet(_text) : searchWordScreen()),
        ));
  }
}

Widget searchWordScreen() {
  return Container(
    padding: EdgeInsets.all(20),
    child: Text('トレンドなどなど'),
  );
}

Widget searchTweet(String word) {
  return ChangeNotifierProvider<TweetTimelineData>(
      create: (_) => TweetTimelineData()..getTweetTimelineData(word),
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
                      : reTweetCard(data[index]),
                );
              }),
        );
      }));
}
