import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../pages/timeline_page.dart';
import '../../pages/search_page.dart';
import '../../pages/attention_page.dart';
import '../../pages/account_page.dart';

class BottomTabsNavigation extends StatefulWidget {
  @override
  _BottomTabsNavigationState createState() => _BottomTabsNavigationState();
}

class _BottomTabsNavigationState extends State<BottomTabsNavigation> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled,size: 24,),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search,size: 24,),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none,size: 24,),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined,size: 24,),
              label: '',
            ),
          ],
          onTap: _onItemTapped, // 実は無くても動く
          currentIndex: _currentIndex, // 実は無くても動く
        ),
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(builder: (context) {
                return Timeline();
              });
            case 1: 
              return CupertinoTabView(builder: (context) {
                return Search();
              });
            case 2:
              return CupertinoTabView(builder: (context) {
                return Attention();
              });
            case 3:
              return CupertinoTabView(builder: (context) {
                return Account();
              });
            default:
              return CupertinoTabView(builder: (context) {
                return Timeline();
              });
          }
        }
    );
  }

  void _onItemTapped(int index) => setState(() => _currentIndex = index);
}
