import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/models/home_timeline_tweet_model.dart';

import 'package:flutter_custom_twitter_app/ui/components/atoms/user_icon.dart';
import 'package:flutter_custom_twitter_app/ui/components/organisms/tweet_info.dart';

Widget tweetCard(HomeTimelineModel data) {
  return Column(children: [
    if(data.retweetedStatus) Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            flex: 2,
            child: Icon(
              Icons.repeat,
              color: Colors.black45,
              size: 12.0,
            ),
          ),
          Expanded(
            flex: 7,
            child: Text(
              '${data.retweetingUser}さんがリツイート',
              style: TextStyle(
                  fontSize: 10,
                  color: Colors.black54,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Flexible(flex: 1, child: userIcon(data.profileImageUrl)),
        Expanded(flex: 4, child: tweetInfo(data))
      ],
    )
  ]);
}
