import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_mate/screen/user/seletTrainer_screen.dart'; // 트레이너 선택 화면 import
import 'package:health_mate/screen/trainer/home_trainer_screen.dart'; // 트레이너 화면 import

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String userType = 'personal'; // 기본 값은 일반 회원
  bool isLoading = false;

  // Firestore에 사용자 정보 저장
  Future<void> saveUserToFirestore(String userId, String email, String userType) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'email': email,
        'userType': userType,
        'trainerId': userType == 'personal' ? null : userId, // 일반 회원은 trainerId가 null, 트레이너는 자기 ID 저장
        'createdAt': FieldValue.serverTimestamp(),
      });
      print('Firestore 저장 성공');
    } catch (e) {
      print('Firestore 저장 오류: $e');
    }
  }

  // Firebase Authentication 회원가입
  Future<void> registerUser() async {
    setState(() {
      isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      String userId = userCredential.user!.uid;

      // Firestore에 사용자 데이터 저장
      await saveUserToFirestore(userId, emailController.text.trim(), userType);

      // 회원가입 성공: 일반 회원은 트레이너 선택 화면, 트레이너는 트레이너 화면으로 이동
      if (userType == 'personal') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => SelectTrainerScreen(userId: userId),
          ),
        );
      } else if (userType == 'trainer') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeTrainerScreen(trainerId: userId),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('회원가입 오류: ${e.toString()}')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('회원가입')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: '이메일'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: '비밀번호'),
            ),
            SizedBox(height: 16),
            // 회원 유형 선택 Dropdown
            DropdownButton<String>(
              value: userType,
              items: [
                DropdownMenuItem(value: 'personal', child: Text('일반 회원')),
                DropdownMenuItem(value: 'trainer', child: Text('트레이너')),
              ],
              onChanged: (value) {
                setState(() {
                  userType = value!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : registerUser,
              child: isLoading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}
