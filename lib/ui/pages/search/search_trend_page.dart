import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/ViewModel/search_word_provider.dart';
import 'package:flutter_custom_twitter_app/ViewModel/searchword_provider.dart';
import 'package:flutter_custom_twitter_app/ui/pages/search/search_tweet_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchTrendWordScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    AsyncValue<dynamic> value = watch(searchTrendWordProvider);

    return value.when(
      data: (value) {
        return RefreshIndicator(
          onRefresh: () async {
            await context.refresh(searchTrendWordProvider);
          },
          child: ListView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: value.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: ListTile(
                    title: Text(
                      value[index]['name'],
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    subtitle: Text(
                      '${value[index]["tweetVolume"]}のツイート',
                      style: TextStyle(fontSize: 12),
                    ),
                    trailing: Icon(
                      Icons.more_horiz,
                      size: 20,
                      color: Colors.black26,
                    ),
                    onTap: () => {
                      context.read(searchwordProvider).state = value[index]['name'],
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SearchTweet()),
                      )
                    },
                  ),
                );
              }),
        );
      },
      loading: () => CircularProgressIndicator(),
      error: (err, stack) => Text('Error: $err'),
    );
  }
}
