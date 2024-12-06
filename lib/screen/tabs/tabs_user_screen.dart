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
    HomeUserScreen(
      initialDate: DateTime.now(),
    ), // 홈 화면
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
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.black, // 선택된 항목의 색상
        unselectedItemColor: Colors.grey, // 선택되지 않은 항목의 색상
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
        type: BottomNavigationBarType.fixed, // 아이콘과 라벨 모두 표시
        elevation: 0, // 그림자 제거
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: '홈'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_outlined), label: '달력'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline), label: '채팅'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: '내정보'),
        ],
      ),
    );
  }
}
