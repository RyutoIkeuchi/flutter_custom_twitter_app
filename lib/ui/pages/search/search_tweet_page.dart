import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/ViewModel/search_tweet.dart';
import 'package:flutter_custom_twitter_app/ViewModel/searchword_provider.dart';
import 'package:flutter_custom_twitter_app/models/home_timeline_tweet_model.dart';
import 'package:flutter_custom_twitter_app/ui/components/atoms/search_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_custom_twitter_app/ui/components/templates/tweet_card.dart';

class SearchTweet extends StatefulWidget {
  @override
  _SearchTweetState createState() => _SearchTweetState();
}

class _SearchTweetState extends State<SearchTweet> {
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
    return Scaffold(
      appBar: AppBar(
        title: Consumer(builder: (context, watch, child) {
          String word = watch(searchwordProvider).state;
          return Container(
            width: 260,
            height: 40,
            child: TextField(
              controller: TextEditingController(text: word),
              maxLines: 1,
              focusNode: _focus,
              textInputAction: TextInputAction.search,
              onSubmitted: (text) {
                if (text != '') {
                  context.read(searchwordProvider).state = text;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchTweet()),
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
                  hintText: '?????????????????????'),
            ),
          );
        }),
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
                    child: Text('???????????????'),
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
      body: _isFocus ? searchScreen() : SearchWordTweet(),
    );
  }
}

class SearchWordTweet extends ConsumerWidget {
  Widget build(BuildContext context, ScopedReader watch) {
    final String word = watch(searchwordProvider).state;
    AsyncValue<List<HomeTimelineModel>> value = watch(searchTweetProvider(word));
    return value.when(
      data: (value) {
        return Scaffold(
            body: RefreshIndicator(
                onRefresh: () async {
                  await context.refresh(searchTweetProvider(word));
                },
                child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: value.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.black12, width: 1.0))),
                        child:tweetCard(value[index])
                      );
                    })));
      },
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}
