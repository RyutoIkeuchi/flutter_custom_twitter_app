import 'package:flutter_custom_twitter_app/models/home_timeline_tweet_model.dart';
import 'package:flutter_custom_twitter_app/services/home_timeline_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// final repositoryProvider = Provider((ref) => Repository());

final homeTimelineProvider = FutureProvider<List<HomeTimelineModel>>((ref) async {
  return await getHomeTimelineData();
});
