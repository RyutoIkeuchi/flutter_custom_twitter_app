import 'package:flutter_custom_twitter_app/models/home_timeline_tweet_model.dart';
import 'package:flutter_custom_twitter_app/models/user_profile_model.dart';
import 'package:flutter_custom_twitter_app/services/user_profile_api.dart';
import 'package:flutter_custom_twitter_app/services/user_tweet_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final accountProfileProvider = FutureProvider<UserProfileModel>((ref) async {
  return await getUserProfileApi();
});

final accountTweetProvider = FutureProvider<List<HomeTimelineModel>>((ref) async {
  return await getUserTweetApi();
});
