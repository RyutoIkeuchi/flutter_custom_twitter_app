import 'package:flutter_custom_twitter_app/models/user_profile_model.dart';
import 'package:flutter_custom_twitter_app/services/user_profile_api.dart';
import 'package:flutter_custom_twitter_app/services/user_tweet_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final accountProfileProvider = FutureProvider<UserProfileModel>((ref) async {
  final data = await getUserProfileApi();
  return data;
});

final accountTweetProvider = FutureProvider<dynamic>((ref) async {
  final data = await getUserTweetApi();
  return data;
});
