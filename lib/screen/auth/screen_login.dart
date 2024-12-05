import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_mate/widget/loading_indicator.dart'; // 공통 로딩 위젯 추가
import 'package:health_mate/services/auth_service.dart'; // AuthService 가져오기

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _authService = AuthService(); // AuthService 인스턴스

  bool isLoading = false; // 로딩 상태 변수

 Future<void> loginUser() async {
  String email = emailController.text.trim();
  String password = passwordController.text.trim();

  if (email.isEmpty || password.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('이메일과 비밀번호를 입력하세요.')),
    );
    return;
  }

  setState(() {
    isLoading = true; // 로딩 시작
  });

  try {
    // Firebase 인증
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    String userId = userCredential.user!.uid;

    // Firestore에서 사용자 문서 가져오기
    DocumentSnapshot userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();

    if (userDoc.exists) {
      // Firestore 데이터에서 필드 읽기
      Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
      String? userType = userData?['userType'];
      String? trainerId = userData?['trainerId'];

      if (userType == 'personal') {
        if (trainerId == null || trainerId.isEmpty) {
          // 트레이너 선택 화면으로 이동
          Navigator.pushReplacementNamed(context, '/select_trainer');
        } else {
          // 일반 회원 홈 화면으로 이동
          Navigator.pushReplacementNamed(context, '/tab_user');
        }
      } else if (userType == 'trainer') {
        // 트레이너 홈 화면으로 이동
        Navigator.pushReplacementNamed(context, '/home_trainer');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('알 수 없는 사용자 유형입니다.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('사용자 정보를 찾을 수 없습니다.')),
      );
    }
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('로그인 오류: ${e.message}')),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('오류 발생: ${e.toString()}')),
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
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            width: 300, // 화면의 중앙에 고정된 넓이
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ID 입력
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'ID',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),
                // Password 입력
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                // 로그인 버튼
                ElevatedButton(
                  onPressed: loginUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 48),
                  ),
                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('로그인'),
                ),
                SizedBox(height: 20),
                // 회원가입, 비밀번호 찾기 버튼
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register'); // 회원가입 화면으로 이동
                      },
                      child: Text(
                        '회원가입',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgot_password'); // 비밀번호 찾기 화면으로 이동
                      },
                      child: Text(
                        '비밀번호 찾기',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
