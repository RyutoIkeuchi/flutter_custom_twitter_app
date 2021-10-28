import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/services/user_profile_api.dart';
import 'package:flutter_custom_twitter_app/services/user_tweet_api.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/retweet_card.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/tweet_card.dart';
import 'package:flutter_custom_twitter_app/ui/pages/account_page.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import "package:intl/intl.dart";

String tweetTimeDate(date) {
  initializeDateFormatting('ja');
  final changeDate = DateFormat("yyyy-MM-dd'T'hh:mm:ss.SSSZ").parse(date);
  final formatTime = DateFormat.yMMM('ja').format(changeDate);
  return '$formatTimeからTwitterを利用しています';
}

Widget accountInfo(data, context) {
  return Container(
    child:Column(children: [
    Stack(children: [
      Container(
        margin: EdgeInsets.only(bottom: 50),
        width: MediaQuery.of(context).size.height * 1,
        height: 20,
      ),
      Positioned(
          top: 0,
          width: MediaQuery.of(context).size.width * 1,
          child: Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 3),
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32),
                    child: Image.network(data['profile_image_url'],
                        width: 64, height: 64, fit: BoxFit.fill),
                  ),
                ),
                Container(
                    padding:
                        EdgeInsets.only(top: 3, right: 10, bottom: 3, left: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black87),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '変更',
                      style: TextStyle(fontSize: 12),
                    )),
              ],
            ),
          )),
    ]),
    Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            child: Text(
              data['name'],
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(bottom: 16),
            child: Text(
              "@${data['username']}",
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.black45),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(data['description']),
          ),
          Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 12,
                          color: Colors.black54,
                        ),
                        Text(
                          data['location'],
                          style: TextStyle(color: Colors.black54, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 12,
                          color: Colors.black54,
                        ),
                        Text(
                          tweetTimeDate(data['created_at']),
                          style: TextStyle(color: Colors.black54, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ],
              )),
          Container(
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 3),
                          child: Text(
                            data['public_metrics']['following_count']
                                .toString(),
                          ),
                        ),
                        Text(
                          'フォロー中',
                          style: TextStyle(color: Colors.black54, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 3),
                          child: Text(
                            data['public_metrics']['followers_count']
                                .toString(),
                          ),
                        ),
                        Text(
                          'フォロワー',
                          style: TextStyle(color: Colors.black54, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    ),
  ]));
}
