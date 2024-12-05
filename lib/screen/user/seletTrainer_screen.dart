import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SelectTrainerScreen extends StatelessWidget {
  final String userId; // 현재 회원 ID

  SelectTrainerScreen({required this.userId});

  Future<List<Map<String, dynamic>>> fetchTrainers() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('userType', isEqualTo: 'trainer') // 트레이너만 가져옴
        .get();

    return snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'id': doc.id, // 문서 ID
        'name': data['name'] ?? 'Unknown Trainer', // 기본값 설정
        'email': data['email'] ?? 'No Email', // 기본값 설정
      };
    }).toList();
  }

  Future<void> assignTrainer(String trainerId) async {
    await FirebaseFirestore.instance.collection('users').doc(userId).update({
      'trainerId': trainerId, // 선택한 트레이너 ID 저장
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('트레이너 선택')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchTrainers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('등록된 트레이너가 없습니다.'));
          }

          final trainers = snapshot.data!;
          return ListView.builder(
            itemCount: trainers.length,
            itemBuilder: (context, index) {
              final trainer = trainers[index];
              return ListTile(
                title: Text(trainer['name']), // 이름 표시
                subtitle: Text(trainer['email']), // 이메일 표시
                onTap: () async {
                  await assignTrainer(trainer['id']);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${trainer['name']} 트레이너가 선택되었습니다.')),
                  );
                  Navigator.pop(context); // 선택 완료 후 이전 화면으로 이동
                },
              );
            },
          );
        },
      ),
    );
  }
}
