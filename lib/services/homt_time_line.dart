import 'package:flutter_custom_twitter_app/models/home_timeline_model.dart';
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

Future<List<Set<HomeTimelineModel>>> getHomeTimelineData() async {
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

  if (res.statusCode == 200) {
    final List<dynamic> jsonArray = jsonDecode(res.body);
    return jsonArray.map((model) => {HomeTimelineModel.fromJson(model)}).toList();
  } else {
    throw Exception('Failed to load album');
  }
}