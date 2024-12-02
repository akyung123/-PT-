import 'package:flutter/material.dart';

void main() {
  runApp(SignUpApp());
}

class SignUpApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  String gender = '남자';
  String selectedWorkout = '선택';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'ID',
                  suffix: ElevatedButton(
                    onPressed: () {
                      // 중복 확인 로직
                    },
                    child: Text('중복확인'),
                  ),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  hintText: '영문자 포함 7~15자리',
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '비밀번호 확인',
                ),
                obscureText: true,
              ),
              SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: '이름',
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: '연락처',
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      // 본인확인 로직
                    },
                    child: Text('본인확인'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Text('성별:'),
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('남자'),
                      value: '남자',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RadioListTile<String>(
                      title: Text('여자'),
                      value: '여자',
                      groupValue: gender,
                      onChanged: (value) {
                        setState(() {
                          gender = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedWorkout,
                items: ['선택', '다이어트', '스트레칭', '근력증가', '필라테스']
                    .map((workout) => DropdownMenuItem(
                          value: workout,
                          child: Text(workout),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    selectedWorkout = value!;
                  });
                },
                decoration: InputDecoration(labelText: '운동목적'),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // 회원가입 처리 로직
                  }
                },
                child: Text('확인'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
