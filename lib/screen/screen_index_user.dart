import 'package:flutter/material.dart';

import '/tab/tab_canlender.dart';
import 'home/screen_home_user.dart';
import '/tab/tab_chat.dart';
import '/tab/tab_profile.dart';

class IndexScreen extends StatefulWidget {
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  int _currentIndex = 0;
  final List<Widget> _tabs = [
    HomeScreenUser(),    // 기존 StatelessWidget Home 페이지
    Calendar(),    // calendar.dart
    ChatScreen(), // chat_page.dart  HomeTab(),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        selectedLabelStyle: const TextStyle(fontSize: 12),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        // ignore: prefer_const_literals_to_create_immutables
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          const BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: 'Calendar'),
          const BottomNavigationBarItem(icon: Icon(Icons.chat), label:  'Chat'),
          const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Myprofile'),
        ],                
      ) ,
      body:  _tabs[_currentIndex],
    );
  }
}

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  HomeScreenUser(), // tab_home_user.dart의 메인 화면을 호출
    );
  }
}