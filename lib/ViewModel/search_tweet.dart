import 'package:flutter_custom_twitter_app/services/search_tweet_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_custom_twitter_app/models/home_timeline_tweet_model.dart';

final searchTweetProvider= FutureProvider.family<List<HomeTimelineModel>,String>((ref, word) async {
  return await getSearchTweetApi(word);
});