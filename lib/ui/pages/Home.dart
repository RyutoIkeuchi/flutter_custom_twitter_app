import 'package:flutter/material.dart';


class Home extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      home: Scaffold(
        appBar: AppBar(
        title:Text('Home')
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