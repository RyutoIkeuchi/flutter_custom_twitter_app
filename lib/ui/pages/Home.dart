import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      home: Scaffold(
        appBar: AppBar(
        title:FaIcon(FontAwesomeIcons.twitter)
         ),
      body: Center(
        child: Column(
          children:<Widget> [
            Text('Homeページです')
          ]
        ),
      ),
    )
    );
  }

}