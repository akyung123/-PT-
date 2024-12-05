import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'member_task_screen.dart'; // 회원 당일 할 일 화면

class HomeTrainerScreen extends StatelessWidget {
  final String trainerId; // 트레이너 ID

  HomeTrainerScreen({required this.trainerId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원 목록'),
        backgroundColor: Colors.black,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users') // 회원 정보가 저장된 Firestore 컬렉션
            .where('trainerId', isEqualTo: trainerId) // 해당 트레이너의 회원만 필터링
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('회원이 없습니다.'));
          }

          final members = snapshot.data!.docs;

          return ListView.builder(
            itemCount: members.length,
            itemBuilder: (context, index) {
              final member = members[index];
              return ListTile(
                title: Text(member['name']), // 회원 이름
                subtitle: Text('ID: ${member.id}'),
                trailing: Icon(Icons.arrow_forward),
                onTap: () {
                  // 회원 당일 할 일 화면으로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MemberTaskScreen(memberId: member.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
