import 'package:flutter/material.dart';


class DirectMessage extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'DirectMessage',
        home: Scaffold(
          appBar: AppBar(
              title:Text('DirectMessage')
          ),
          body: Center(
            child: Column(
                children:<Widget> [
                  Text('DM画面です')
                ]
            ),
          ),
        )
    );
  }

}