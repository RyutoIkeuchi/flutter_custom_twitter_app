import 'package:flutter_custom_twitter_app/models/trend_word_model.dart';
import 'package:flutter_custom_twitter_app/services/trend_word_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchTrendWordProvider = FutureProvider<List<TrendWordModel>>((ref) async {
  return await getTrendApi();
});