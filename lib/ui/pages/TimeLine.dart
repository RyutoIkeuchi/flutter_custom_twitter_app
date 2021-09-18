import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:oauth1/oauth1.dart' as oauth1;
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../config.dart';

class Timeline extends StatefulWidget {
  @override
  _Timeline createState() => _Timeline();
}

class _Timeline extends State<Timeline> {
  List<dynamic> _data = [];
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
        '/1.1/search/tweets.json',
        {
          'q': '阪神',
          'lang': 'ja',
          'count': '50',
        },
      ),
    );
    Map<String, dynamic> body = jsonDecode(res.body);
    List<dynamic> data = body['statuses'];
    setState(() {
      _data = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FaIcon(FontAwesomeIcons.twitter)
      ),
      body: ListView.builder(
          itemCount: _data.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color:Colors.black26)
              ),
              child:ListTile(
                title:Text(_data[index]['text'])
              )
            );
          }),
    );
  }
}
