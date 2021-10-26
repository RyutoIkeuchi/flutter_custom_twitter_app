import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/services/tweet_trend_api.dart';
import 'package:flutter_custom_twitter_app/ui/pages/search_page.dart';
import 'package:provider/provider.dart';

class TrendTweetData extends ChangeNotifier {
  List data = [];
  Future<dynamic> getTrendTweet() async {
    this.data = await getTrendApi();
    notifyListeners();
  }

  Future<dynamic> refresh() async {
    this.data = await getTrendApi();
    notifyListeners();
  }
}

Widget searchWordScreen() {
  return ChangeNotifierProvider<TrendTweetData>(
      create: (_) => TrendTweetData()..getTrendTweet(),
      child: Consumer<TrendTweetData>(builder: (context, model, child) {
            List<dynamic> data = model.data;

            if (data == []) {
              return CircularProgressIndicator();
            }

            return RefreshIndicator(
              onRefresh: () async {
                await TrendTweetData().refresh();
              },
              child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      // padding: EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(data[index]['name'],style: TextStyle(fontWeight:FontWeight.bold,fontSize: 14),),
                        subtitle: Text('${data[index]["tweetVolume"]}のツイート',style: TextStyle(fontSize: 12),),
                        trailing: Icon(Icons.more_horiz,size: 20,color:Colors.black26,),
                        onTap: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Search(word: data[index]['name'])),
                          )
                        },
                      ),
                    );
                  }),
            );
          }));
}
