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

Future<dynamic> getSearchTweetApi(word) async {
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
        'q': word,
        'lang': 'ja',
        'count': '50',
      },
    ),
  );
  // Map<String, dynamic> body = jsonDecode(res.body);
  // List<dynamic> data = body['statuses'];
  // print(data);
  if (res.statusCode == 200) {
    var jsonArray = jsonDecode(res.body);
    jsonArray = jsonArray['statuses'];
    final List<dynamic> data =
        jsonArray.map((model) => HomeTimelineModel.fromJson(model)).toList();
    //     List<dynamic> jsonArray(String str) =>
    // List<dynamic>.from(json.decode(str).map((x) => HomeTimelineModel.fromJson(x)));
    // List<Store> stores = [];
    // jsonArray.map((model) => Store.fromJson(model)).toList();
    // print(stores);
    var body = jsonEncode(data);
    dynamic aaa = jsonDecode(body);
    print(aaa);
    return aaa;
  } else {
    throw Exception('Failed to load album');
  }
}
