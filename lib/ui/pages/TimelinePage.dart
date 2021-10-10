import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/DrawerView.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import "package:intl/intl.dart";

import '../../services/Api.dart';
import '../components/templates/DrawerView.dart';

class Timeline extends StatefulWidget {
  @override
  _Timeline createState() => _Timeline();
}

class _Timeline extends State<Timeline> {
  dynamic _data = [];
  var dateNow = DateTime.now();

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

  @override
  void initState() async {
    super.initState();
    _data = await getApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: FaIcon(FontAwesomeIcons.twitter),
        ),
        drawer: DrawerView(),
        body: RefreshIndicator(
          onRefresh: () async {
            print('リフレッシュします');
            await getApi();
          },
          child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: _data.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom:
                              BorderSide(color: Colors.black12, width: 1.0))),
                  child: !checkTextData(_data[index]['text'])
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                              flex: 1,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.network(
                                    _data[index]['user']
                                        ['profile_image_url_https'],
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.fill),
                              ),
                            ),
                            Expanded(
                                flex: 4,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Flexible(
                                              flex: 11,
                                              child: Container(
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Flexible(
                                                      flex: 5,
                                                      child: Text(
                                                        _data[index]['user']
                                                            ['name'],
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Text(
                                                        '@' +
                                                            _data[index]['user']
                                                                ['screen_name'],
                                                        style: TextStyle(
                                                            fontSize: 11,
                                                            color:
                                                                Colors.black54),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        tweetTimeDate(
                                                            _data[index]
                                                                ['created_at']),
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.black54,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )),
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
                                      Container(
                                          child: Text(replaceText(
                                              _data[index]['text']))),
                                      Container(child: viewImage(_data[index])),
                                      Container(
                                        margin: EdgeInsets.only(top: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Expanded(
                                                child: FaIcon(
                                                    FontAwesomeIcons.commentAlt,
                                                    size: 18,
                                                    color: Colors.black45)),
                                            Expanded(
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.repeat,
                                                      color: Colors.black45,
                                                      size: 20.0,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 5),
                                                      child: Text(_data[index]
                                                              ['retweet_count']
                                                          .toString()),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.favorite_border,
                                                      color: Colors.black45,
                                                      size: 20.0,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 5),
                                                      child: Text(_data[index]
                                                              ['favorite_count']
                                                          .toString()),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Icon(
                                                Icons.file_upload_outlined,
                                                color: Colors.black45,
                                                size: 20.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]))
                          ],
                        )
                      : Column(
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
                                    '${_data[index]['user']['name']}さんがリツイート',
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
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                        _data[index]['retweeted_status']['user']
                                            ['profile_image_url_https'],
                                        width: 40,
                                        height: 40,
                                        fit: BoxFit.fill),
                                  ),
                                ),
                                Expanded(
                                    flex: 4,
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Flexible(
                                                  flex: 11,
                                                  child: Container(
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .end,
                                                      children: [
                                                        Flexible(
                                                          flex: 5,
                                                          child: Text(
                                                            _data[index][
                                                                        'entities']
                                                                    [
                                                                    'user_mentions']
                                                                [0]['name'],
                                                            style: TextStyle(
                                                                fontSize: 13,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        Flexible(
                                                          child: Text(
                                                            '@' +
                                                                _data[index][
                                                                            'entities']
                                                                        [
                                                                        'user_mentions'][0]
                                                                    [
                                                                    'screen_name'],
                                                            style: TextStyle(
                                                                fontSize: 11,
                                                                color: Colors
                                                                    .black54),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child: Text(
                                                            tweetTimeDate(_data[
                                                                    index]
                                                                ['created_at']),
                                                            style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .black54,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )),
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
                                          Container(
                                              child: Text(replaceText(
                                                  _data[index]['text']))),
                                          Container(
                                              child: viewImage(_data[index])),
                                          Container(
                                            margin: EdgeInsets.only(top: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                    child: FaIcon(
                                                        FontAwesomeIcons
                                                            .commentAlt,
                                                        size: 18,
                                                        color: Colors.black45)),
                                                Expanded(
                                                  child: Container(
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.repeat,
                                                          color: Colors.black45,
                                                          size: 20.0,
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 5),
                                                          child: Text(_data[
                                                                      index][
                                                                  'retweet_count']
                                                              .toString()),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons.favorite_border,
                                                          color: Colors.black45,
                                                          size: 20.0,
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 5),
                                                          child: Text(_data[
                                                                      index][
                                                                  'favorite_count']
                                                              .toString()),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  child: Icon(
                                                    Icons.file_upload_outlined,
                                                    color: Colors.black45,
                                                    size: 20.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ]))
                              ],
                            )
                          ],
                        ),
                ); // child: ListTile(title:Text('ああああ')));
              }),
        ));
  }
}
