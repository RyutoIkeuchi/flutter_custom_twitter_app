// import 'package:flutter/material.dart';
// import 'package:oauth1/oauth1.dart' as oauth1;
// import 'package:url_launcher/url_launcher.dart';
//
// import '../config.dart';
//
// void OauthToken() {
//    final platform = oauth1.Platform(
//     'https://api.twitter.com/oauth/request_token',
//     'https://api.twitter.com/oauth/authorize',
//     'https://api.twitter.com/oauth/access_token',
//     oauth1.SignatureMethods.hmacSha1,
//   );
//   final clientCredentials = oauth1.ClientCredentials(
//     TWITTER_API_KEY,
//     TWITTER_API_KEY_SECRET,
//   );
//   late final auth = oauth1.Authorization(clientCredentials,platform);
//   oauth1.Credentials? tokenCredentials;
//
//   @override
//   void initState() {
//     // super.initState();
//
//     auth.requestTemporaryCredentials('oob').then((res) {
//       tokenCredentials = res.credentials;
//
//       launch(auth.getResourceOwnerAuthorizationURI(tokenCredentials!.token));
//     });
//   }
//
//
// }