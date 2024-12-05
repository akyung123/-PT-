// main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_mate/screen/auth/forgot_password_screen.dart';
import 'package:health_mate/screen/auth/screen_login.dart';
import 'package:health_mate/screen/tabs/tabs_trainer_screen.dart';
import 'package:health_mate/screen/tabs/tabs_user_screen.dart';
import 'package:health_mate/screen/user/home_user_screen.dart';
import 'package:health_mate/screen/auth/screen_register.dart';
import 'package:health_mate/models/model_auth.dart';
import 'package:health_mate/screen/user/seletTrainer_screen.dart';
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

void main() async {
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
          '/': (context) => LoginScreen(),
          '/register': (context) => RegisterScreen(),
          '/forgot_password': (context) => ForgotPasswordScreen(),
          '/tab_user': (context) => TabsUserScreen(), // TabsUserScreen 연결
          '/tab_trainer': (context) => TabsTrainerScreen(),
          '/selet_trainer': (context) => SelectTrainerScreen(userId: '',),
        },
        initialRoute: '/',
      ),
    );
  }
}