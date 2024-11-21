import 'package:flutter/material.dart';
import '/screens/login.dart';

// mysql 테이블 리스트 확인 테스트
// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       title: 'SQLite Demo',
//       home: HomePage(),
//     );
//   }
// }


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super (key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PT Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

