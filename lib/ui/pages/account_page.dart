import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/services/user_profile_api.dart';
import 'package:flutter_custom_twitter_app/services/user_tweet_api.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/account_info.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/retweet_card.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/tweet_card.dart';
import 'package:provider/provider.dart';

class UserProfileData extends ChangeNotifier {
  dynamic response;
  dynamic data;
  List<dynamic> tweet = [];
  Future<dynamic> getUserProfileData() async {
    this.response = await getUserProfileApi();
    this.data = response['data'];
    this.tweet = await getUserTweetApi();
    notifyListeners();
  }

  Future<dynamic> refresh() async {
    this.response = await getUserProfileApi();
    this.data = response['data'];
    this.tweet = await getUserTweetApi();
    notifyListeners();
  }
}

class Account extends StatelessWidget {
  final dateNow = DateTime.now();

  bool checkTextData(text) {
    var match = RegExp('^RT').hasMatch(text);
    if (match) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserProfileData>(
        create: (context) => UserProfileData()..getUserProfileData(),
        child: Scaffold(
            body: Consumer<UserProfileData>(builder: (context, model, child) {
          dynamic data = model.data;
          dynamic tweet = model.tweet;

          if (data == null) {
            return CircularProgressIndicator();
          }

          return RefreshIndicator(
              onRefresh: () async {
                await UserProfileData().refresh();
              },
              child: CustomScrollView(slivers: [
                 SliverLayoutBuilder(
                    builder: (BuildContext context, constraints) {
                      final scrolled = constraints.scrollOffset > 160;
                      return SliverAppBar(
                        title:scrolled ? Text(data['name'],style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),) : null,
                        // backgroundColor:Colors.blue,
                        pinned: true,
                        primary: true,
                        toolbarHeight:50,
                        collapsedHeight: 50,
                        expandedHeight: 60,
                      );
                    },
                ),
                SliverToBoxAdapter(
                  child:accountInfo(data, context)
                ),
                SliverList(delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Colors.black12, width: 1.0))),
                      child: !checkTextData(tweet[index]['text'])
                          ? tweetCard(tweet[index])
                          : reTweetCard(tweet[index]));
                })),
              ]));
        })));
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final Color backgroundColor;
  final String _title;

  Delegate(this.backgroundColor, this._title);

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: backgroundColor,
      child: Center(
        child: Text(
          _title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}