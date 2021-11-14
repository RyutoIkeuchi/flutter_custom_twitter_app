import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/ui/components/templates/bottomtabs_navigation.dart';
import 'ui/components/templates/bottomtabs_navigation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() {
  runApp(
    ProviderScope(
      child:  MyApp(),
    )
  );
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
