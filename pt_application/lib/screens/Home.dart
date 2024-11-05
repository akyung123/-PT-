import 'package:flutter/material.dart';
import '/screens/Login.dart';
import '/screens/Calendar.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // 중앙 정렬
          children: [
            ElevatedButton(
              onPressed: () {
                // 버튼 클릭 시 두 번째 페이지로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text('Go to Login'),
            ),
            SizedBox(height: 20), // 버튼 사이에 간격 추가
            ElevatedButton(
              onPressed: () {
                // 버튼 클릭 시 Calendar 페이지로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Calendar()),
                );
              },
              child: Text('Go to Calendar'),
            ),
          ],
        ),
      ),
    );
  }
}
