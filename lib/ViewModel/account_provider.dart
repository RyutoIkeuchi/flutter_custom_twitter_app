import 'package:flutter_custom_twitter_app/services/user_profile_api.dart';
import 'package:flutter_custom_twitter_app/services/user_tweet_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final accountProfileProvider = FutureProvider<dynamic>((ref) async {
  final data = await getUserProfileApi();
  return data['data'];
});

final accountTweetProvider = FutureProvider<dynamic>((ref) async {
  final data = await getUserTweetApi();
  return data;
});
