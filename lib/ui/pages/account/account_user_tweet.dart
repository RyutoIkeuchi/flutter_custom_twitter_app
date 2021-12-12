import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/ViewModel/account_provider.dart';
import 'package:flutter_custom_twitter_app/models/home_timeline_tweet_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/tweet_card.dart';

class AccountUserTweet extends StatelessWidget {
  bool checkTextData(text) {
    var match = RegExp('^RT').hasMatch(text);
    if (match) {
      return true;
    } else {
      return false;
    }
  }

  final int index;

  AccountUserTweet({required this.index});
  Widget build(BuildContext context) {
    return Consumer(builder: (context, watch, _) {
      AsyncValue<List<HomeTimelineModel>> config = watch(accountTweetProvider);
      return config.when(
        data: (config) {
          return Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(color: Colors.black12, width: 1.0))),
              child: tweetCard(config[index]));
        },
        loading: () => CircularProgressIndicator(),
        error: (err, stack) => Text('Error: $err'),
      );
    });
  }
}
