import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/ui/components/organisms/retweet_card.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'package:flutter_custom_twitter_app/ui/components/organisms/tweet_card.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/drawer_view.dart';
import '../../services/api.dart';
import '../components/templates/drawer_view.dart';

class TweetTimelineData extends ChangeNotifier {
  List<dynamic> data = [];
  Future<dynamic> getTweetTimelineData() async {
    this.data = await getApi();
    notifyListeners();
  }

  Future<dynamic> refresh() async {
    this.data = await getApi();
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
    return ChangeNotifierProvider<TweetTimelineData>(
        create: (_) => TweetTimelineData()..getTweetTimelineData(),
        child: Scaffold(
            appBar: AppBar(
              title: FaIcon(FontAwesomeIcons.twitter),
            ),
            drawer: DrawerView(),
            body: Consumer<TweetTimelineData>(builder: (context, model, child) {
              final dynamic data = model.data;
              if (data == []) {
                return CircularProgressIndicator();
              }
              return RefreshIndicator(
                onRefresh: () async {
                  print('リフレッシュします');
                  await TweetTimelineData().refresh();
                },
                child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      color: Colors.black12, width: 1.0))),
                          child: !checkTextData(data[index]['text'])
                              ? tweetCard(data[index])
                              : reTweetCard(data[
                                  index])); // child: ListTile(title:Text('ああああ')));
                    }),
              );
            })));
  }
}
