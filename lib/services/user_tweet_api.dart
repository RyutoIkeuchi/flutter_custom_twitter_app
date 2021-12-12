import 'package:flutter_custom_twitter_app/models/home_timeline_tweet_model.dart';
import 'package:oauth1/oauth1.dart' as oauth1;
import '../../../config.dart';
import 'dart:convert';

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

Future<List<HomeTimelineModel>> getUserTweetApi() async {
  final client = oauth1.Client(
    platform.signatureMethod,
    clientCredentials,
    oauth1.Credentials(
      ACCESS_TOKEN,
      ACCESS_TOKEN_SECRET,
    ),
  );

  final res = await client.get(
    Uri.parse(
        'https://api.twitter.com/1.1/statuses/user_timeline.json?user_id=1262567497795907584'),
  );

  final data = jsonDecode(res.body);
  return data.map<HomeTimelineModel>((model) => HomeTimelineModel.fromJson(model)).toList();
}
