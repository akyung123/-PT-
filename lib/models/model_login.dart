import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String userType = 'personal'; // Default 회원 유형

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('회원가입')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: '이메일'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: '비밀번호'),
              obscureText: true,
            ),
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
            ElevatedButton(
              onPressed: () async {
                // 회원가입 처리 호출
                await registerUser(
                  emailController.text,
                  passwordController.text,
                  userType,
                );
              },
              child: Text('회원가입'),
            ),
          ],
        ),
      ),
    );
  }
}
