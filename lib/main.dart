import 'package:flutter/material.dart';
import 'ui/components/templates/bottomtabs_navigation.dart';

void main() {
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