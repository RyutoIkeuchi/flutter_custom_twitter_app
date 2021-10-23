import 'package:flutter/material.dart';

class DrawerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
        child:ListView(
          children: <Widget>[
            DrawerHeader(
                child: Text('アイコン'),
              decoration: BoxDecoration(
                color: Colors.blue
              ),
            ),
            ListTile(
              title:Text('ああああ')
            ),
            ListTile(
                title:Text('ああああ')
            ),
          ],
        ),
      );
  }
}