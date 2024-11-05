import 'package:flutter/material.dart';
import '/screens/Home.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // 버튼 클릭 시 첫 번째 페이지로 돌아가기
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Home())
            );
          },
          child: Text('Back to Home Page'),
        ),
      ),
    );
  }
}