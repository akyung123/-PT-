import 'package:flutter/material.dart';
import '../user/home_user_screen.dart';
import '../user/calendar_user_screen.dart';
import '../user/chat_user_screen.dart';
import '../user/profile_user_screen.dart';

class TabsUserScreen extends StatefulWidget {
  const TabsUserScreen({Key? key}) : super(key: key);

  @override
  _TabsUserScreenState createState() => _TabsUserScreenState();
}

class _TabsUserScreenState extends State<TabsUserScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _screens = [
    HomeUserScreen(), // 홈 화면
    CalendarUserScreen(
      initialDate: DateTime.now(),
    ), // 달력 화면
    ChatUserScreen(memberId: 'user123'), // 채팅 화면
    ProfileUserScreen(memberId: 'user123'), // 내 정보 화면
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        // currentIndex: _selectedIndex,
        // onTap: (index) {
        //   setState(() {
        //     _selectedIndex = index;
        //   });
        // },
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.purple, // 선택된 항목의 색상
        unselectedItemColor: Colors.grey, // 선택되지 않은 항목의 색상
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today), label: '달력'),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: '채팅'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '내정보'),
        ],
      ),
    );
  }
}
