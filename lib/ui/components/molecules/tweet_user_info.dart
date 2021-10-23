import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/ui/components/atoms/tweet_user_id.dart';
import 'package:flutter_custom_twitter_app/ui/components/atoms/tweet_user_name.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:intl/intl.dart";

String tweetTimeDate(date) {
  final formatTime =
      new DateFormat('EEE MMM d HH:mm:ss +0000 yyyy').parse(date);
  final japanTime = formatTime.add(Duration(hours: 9));
  final Duration difference = DateTime.now().difference(japanTime);
  final int sec = difference.inSeconds;

  if (sec >= 60 * 60 * 24) {
    return '・${difference.inDays.toString()}日前';
  } else if (sec >= 60 * 60) {
    return '・${difference.inHours.toString()}時間前';
  } else if (sec >= 60) {
    return '・${difference.inMinutes.toString()}分前';
  } else {
    return '・$sec秒前';
  }
}

Widget tweetUserInfo(dynamic data) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Flexible(
          flex: 11,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Flexible(
                  flex: 5,
                  child: tweetUserName(data['userName'])
                ),
                Flexible(
                  child: tweetUserId(data['userId'])
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    tweetTimeDate(data['createdAt']),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black54,
                    ),
                  ),
                ),
              ],
            ),      
      ),
      Flexible(
        child: Container(
            child: FaIcon(
              FontAwesomeIcons.ellipsisH,
              size: 16,
              color: Colors.black12,
            )
        ),
      ),
    ],
  );
}
