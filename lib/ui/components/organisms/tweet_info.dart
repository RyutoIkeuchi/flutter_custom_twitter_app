import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/ui/components/molecules/tweet_bottom_view.dart';
import 'package:flutter_custom_twitter_app/ui/components/molecules/tweet_user_info.dart';

String replaceText(text) {
  var result = text;
  var httpMatch = RegExp(r'https?://[a-zA-Z0-9\-%_/=&?.]+').hasMatch(result);
  if (httpMatch) {
    return result.replaceFirst(RegExp(r'https?://[a-zA-Z0-9\-%_/=&?.]+'), '');
  } else {
    return result;
  }
}

dynamic viewImage(data) {
  if (RegExp(r'https?://[a-zA-Z0-9\-%_/=&?.]+').hasMatch(data.text)) {
    if (data.entitiesMedia != null) {
      if (data.entitiesMedia.length >= 2) {
        print('2個以上ありました');
        return GridView.count(
          crossAxisCount: 2,
          children:[
            data.entitiesMedia.map((url) => 
              Image.network(url['media_url_https'], fit: BoxFit.contain),
            )
          ],
        );
      }
      return Image.network(data.entitiesMedia[0]['media_url_https'],
          fit: BoxFit.contain);
    }
    // else {
    //   return Text(data['entities']['urls'][0]['display_url']);
    // }
  } else {
    return Text('画像なし');
  }
}

Widget tweetInfo(data) {
  return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    tweetUserInfo(data),
    Container(child: Text(replaceText(data.text))),
    Container(child: viewImage(data)),
    tweetBottomView(data)
  ]);
}
