import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/ViewModel/account_provider.dart';
import 'package:flutter_custom_twitter_app/services/const/drawer_listview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    AsyncValue<dynamic> value = watch(accountProfileProvider);
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
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: Image.network(value['profile_image_url'],
                            width: 44, height: 44, fit: BoxFit.fill),
                      ),
                    ),
                    Container(
                      child: Text(
                        value['name'],
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 12),
                      child: Text(
                        "@${value['username']}",
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
                                value['public_metrics']['following_count']
                                    .toString(),
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Text(
                              'フォロー中',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 3),
                              child: Text(
                                value['public_metrics']['followers_count']
                                    .toString(),
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                            Text(
                              'フォロワー',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 12),
                            )
                          ],
                        ),
                      )
                    ])
                  ],
                ),
                decoration: BoxDecoration(color: Colors.blue),
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
