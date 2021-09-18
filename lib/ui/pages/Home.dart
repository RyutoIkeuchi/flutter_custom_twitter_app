import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/DrawerView.dart';
import 'package:oauth1/oauth1.dart' as oauth1;
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/templates/DrawerView.dart';

import '../../../config.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  dynamic _data = [];
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
    print(body[3]);
    print(body[5]);

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
                    BoxDecoration(border: Border.all(color: Colors.black26)),
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
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: Text(
                                      _data[index]['user']['name'],
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Flexible(
                                      child: Text(
                                    _data[index]['user']['screen_name'],
                                    style: TextStyle(
                                        fontSize: 11, color: Colors.grey),
                                  )),
                                ],
                              ),
                              Container(child: Text(_data[index]['text'])),
                              Image.network('http://pbs.twimg.com/media/E_jY9frVUAMAFVv.jpg')
                            ]))
                  ],
                )); // child: ListTile(title:Text('ああああ')));
          }),
    );
  }
}
