import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/ui/pages/look_tweet_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:flutter_custom_twitter_app/services/home_time_line.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/retweet_card.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/tweet_card.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/drawer_view.dart';
import '../components/templates/drawer_view.dart';

class TimelineTweetData extends ChangeNotifier {
  List data = [];
  Future<dynamic> getTimelineTweetData() async {
    this.data = await getHomeTimelineData();
    notifyListeners();
  }

  Future<dynamic> refresh() async {
    this.data = await getHomeTimelineData();
    notifyListeners();
  }
}

class Timeline extends StatelessWidget {
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
    return ChangeNotifierProvider<TimelineTweetData>(
        create: (_) => TimelineTweetData()..getTimelineTweetData(),
        child: Scaffold(
            appBar: AppBar(
              title: FaIcon(FontAwesomeIcons.twitter),
            ),
            drawer: DrawerView(),
            body: Consumer<TimelineTweetData>(builder: (context, model, child) {
              List<dynamic> data = model.data;

              if (data == []) {
                return CircularProgressIndicator();
              }

              return RefreshIndicator(
                onRefresh: () async {
                  await TimelineTweetData().refresh();
                },
                child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: data.length,
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
                            child: !checkTextData(data[index]['text'])
                                ? tweetCard(data[index])
                                : reTweetCard(data[index]),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        LookTweetPage(data: data[index])),
                              );
                            },
                          ));
                    }),
              );
            }),
            floatingActionButton: Container(
              margin: EdgeInsets.only(bottom: 50),
              child: FloatingActionButton(
                child:FaIcon(FontAwesomeIcons.feather),
                onPressed: () {},
              ),
            )
            ));
  }
}
