import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/ui/components/atoms/tweet_user_id.dart';
import 'package:flutter_custom_twitter_app/ui/components/atoms/tweet_user_name.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:flutter_custom_twitter_app/ui/components/atoms/user_icon.dart';
import 'package:flutter_custom_twitter_app/ui/components/organisms/tweet_info.dart';
import "package:intl/intl.dart";
import 'package:intl/date_symbol_data_local.dart';

String tweetTimeDate(date) {
  initializeDateFormatting('ja');
  final changeDate =
      new DateFormat('EEE MMM d HH:mm:ss +0000 yyyy').parse(date);
  final formatTime = DateFormat('HH:mm・y/M/d・').format(changeDate);
  return formatTime.toString();
}

class LookTweetPage extends StatelessWidget {
  final dynamic data;

  LookTweetPage({
    Key? key,
    this.data,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('ツイート')),
        body: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(bottom: 20),
                  child: Text(
                    'あああさんといいいさんがフォローしています',
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          flex: 10,
                          child: Row(
                            children: [
                              userIcon(data['profileImageUrl']),
                              Container(
                                  margin: EdgeInsets.only(left: 5),
                                  child: Column(
                                    children: [
                                      tweetUserName(data['userName']),
                                      tweetUserId(data['userId'])
                                    ],
                                  ))
                            ],
                          )),
                      Flexible(
                        flex: 2,
                        child: Container(
                            child: FaIcon(
                          FontAwesomeIcons.ellipsisH,
                          size: 16,
                          color: Colors.black12,
                        )),
                      ),
                    ],
                  ),
                ),
                Container(
                    child: Text(
                  replaceText(data['text']),
                  style: TextStyle(fontSize: 18),
                )),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: viewImage(data)
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Text(tweetTimeDate(data['createdAt']),style: TextStyle(color: Colors.black54),),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.only(bottom: 5,top: 5),
                  decoration: BoxDecoration(
                    border:  Border(
                      top:  BorderSide(
                        color: Colors.black45,
                        width: 0.5,
                      ),
                      bottom:  BorderSide(
                        color: Colors.black45,
                        width: 0.5,
                      ),
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text('${data['favoriteCount'].toString()}件のいいね'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: FaIcon(FontAwesomeIcons.commentAlt,size: 16, color: Colors.black45)
                    ),
                    Container(
                      child: Icon(
                        Icons.repeat,
                        color: Colors.black45,
                        size: 20.0,
                      ),
                    ),
                    Container(
                      child:Icon(
                        Icons.favorite_border,
                        color: Colors.black45,
                        size: 20.0,
                      ),
                    ),
                    Container(
                      child: Icon(
                        Icons.file_upload_outlined,
                        color: Colors.black45,
                        size: 20.0,
                      ),
                    ),
                  ],
                ),
              ],
            )));
  }
}
