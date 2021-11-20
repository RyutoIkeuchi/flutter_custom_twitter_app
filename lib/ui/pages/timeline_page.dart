import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/ViewModel/timeline_tweet_provider.dart';
import 'package:flutter_custom_twitter_app/ui/pages/look_tweet_page.dart';
import 'package:flutter_custom_twitter_app/ui/pages/post_tweet.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:flutter_custom_twitter_app/ui/components/templates/retweet_card.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/tweet_card.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/drawer_view.dart';
import '../components/templates/drawer_view.dart';

class Timeline extends ConsumerWidget {
  final dateNow = DateTime.now();

  bool checkTextData(text) {
    var match = RegExp('^RT').hasMatch(text);
    if (match) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    AsyncValue<dynamic> value = watch(homeTimelineProvider);
    return value.when(
      data: (value) {
        return Scaffold(
            appBar: AppBar(
              title: FaIcon(FontAwesomeIcons.twitter),
            ),
            drawer: DrawerView(),
            body: RefreshIndicator(
              onRefresh: () async {
                await context.refresh(homeTimelineProvider);
              },
              child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: value.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    color: Colors.black12, width: 1.0))),
                        child: TextButton(
                          style: TextButton.styleFrom(
                              primary: Colors.black87,
                              padding: EdgeInsets.all(10),
                              textStyle: TextStyle(fontSize: 14)),
                          child: !checkTextData(value[index]['text'])
                              ? tweetCard(value[index])
                              : reTweetCard(value[index]),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      LookTweetPage(data: value[index])),
                            );
                          },
                        ));
                  }),
            ),
            floatingActionButton: Container(
              margin: EdgeInsets.only(bottom: 50),
              child: FloatingActionButton(
                child: FaIcon(FontAwesomeIcons.feather),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PostTweet(),
                      fullscreenDialog: true,
                    ),
                  );
                },
              ),
            ));
      },
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}
