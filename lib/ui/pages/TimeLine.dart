import 'package:flutter/material.dart';


class TimeLine extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TimeLine',
        home: Scaffold(
          appBar: AppBar(
              title:Text('TimeLine')
          ),
          body: Center(
            child: Column(
                children:<Widget> [
                  Text('タイムラインページです')
                ]
            ),
          ),
        )
    );
  }

}