import 'package:flutter_custom_twitter_app/services/home_timeline_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// final repositoryProvider = Provider((ref) => Repository());

final homeTimelineProvider = FutureProvider<dynamic>((ref) async {
  return await getHomeTimelineData();
});
