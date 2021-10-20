import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/ui/components/molecules/tweet_bottom_view.dart';
import 'package:flutter_custom_twitter_app/ui/components/molecules/tweet_user_info.dart';

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

dynamic viewImage(data) {
  if (RegExp(r'https?://[a-zA-Z0-9\-%_/=&?.]+').hasMatch(data['text'])) {
    if (data['entitiesMedia'] != null) {
      // print(data['entities']);
      if (data['entitiesMedia'].length >= 2) {
        return GridView.count(
          crossAxisCount: 2,
          children: <Widget>[
            data['entitiesMedia'].forEach((url) {
              return Container(
                  width: 20,
                  height: 20,
                  child: Image.network('media_url', fit: BoxFit.contain));
            })
          ],
        );
      }
      return Image.network(data['entitiesMedia'][0]['media_url'],
          fit: BoxFit.contain);
    }
    // else {
    //   return Text(data['entities']['urls'][0]['display_url']);
    // }
  } else {
    return Text('画像なし');
  }
}

Widget tweetInfo(dynamic data) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    tweetUserInfo(data),
    Container(child: Text(replaceText(data['text']))),
    Container(child: viewImage(data)),
    tweetBottomView(data)
  ]);
}
