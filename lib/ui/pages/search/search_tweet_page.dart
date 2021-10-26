import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:flutter_custom_twitter_app/services/search_tweet_api.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/retweet_card.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/tweet_card.dart';


class TweetTimelineData extends ChangeNotifier {
  List data = [];
  Future<dynamic> getTweetTimelineData(word) async {
    this.data = await getSearchTweetApi(word);
    notifyListeners();
  }

  Future<dynamic> refresh(word) async {
    this.data = await getSearchTweetApi(word);
    notifyListeners();
  }
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
            await TweetTimelineData().refresh(word);
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