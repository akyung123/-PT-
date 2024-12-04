// main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_mate/screen/screen_login.dart';
import 'package:health_mate/screen/screen_index_user.dart';
import 'package:health_mate/screen/screen_login.dart';
import 'package:health_mate/screen/screen_register.dart';
import 'package:health_mate/models/model_auth.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

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
//   }k
// }


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
          '/': (context) => LoginPage(),
          '/login': (context) => LoginPage(),
          '/index': (context) => IndexScreen(),
          '/register': (context) => RegisterScreen(),
        },
        initialRoute: '/',
      ),
    );
  }
}

Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 3)); // 예제
  return "Data Loaded";
}

@override
Widget build(BuildContext context) {
  return FutureBuilder<String>(
    future: fetchData(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return CircularProgressIndicator();
      } else if (snapshot.hasError) {
        return Text("Error: ${snapshot.error}");
      } else {
        return Text("Data: ${snapshot.data}");
      }
    },
  );
}
