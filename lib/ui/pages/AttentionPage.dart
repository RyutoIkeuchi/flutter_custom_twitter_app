import 'package:flutter/material.dart';


class Attention extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        title:'Attention',
        home: Scaffold(
          appBar: AppBar(
              title:Text('通知')
          ),
          body: Center(
            child: Column(
                children:<Widget> [
                  Text('お知らせ画面です')
                ]
            ),
          ),
        )
    );
  }

}