import 'package:flutter/material.dart';
import 'package:health_mate/screen/trainer/calendar_trainer_screen.dart';
import 'package:health_mate/screen/trainer/chat_trainer_screen.dart';
import 'package:health_mate/screen/trainer/home_trainer_screen.dart';
import 'package:health_mate/screen/trainer/profile_trainer_screen.dart';

class TabsTrainerScreen extends StatefulWidget {
  @override
  _TabsTrainerScreenState createState() => _TabsTrainerScreenState();
}

class _TabsTrainerScreenState extends State<TabsTrainerScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeTrainerScreen(trainerId: '',),
    CalendarTrainerScreen(),
    ChatTrainerScreen(),
    ProfileTrainerScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: '캘린더',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '내 정보',
          ),
        ],
      ),
    );
  }
}
