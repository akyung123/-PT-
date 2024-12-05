import 'package:flutter/material.dart';
import '../trainer/home_trainer_screen.dart';
import '../trainer/calendar_trainer_screen.dart';
import '../trainer/chat_trainer_screen.dart';
import '../trainer/profile_trainer_screen.dart';

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
    ProfileTrainerScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // 현재 탭에 해당하는 화면
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
            label: '달력',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: '채팅',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '내정보',
          ),
        ],
      ),
    );
  }
}
