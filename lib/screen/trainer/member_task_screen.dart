import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MemberTaskScreen extends StatefulWidget {
  final String memberId; // 회원 ID

  const MemberTaskScreen({Key? key, required this.memberId}) : super(key: key);

  @override
  _MemberTaskScreenState createState() => _MemberTaskScreenState();
}

class _MemberTaskScreenState extends State<MemberTaskScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> tasks = []; // 할 일 목록

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    final snapshot = await _firestore
        .collection('tasks') // 할 일 정보가 저장된 Firestore 컬렉션
        .where('memberId', isEqualTo: widget.memberId) // 해당 회원의 할 일 필터링
        .where('date',
            isEqualTo:
                DateTime.now().toIso8601String().split('T')[0]) // 당일 할 일만
        .get();

    setState(() {
      tasks = snapshot.docs.map((doc) => doc.data()).toList();
    });
  }

  Future<void> addTask(String taskName) async {
    final task = {
      'memberId': widget.memberId,
      'trainerId': 'trainerId', // 트레이너 ID 추가
      'taskName': taskName,
      'date': DateTime.now().toIso8601String().split('T')[0],
      'completed': false, // 기본값: 완료되지 않음
    };

    await _firestore.collection('tasks').add(task);
    fetchTasks(); // 새로고침
  }

  Future<void> updateTask(String taskId, bool completed) async {
    await _firestore
        .collection('tasks')
        .doc(taskId)
        .update({'completed': completed});
    fetchTasks(); // 새로고침
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('할 일 목록'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return ListTile(
                  title: Text(task['taskName']),
                  trailing: Switch(
                    value: task['completed'],
                    onChanged: (value) {
                      updateTask(task['id'], value); // 완료 상태 업데이트
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: '새로운 할 일',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  addTask(value); // 새로운 할 일 추가
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
