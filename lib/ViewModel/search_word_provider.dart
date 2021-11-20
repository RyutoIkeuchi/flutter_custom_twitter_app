import 'package:flutter_custom_twitter_app/services/trend_word_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchTrendWordProvider = FutureProvider<dynamic>((ref) async {
  return await getTrendApi();
});