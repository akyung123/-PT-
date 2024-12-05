import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_mate/screen/user/seletTrainer_screen.dart'; // 트레이너 선택 화면 import
import 'package:health_mate/screen/trainer/home_trainer_screen.dart'; // 트레이너 화면 import

import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
      ),
      body: Center(
        child: Container(
          width: 350,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: idController,
                decoration: InputDecoration(
                  labelText: 'ID',
                  suffix: ElevatedButton(
                    onPressed: () {
                      // 중복 확인 로직
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    child: Text('중복확인'),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  hintText: '영문자 포함 7~15자리',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(labelText: '비밀번호 확인'),
              ),
              SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: '이름',
                  hintText: 'NAME',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: '연락처',
                  suffix: ElevatedButton(
                    onPressed: () {
                      // 본인 확인 로직
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                    ),
                    child: Text('본인확인'),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text('남자'),
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
                      title: Text('여자'),
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
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: fitnessGoal,
                items: [
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
                decoration: InputDecoration(
                  labelText: '운동 목적',
                ),
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
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
                decoration: InputDecoration(
                  labelText: '회원 유형',
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // 회원가입 처리 로직
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text('회원가입'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
