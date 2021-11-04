import 'package:flutter/material.dart';

import 'package:flutter_custom_twitter_app/ui/components/atoms/user_icon.dart';
import 'package:flutter_custom_twitter_app/ui/components/organisms/tweet_info.dart';
import 'package:flutter_custom_twitter_app/ui/pages/look_tweet_page.dart';

Widget tweetCard(dynamic data) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Flexible(flex: 1, child: userIcon(data['profileImageUrl'])),
      Expanded(flex: 4, child: tweetInfo(data))
    ],
  );
}
