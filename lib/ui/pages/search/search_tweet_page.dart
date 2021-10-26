import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/ui/components/atoms/search_screen.dart';
import 'package:provider/provider.dart';

import 'package:flutter_custom_twitter_app/services/search_tweet_api.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/retweet_card.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/tweet_card.dart';


class SearchTweetData extends ChangeNotifier {
  List data = [];
  Future<dynamic> getSearchTweetData(word) async {
    this.data = await getSearchTweetApi(word);
    notifyListeners();
  }

  Future<dynamic> refresh(word) async {
    this.data = await getSearchTweetApi(word);
    notifyListeners();
  }
}

class SearchTweet extends StatefulWidget {
  final String? word;

  SearchTweet({
    Key? key,
    this.word,
  }) : super(key: key);

  @override
  _SearchTweetState createState() => _SearchTweetState(word: word);
}

class _SearchTweetState extends State<SearchTweet> {
  final String? word;

  _SearchTweetState({
    this.word,
  });

  FocusNode _focus = new FocusNode();
  bool _isFocus = false;

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
    final controller = TextEditingController();
    controller.text = (word != null ? word : '')!;
    return Scaffold(
        appBar: AppBar(
          title: Container(
            width: 260,
            height: 40,
            child: TextField(
              controller: controller,
              maxLines: 1,
              focusNode: _focus,
              textInputAction: TextInputAction.search,
              onSubmitted: (word) {
                if (word != '') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchTweet(word: word)),
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
        body: _isFocus ? searchScreen() : searchTweet(word!),
        );
  }
}


Widget searchTweet(String word) {
  return ChangeNotifierProvider<SearchTweetData>(
      create: (_) => SearchTweetData()..getSearchTweetData(word),
      child: Consumer<SearchTweetData>(builder: (context, model, child) {
        List<dynamic> data = model.data;
        if (data == []) {
          return CircularProgressIndicator();
        }
        return RefreshIndicator(
          onRefresh: () async {
            await SearchTweetData().refresh(word);
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
                              BorderSide(color: Colors.black12, width: 1.0))
                  ),
                  child: !checkTextData(data[index]['text'])
                      ? tweetCard(data[index])
                      : reTweetCard(data[index]),
                );
              }
          ),
        );
      })
  );
}