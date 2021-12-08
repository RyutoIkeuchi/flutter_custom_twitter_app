import 'package:flutter_custom_twitter_app/Repositories/following_and_follower_repogitory.dart';
import 'package:flutter_custom_twitter_app/models/following_and_follower_model.dart';
import 'package:flutter_custom_twitter_app/services/user_follower_api.dart';
import 'package:flutter_custom_twitter_app/services/user_following_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final followingListProvider = FutureProvider<List<FollowingAndFollowerModel>>((ref) async {
  return await getUserFollowingApi();
});

final followerListProvider = FutureProvider<List<FollowingAndFollowerModel>>((ref) async {
  return await getUserFollowerApi();
});