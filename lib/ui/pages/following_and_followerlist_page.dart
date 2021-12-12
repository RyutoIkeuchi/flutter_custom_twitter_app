import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/ViewModel/account_provider.dart';
import 'package:flutter_custom_twitter_app/ViewModel/following_and_follower_provider.dart';
import 'package:flutter_custom_twitter_app/models/following_and_follower_model.dart';
import 'package:flutter_custom_twitter_app/models/user_profile_model.dart';
import 'package:flutter_custom_twitter_app/ui/components/atoms/tweet_user_id.dart';
import 'package:flutter_custom_twitter_app/ui/components/atoms/tweet_user_name.dart';
import 'package:flutter_custom_twitter_app/ui/components/atoms/user_icon.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FollowingAndFollowerListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Consumer(builder: (context, watch, _) {
                AsyncValue<UserProfileModel> value =
                    watch(accountProfileProvider);
                return value.when(
                    data: (value) {
                      return Text(value.name,style: TextStyle(fontSize: 16),);
                    },
                    loading: () => CircularProgressIndicator(),
                    error: (err, stack) => Text('Error: $err'));
              }),
              bottom: TabBar(isScrollable: true, tabs: [
                Container(
                  alignment: Alignment.center,
                  width: width * 0.4,
                  child: Tab(text: 'フォロー中'),
                ),
                Container(
                  alignment: Alignment.center,
                  width: width * 0.4,
                  child: Tab(text: 'フォロワー'),
                ),
              ]),
            ),
            body: TabBarView(
              children: [
                FollowingView(),
                FollowerView(),
              ],
            )));
  }
}

class FollowingView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    AsyncValue<List<FollowingAndFollowerModel>> value =
        watch(followingListProvider);
    return value.when(
      data: (value) {
        return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: value.length,
            itemBuilder: (BuildContext context, int index) {
              if (index >= value.length - 1) {
                print('要素増やします');
              }
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                alignment: Alignment.topLeft,
                child: TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.black87,
                      padding: EdgeInsets.all(10),
                      textStyle: TextStyle(fontSize: 14)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      userIcon(value[index].profileImageUrl),
                      Expanded(
                          flex: 10,
                          child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 10,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            tweetUserName(value[index].name),
                                            tweetUserId(value[index].username)
                                          ],
                                        ),
                                      ),
                                      TextButton(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 10,
                                              top: 3,
                                              right: 10,
                                              bottom: 3),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black87),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Container(
                                            child: Text(
                                              'フォロー中',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black87),
                                            ),
                                          ),
                                        ),
                                        onPressed: () => {},
                                      ),
                                    ],
                                  ),
                                  Text(value[index].description)
                                ],
                              )))
                    ],
                  ),
                  onPressed: () {},
                ),
              );
            });
      },
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}

class FollowerView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    AsyncValue<List<FollowingAndFollowerModel>> value =
        watch(followerListProvider);
    return value.when(
      data: (value) {
        return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: value.length,
            itemBuilder: (BuildContext context, int index) {
              if (index >= value.length - 1) {
                print('要素増やします');
              }
              return Container(
                margin: EdgeInsets.only(bottom: 10),
                alignment: Alignment.topLeft,
                child: TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.black87,
                      padding: EdgeInsets.all(10),
                      textStyle: TextStyle(fontSize: 14)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      userIcon(value[index].profileImageUrl),
                      Expanded(
                          flex: 10,
                          child: Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Flexible(
                                        flex: 10,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            tweetUserName(value[index].name),
                                            tweetUserId(value[index].username)
                                          ],
                                        ),
                                      ),
                                      TextButton(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 10,
                                              top: 3,
                                              right: 10,
                                              bottom: 3),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black87),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Container(
                                            child: Text(
                                              'フォローする',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black87),
                                            ),
                                          ),
                                        ),
                                        onPressed: () => {},
                                      ),
                                    ],
                                  ),
                                  Text(value[index].description)
                                ],
                              )))
                    ],
                  ),
                  onPressed: () {},
                ),
              );
            });
      },
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}
