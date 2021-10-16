import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/models/home_timeline_model.dart';
import 'package:flutter_custom_twitter_app/services/homt_time_line.dart';
import 'ui/components/templates/bottomtabs_navigation.dart';

void main() async {
  List<Set<HomeTimelineModel>> data = await getHomeTimelineData();
  print(data);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo Twitter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BottomTabsNavigation(),
    );
  }
}
