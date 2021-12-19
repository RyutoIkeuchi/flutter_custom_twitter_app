import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/ViewModel/account_provider.dart';
import 'package:flutter_custom_twitter_app/models/user_profile_model.dart';
import 'package:flutter_custom_twitter_app/services/const/drawer_listview.dart';
import 'package:flutter_custom_twitter_app/ui/pages/account_page.dart';
import 'package:flutter_custom_twitter_app/ui/pages/following_and_followerlist_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DrawerView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    AsyncValue<UserProfileModel> value = watch(accountProfileProvider);
    return value.when(
      data: (value) {
        return Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      child: TextButton(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: Image.network(value.profileImageUrl,
                              width: 44, height: 44, fit: BoxFit.fill),
                        ),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          minimumSize: MaterialStateProperty.all(Size.zero),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Account(),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      child: Text(
                        value.name,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 12),
                      child: Text(
                        "@${value.username}",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ),
                    Row(children: [
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 3),
                              child: Text(
                                value.followingCount.toString(),
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            TextButton(
                              child: Text(
                                'フォロー中',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
                              ),
                              style: ButtonStyle(
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero),
                                minimumSize:
                                    MaterialStateProperty.all(Size.zero),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FollowingAndFollowerListPage(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 3),
                              child: Text(
                                value.followersCount.toString(),
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            TextButton(
                              child: Text(
                                'フォロワー',
                                style: TextStyle(
                                    color: Colors.black54, fontSize: 12),
                              ),
                              style: ButtonStyle(
                                padding:
                                    MaterialStateProperty.all(EdgeInsets.zero),
                                minimumSize:
                                    MaterialStateProperty.all(Size.zero),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        FollowingAndFollowerListPage(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      )
                    ])
                  ],
                ),
              ),
              Container(
                height: double.maxFinite,
                child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    itemCount: drawerListviewData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.black12, width: 1.0))),
                          child: TextButton(
                            style: TextButton.styleFrom(
                                primary: Colors.black87,
                                padding: EdgeInsets.all(10),
                                textStyle: TextStyle(fontSize: 14)),
                            child: ListTile(
                                leading: drawerListviewData[index]['icon'],
                                title: Text(drawerListviewData[index]['title']
                                    .toString())),
                            onPressed: () {},
                          ));
                    }),
              )
            ],
          ),
        );
      },
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}
