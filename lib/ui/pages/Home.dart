import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../components/templates/DrawerView.dart';


class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      home: Scaffold(
        appBar: AppBar(
          title:FaIcon(FontAwesomeIcons.twitter )
        ),
        drawer:DrawerView(),
      body: Center(
        child: Column(
          children:<Widget> [
            ElevatedButton(
              onPressed:() {},
              child: Text('API取得'),
             ),
          ]
        ),
      ),
    )
    );
  }

}