import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '/tab/tab_login.dart';
import '/tab/tab_canlender.dart';
import '/tab/tab_chat.dart';


// StatelessWidget으로 정의된 Home 페이지
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomePage'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // 날짜 및 시간 표시
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('yyyy-MM-dd').format(DateTime.now()),
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // 스크롤 가능한 리스트뷰
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildCard('오늘의 운동', 'Body text.', Icons.fitness_center),
                _buildCard('오늘의 식단', 'Body text.', Icons.restaurant),
                _buildCard('기록', 'Body text.\nLABEL      Label', Icons.bar_chart),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 카드 위젯을 생성하는 함수
  Widget _buildCard(String title, String body, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.black,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    // 닫기 기능 추가 가능
                  },
                  icon: Icon(Icons.close, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              body,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: Icon(Icons.arrow_forward, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}

// 하단 네비게이션 바를 포함한 Home 클래스
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    HomePage(),    // 기존 StatelessWidget Home 페이지
    Calendar(),    // calendar.dart
    ChatScreen(), // chat_page.dart
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('PT Demo'),
      //   backgroundColor: Colors.green,
      // ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
        ],
      ),
    );
  }
} 