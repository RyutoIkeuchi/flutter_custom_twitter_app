import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/DrawerView.dart';
import 'package:oauth1/oauth1.dart' as oauth1;
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/templates/DrawerView.dart';
import "package:intl/intl.dart";

import '../../../config.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  dynamic _data = [];
  var dateNow = DateTime.now();

  String tweetTimeDate(date) {
    final formatTime = new DateFormat('EEE MMM d HH:mm:ss +0000 yyyy').parse(date);
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

  final controller = TextEditingController();
  final platform = oauth1.Platform(
    'https://api.twitter.com/oauth/request_token',
    'https://api.twitter.com/oauth/authorize',
    'https://api.twitter.com/oauth/access_token',
    oauth1.SignatureMethods.hmacSha1,
  );

  final clientCredentials = oauth1.ClientCredentials(
    TWITTER_API_KEY,
    TWITTER_API_KEY_SECRET,
  );

  late final auth = oauth1.Authorization(clientCredentials, platform);
  oauth1.Credentials? tokenCredentials;

  @override
  void initState() {
    super.initState();
    getApi();
  }

  Future<dynamic> getApi() async {
    // OauthToken();
    final client = oauth1.Client(
      platform.signatureMethod,
      clientCredentials,
      oauth1.Credentials(
        ACCESS_TOKEN,
        ACCESS_TOKEN_SECRET,
      ),
    );
    final res = await client.get(
      Uri.https(
        'api.twitter.com',
        '/1.1/statuses/home_timeline.json',
        {'count': '100'},
      ),
    );
    dynamic body = jsonDecode(res.body);

    dynamic data = body;
    setState(() {
      _data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FaIcon(FontAwesomeIcons.twitter),
      ),
      drawer: DrawerView(),
      body: ListView.builder(
          itemCount: _data.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                padding: EdgeInsets.all(10),
                decoration:
                    BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12,width: 1.0))),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Flexible(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                            _data[index]['user']['profile_image_url_https'],
                            width: 40,
                            height: 40,
                            fit: BoxFit.fill),
                      ),
                    ),
                    Expanded(
                        flex: 4,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 11,
                                    child:Container(
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,

                                        children: [
                                          Flexible(
                                            flex: 5,
                                            child: Text(
                                              _data[index]['user']['name'],
                                              style: TextStyle(
                                                  fontSize: 13,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                            '@'+_data[index]['user']['screen_name'],
                                            style: TextStyle(
                                                fontSize: 11, color: Colors.black54),
                                            overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Text(tweetTimeDate(_data[index]['created_at']),
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black54,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ),
                                  Flexible(
                                    child: Container(
                                      child: FaIcon(FontAwesomeIcons.ellipsisH,size: 16,color: Colors.black12,)
                                    ),
                                  ),
                                  
                                ],
                              ),
                              Container(child: Text(_data[index]['text'])),
                              Container(
                                margin: EdgeInsets.only(top:10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child:FaIcon(FontAwesomeIcons.commentAlt,size: 18,color: Colors.black45)
                                    ),
                                    Expanded(
                                      child:Container(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.repeat,
                                              color: Colors.black45,
                                              size: 20.0,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 5),
                                              child:Text(_data[index]['retweet_count'].toString()),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                   Expanded(
                                    child:Container(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.favorite_border,
                                            color: Colors.black45,
                                            size: 20.0,
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(left: 5),
                                            child:Text(_data[index]['favorite_count'].toString()),
                                          ),
                                        ],
                                      ),
                                    ),
                                     
                                   ),
                                   Expanded(
                                     child:Icon(
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
                )); // child: ListTile(title:Text('ああああ')));
          }),
    );
  }
}
