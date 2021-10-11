import 'package:flutter/material.dart';

import '../../pages/timeline_page.dart';
import '../../pages/search_page.dart';
import '../../pages/attention_page.dart';
import '../../pages/direct_message_page.dart';


class BottomTabsNavigation extends StatefulWidget {
  @override
  _BottomTabsNavigationState createState() =>  _BottomTabsNavigationState();
}

class _BottomTabsNavigationState extends State<BottomTabsNavigation> {

  int _currentIndex = 0;
  final _pageWidgets = [
    Timeline(),
    Search(),
    Attention(),
    DirectMessage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageWidgets.elementAt(_currentIndex),
      bottomNavigationBar:BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_none),
            label:'',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.email_outlined),
            label:'',
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