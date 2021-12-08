import 'package:flutter_custom_twitter_app/models/following_and_follower_model.dart';
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

Future<List<FollowingAndFollowerModel>> getUserFollowerApi() async {
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
        'https://api.twitter.com/2/users/1262567497795907584/followers?max_results=50&user.fields=created_at,description,public_metrics,profile_image_url,location'),
  );

  if (res.statusCode == 200) {
    final dynamic jsonArray = json.decode(res.body);
    return jsonArray['data'].map<FollowingAndFollowerModel>((json) => FollowingAndFollowerModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load album');
  }
}
