import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:oauth1/oauth1.dart' as oauth1;
import 'package:url_launcher/url_launcher.dart';

import '../config.dart';

class ApiToken extends StatefulWidget {
  @override
  _ApiTokenState createState() => _ApiTokenState();
}

class _ApiTokenState extends State<ApiToken> {
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

    auth.requestTemporaryCredentials('oob').then((res) {
      tokenCredentials = res.credentials;

      launch(auth.getResourceOwnerAuthorizationURI(tokenCredentials!.token));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      TextFormField(
        controller: controller,
      ),
      ElevatedButton(
        onPressed: () async {
          final pin = controller.text;
          final verifier = pin;
          final res =
              await auth.requestTokenCredentials(tokenCredentials!, verifier);
          print('Access Token: ${res.credentials.token}');
          print('Access Token Secret: ${res.credentials.tokenSecret}');

          final client = oauth1.Client(
            platform.signatureMethod,
            clientCredentials,
            res.credentials,
          );

          final apiResponse = await client.get(
            Uri.parse('https://api.twitter.com/1.1/statuses/home_timeline.json?count=1')
          );
          print(apiResponse.body);
        },
        child: Text('タップ'),
      )
    ])));
  }
}
