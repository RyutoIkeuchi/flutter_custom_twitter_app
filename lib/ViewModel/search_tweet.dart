import 'package:flutter_custom_twitter_app/services/search_tweet_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchTweetProvider= FutureProvider.family<dynamic,String>((ref, word) async {
  return await getSearchTweetApi(word);
});