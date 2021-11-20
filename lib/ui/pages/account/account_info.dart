import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/ViewModel/account_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import "package:intl/intl.dart";
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

String tweetTimeDate(date) {
  initializeDateFormatting('ja');
  final changeDate = DateFormat("yyyy-MM-dd'T'hh:mm:ss.SSSZ").parse(date);
  final formatTime = DateFormat.yMMM('ja').format(changeDate);
  return '$formatTimeからTwitterを利用しています';
}

class AccountInfo extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    AsyncValue<dynamic> config = watch(accountProfileProvider);
    return config.when(
      data: (config) {
        return Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.black54, width: 0.5))),
            child: Column(children: [
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
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                              child: Image.network(config['profile_image_url'],
                                  width: 64, height: 64, fit: BoxFit.fill),
                            ),
                          ),
                          TextButton(
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: 10, top: 3, right: 10, bottom: 3),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black87),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Container(
                                child: Text(
                                  '変更',
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.black87),
                                ),
                              ),
                            ),
                            onPressed: () => {
                              showCupertinoModalBottomSheet(
                                expand: true,
                                context: context,
                                // backgroundColor: Colors.transparent,
                                builder: (context) => Scaffold(
                                  appBar: AppBar(
                                    title: Text('変更',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold)),
                                    leading: OverflowBox(
                                      maxWidth: 200,
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Container(
                                            padding: EdgeInsets.only(left: 50),
                                            child: Text(
                                              "キャンセル",
                                              style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 17,
                                              ),
                                            ),
                                          )),
                                    ),
                                    backgroundColor: Colors.white,
                                  ),
                                  body: Column(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.black26,
                                                      width: 0.5))),
                                          child: Stack(
                                            children: [
                                              Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 50),
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.20,
                                                  decoration: BoxDecoration(
                                                    color: Colors.black26,
                                                  ),
                                                  child: Icon(
                                                    Icons.camera_alt_outlined,
                                                    color: Colors.white,
                                                    size: 40,
                                                  )),
                                              Positioned(
                                                top: 150,
                                                left: 20,
                                                child: Container(
                                                  width: 64,
                                                  height: 64,
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.white,
                                                          width: 3),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              32),
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              config[
                                                                  'profile_image_url']),
                                                          fit: BoxFit.cover)),
                                                  child: Center(
                                                      child: Icon(
                                                    Icons.camera_alt_outlined,
                                                    color: Colors.white,
                                                    size: 26,
                                                  )),
                                                ),
                                              )
                                            ],
                                          )),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 0.5,
                                                    color: Colors.black26))),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Container(
                                                  child: Text(
                                                    '名前',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12),
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 10,
                                                child: Container(
                                                    child: Text(config['name'],
                                                        style: TextStyle(
                                                            fontSize: 12))))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 0.5,
                                                    color: Colors.black26))),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Container(
                                                  child: Text(
                                                    '自己紹介',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12),
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 10,
                                                child: Container(
                                                    child: Text(
                                                  config['description'],
                                                  style:
                                                      TextStyle(fontSize: 12),
                                                )))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 0.5,
                                                    color: Colors.black26))),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Container(
                                                  child: Text(
                                                    '場所',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12),
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 10,
                                                child: Container(
                                                    child: Text('位置情報を追加',
                                                        style: TextStyle(
                                                            fontSize: 12))))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 0.5,
                                                    color: Colors.black26))),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Container(
                                                  child: Text(
                                                    'Web',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12),
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 10,
                                                child: Container(
                                                    child: Text('Webサイトを追加',
                                                        style: TextStyle(
                                                            fontSize: 12))))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            border: Border(
                                                bottom: BorderSide(
                                                    width: 0.5,
                                                    color: Colors.black26))),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 2,
                                                child: Container(
                                                  child: Text(
                                                    '生年月日',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12),
                                                  ),
                                                )),
                                            Expanded(
                                                flex: 10,
                                                child: Container(
                                                    child: Text('1999年12月28日',
                                                        style: TextStyle(
                                                            fontSize: 12))))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            },
                          ),
                        ],
                      ),
                    )),
              ]),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Text(
                        config['name'],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: EdgeInsets.only(bottom: 16),
                      child: Text(
                        "@${config['username']}",
                        textAlign: TextAlign.left,
                        style: TextStyle(color: Colors.black45, fontSize: 12),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        config['description'],
                        style: TextStyle(fontSize: 14),
                      ),
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
                                    config['location'],
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 12),
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
                                    tweetTimeDate(config['created_at']),
                                    style: TextStyle(
                                        color: Colors.black54, fontSize: 12),
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
                                  config['public_metrics']['following_count']
                                      .toString(),
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Text(
                                'フォロー中',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
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
                                  config['public_metrics']['followers_count']
                                      .toString(),
                                  style: TextStyle(fontSize: 14),
                                ),
                              ),
                              Text(
                                'フォロワー',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
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
      },
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}
