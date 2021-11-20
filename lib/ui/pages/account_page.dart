import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/ViewModel/account_provider.dart';
import 'package:flutter_custom_twitter_app/ui/pages/account/account_info.dart';
import 'package:flutter_custom_twitter_app/ui/pages/account/account_user_tweet.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Account extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    AsyncValue<dynamic> config = watch(accountProfileProvider);
    return config.when(data: (config) {
      return Scaffold(
          body: RefreshIndicator(
              onRefresh: () async {
                await context.refresh(accountTweetProvider);
              },
              child: CustomScrollView(slivers: [
                SliverLayoutBuilder(
                  builder: (BuildContext context, constraints) {
                    final scrolled = constraints.scrollOffset > 160;
                    return SliverAppBar(
                      title:scrolled ? Text(config['name'],style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),) : null,
                      pinned: true,
                      primary: true,
                      toolbarHeight: 50,
                      collapsedHeight: 50,
                      expandedHeight: 60,
                    );
                  },
                ),
                SliverToBoxAdapter(child: AccountInfo()),
                SliverList(delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                  return AccountUserTweet(index: index);
                })),
              ])));
    },
    loading: () => CircularProgressIndicator(),
    error: (err, stack) => Text('Error: $err'),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final Color backgroundColor;
  final String _title;

  Delegate(this.backgroundColor, this._title);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
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
