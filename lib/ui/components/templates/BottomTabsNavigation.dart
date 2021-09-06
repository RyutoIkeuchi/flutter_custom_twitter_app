import 'package:flutter/material.dart';

class BottomTabsNavigation extends StatefulWidget {
  @override
  _BottomTabsNavigationState createState() =>  _BottomTabsNavigationState();
}

class _BottomTabsNavigationState extends State<BottomTabsNavigation> {

  int _currentIndex = 0;
  final _pageWidgets = [
    PageWidget(color:Colors.white,title:'Home'),
    PageWidget(color:Colors.white,title:'Album'),
    PageWidget(color:Colors.white,title:'Chat'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('BottomNavigationBar'),
      ),
      body: _pageWidgets.elementAt(_currentIndex),
      bottomNavigationBar:BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            label: 'Contacts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label:'Chat',
          ),
        ],
      currentIndex:_currentIndex,
      fixedColor:Colors.blueAccent,
      onTap:_onItemTapped,
      type:BottomNavigationBarType.fixed,
     ),
    );
  }

  void _onItemTapped(int index) => setState(()=>_currentIndex = index);
}

class PageWidget extends StatelessWidget {
  final Color color;
  final String title;

  PageWidget({Key? key,required this.color,required this.title}):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color:color,
      child:Center(
        child:Text(
          title,
          style: TextStyle(
            fontSize: 25,
          ),
        ),
      ),
    );
  }
}