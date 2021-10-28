import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/models/home_timeline_tweet_model.dart';
import 'package:flutter_custom_twitter_app/services/user_profile_api.dart';
import 'package:flutter_custom_twitter_app/services/user_tweet_api.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/retweet_card.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/tweet_card.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import "package:intl/intl.dart";

class UserProfileData extends ChangeNotifier {
  dynamic response;
  dynamic data;
  List<dynamic> tweet = [];
  Future<dynamic> getUserProfileData() async {
    this.response = await getUserProfileApi();
    this.data = response['includes']['users'][0];
    this.tweet = await getUserTweetApi();
    notifyListeners();
  }

  Future<dynamic> refresh() async {
    this.response = await getUserProfileApi();
    this.data = response['includes']['users'][0];
    this.tweet = await getUserTweetApi();
    notifyListeners();
  }
}

String tweetTimeDate(date) {
  initializeDateFormatting('ja');
  final changeDate = DateFormat("yyyy-MM-dd'T'hh:mm:ss.SSSZ").parse(date);
  final formatTime = DateFormat.yMMM('ja').format(changeDate);
  // print(formatTime);
  return '$formatTimeからTwitterを利用しています';
}

class DirectMessage extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProfileData>(
        create: (_) => UserProfileData()..getUserProfileData(),
        child: Scaffold(
            body: Consumer<UserProfileData>(builder: (context, model, child) {
          dynamic data = model.data;
          dynamic tweet = model.tweet;

          if (data == null) {
            return CircularProgressIndicator();
          }

          return RefreshIndicator(
              onRefresh: () async {
                await UserProfileData().refresh();
              },
              child: Column(
                children: [
                  Stack(children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 50),
                      width: MediaQuery.of(context).size.height * 1,
                      height: 130,
                      decoration: BoxDecoration(color: Colors.blue),
                    ),
                    Positioned(
                        top: 110,
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
                                  border:
                                      Border.all(color: Colors.white, width: 3),
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(32),
                                  child: Image.network(
                                      data['profile_image_url'],
                                      width: 64,
                                      height: 64,
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Container(
                                  padding: EdgeInsets.only(
                                      top: 3, right: 10, bottom: 3, left: 10),
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
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
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
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 12),
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
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Row(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 3),
                                        child: Text(
                                          data['public_metrics']
                                                  ['following_count']
                                              .toString(),
                                        ),
                                      ),
                                      Text(
                                        'フォロー中',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 12),
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
                                          data['public_metrics']
                                                  ['followers_count']
                                              .toString(),
                                        ),
                                      ),
                                      Text(
                                        'フォロワー',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: tweet.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              padding: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.black12, width: 1.0))),
                              child: !checkTextData(tweet[index]['text'])
                                  ? tweetCard(tweet[index])
                                  : reTweetCard(tweet[index]));
                        }),
                  )
                ],
              ));
        })));
  }
}
