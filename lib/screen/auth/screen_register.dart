import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String userType = 'personal';
  bool isLoading = false; // 로딩 상태 변수 추가

  // Firestore에 사용자 정보 저장
  Future<void> saveUserToFirestore(String userId, String email, String userType) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'email': email,
        'userType': userType,
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
      isLoading = true; // 로딩 시작
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      String userId = userCredential.user!.uid;
      await saveUserToFirestore(userId, emailController.text, userType);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('회원가입 성공!')),
      );

      // 화면 이동 로직 추가 가능
      Navigator.pop(context); // 이전 화면으로 이동 (예시)
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('회원가입 오류: ${e.toString()}')),
      );
    } finally {
      setState(() {
        isLoading = false; // 로딩 종료
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('회원가입')),
      body: Stack(
        children: [
          Padding(
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
                  decoration: InputDecoration(labelText: '비밀번호'),
                  obscureText: true,
                ),
                SizedBox(height: 16),
                DropdownButton<String>(
                  value: userType,
                  items: [
                    DropdownMenuItem(value: 'personal', child: Text('개인회원')),
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
                  onPressed: isLoading
                      ? null
                      : registerUser, // 로딩 중 버튼 비활성화
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isLoading ? Colors.grey : Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 48),
                  ),
                  child: isLoading
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            ),
                            SizedBox(width: 10),
                            Text('처리 중...'),
                          ],
                        )
                      : Text('회원가입'),
                ),
              ],
            ),
          ),
          if (isLoading) // 로딩 상태일 때 스피너 오버레이
            Container(
              color: Colors.black.withOpacity(0.3), // 반투명 배경
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
