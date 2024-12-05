import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_mate/screen/user/seletTrainer_screen.dart'; // 트레이너 선택 화면 import
import 'package:health_mate/screen/trainer/home_trainer_screen.dart'; // 트레이너 화면 import

import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController idController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  String userType = 'personal'; // 기본값은 일반 회원
  String gender = '남자'; // 기본 성별 선택
  String fitnessGoal = '선택'; // 기본 운동 목적
  String errorMessage = ''; // 에러 메시지

  Future<void> registerUser() async {
    final email = idController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final name = nameController.text.trim();
    final phone = phoneController.text.trim();

    if (email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        name.isEmpty ||
        phone.isEmpty) {
      setState(() {
        errorMessage = '모든 필드를 채워주세요.';
      });
      return;
    }

    if (password != confirmPassword) {
      setState(() {
        errorMessage = '비밀번호가 일치하지 않습니다.';
      });
      return;
    }

    try {
      // Firebase Authentication으로 회원가입
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // Firebase Firestore에 사용자 데이터 저장
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'name': name,
        'email': email,
        'phone': phone,
        'userType': userType,
        'gender': gender,
        'fitnessGoal': fitnessGoal,
        'createdAt': FieldValue.serverTimestamp(),
      });

      setState(() {
        errorMessage = ''; // 에러 메시지 초기화
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('회원가입 성공!')),
      );

      // 회원 유형에 따라 다른 화면으로 이동
      if (userType == 'trainer') {
        Navigator.pushReplacementNamed(context, '/trainer_Home');
      } else {
        Navigator.pushReplacementNamed(
          context, '/select_trainer',
          arguments: userCredential.user!.uid, // Firebase에서 가져온 사용자 ID
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = '회원가입 실패: ${e.message}';
      });
    } catch (e) {
      setState(() {
        errorMessage = '오류 발생: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('회원가입'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      errorMessage,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ),
                TextField(
                  controller: idController,
                  decoration: InputDecoration(
                    labelText: 'ID',
                    prefixIcon: const Icon(Icons.email),
                    suffix: ElevatedButton(
                      onPressed: () {
                        // 중복 확인 로직
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                      child: const Text('중복확인'),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: '비밀번호',
                    hintText: '영문자 포함 7~15자리',
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: '비밀번호 확인',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: '이름',
                    hintText: 'NAME',
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: phoneController,
                  decoration: InputDecoration(
                    labelText: '연락처',
                    prefixIcon: const Icon(Icons.phone),
                    suffix: ElevatedButton(
                      onPressed: () {
                        // 본인 확인 로직
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                      ),
                      child: const Text('본인확인'),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: ListTile(
                        title: const Text('남자'),
                        leading: Radio<String>(
                          value: '남자',
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListTile(
                        title: const Text('여자'),
                        leading: Radio<String>(
                          value: '여자',
                          groupValue: gender,
                          onChanged: (value) {
                            setState(() {
                              gender = value!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: fitnessGoal,
                  items: const [
                    DropdownMenuItem(value: '선택', child: Text('선택')),
                    DropdownMenuItem(value: '다이어트', child: Text('다이어트')),
                    DropdownMenuItem(value: '스트레칭', child: Text('스트레칭')),
                    DropdownMenuItem(value: '근력증가', child: Text('근력증가')),
                    DropdownMenuItem(value: '필라테스', child: Text('필라테스')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      fitnessGoal = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: '운동 목적',
                  ),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: userType,
                  items: const [
                    DropdownMenuItem(value: 'personal', child: Text('일반 회원')),
                    DropdownMenuItem(value: 'trainer', child: Text('트레이너')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      userType = value!;
                    });
                  },
                  decoration: const InputDecoration(
                    labelText: '회원 유형',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: registerUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('회원가입'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
