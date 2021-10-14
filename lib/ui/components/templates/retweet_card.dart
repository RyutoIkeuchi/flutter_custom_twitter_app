import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/ui/components/atoms/tweet_user_id.dart';
import 'package:flutter_custom_twitter_app/ui/components/atoms/tweet_user_name.dart';
import 'package:flutter_custom_twitter_app/ui/components/atoms/user_icon.dart';
import 'package:flutter_custom_twitter_app/ui/components/molecules/tweet_bottom_view.dart';
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

String replaceText(text) {
  var rtMatch = RegExp('^RT').hasMatch(text);
  var result = text;
  if (rtMatch) {
    result = result.replaceAll(RegExp(r'^RT\s@\w*:'), '');
  }
  var httpMatch = RegExp(r'https?://[a-zA-Z0-9\-%_/=&?.]+').hasMatch(result);
  if (httpMatch) {
    return result.replaceFirst(RegExp(r'https?://[a-zA-Z0-9\-%_/=&?.]+'), '');
  } else {
    return result;
  }
}

bool checkTextData(text) {
  var match = RegExp('^RT').hasMatch(text);
  if (match) {
    return true;
  } else {
    return false;
  }
}

dynamic viewImage(data) {
  if (RegExp(r'https?://[a-zA-Z0-9\-%_/=&?.]+').hasMatch(data['text'])) {
    if (data['entities']['media'] != null) {
      // print(data['entities']);
      if (data['entities']['media'].length >= 2) {
        return GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            data['entities']['media'].forEach((url) {
              return Container(
                  width: 20,
                  height: 20,
                  child: Image.network('media_url', fit: BoxFit.contain));
            })
          ],
        );
      }
      return Image.network(data['entities']['media'][0]['media_url'],
          fit: BoxFit.contain);
    }
    // else {
    //   return Text(data['entities']['urls'][0]['display_url']);
    // }
  } else {
    return Text('画像なし');
  }
}

Widget reTweetCard(dynamic data) {
  // print(data);
  return Column(
    children: [
      Row(
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
              '${data['user']['name']}さんがリツイート',
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
          Flexible(
            flex: 1,
            child: userIcon(data['retweeted_status']['user']['profile_image_url_https'])
          ),
          Expanded(
              flex: 4,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                            flex: 11,
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Flexible(
                                    flex: 5,
                                    child: tweetUserName(data['entities']['user_mentions'][0]['name'])
                                  ),
                                  Flexible(
                                    child:tweetUserId(data['user']['screen_name'])
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      tweetTimeDate(data['created_at']),
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
                          )),
                        ),
                      ],
                    ),
                    Container(child: Text(replaceText(data['text']))),
                    Container(child: viewImage(data)),
                    tweetBottomView(data),
                  ]))
        ],
      )
    ],
  );
}

