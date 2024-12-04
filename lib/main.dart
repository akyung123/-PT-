// main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '/tab/tab_login.dart';
import 'package:health_mate/screen/screen_index_user.dart';
import 'package:health_mate/screen/screen_login.dart';
import 'package:health_mate/screen/screen_register.dart';
import 'package:health_mate/models/model_auth.dart';
import 'package:provider/provider.dart';

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


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FirebaseAuthProvider())
      ],
      child: MaterialApp(
        title: 'PT Demo',
        theme: ThemeData(
        primarySwatch: Colors.blue,
        ),
        routes: {
          '/login': (context) => LoginPage(),
          '/index': (context) => IndexScreen(),
          '/register': (context) => RegisterScreen(),
        },
        initialRoute: '/',
      ),
    );
  }
}