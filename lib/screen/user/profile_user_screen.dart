import 'package:flutter/material.dart';

class ProfileUserScreen extends StatelessWidget {
  final String memberId; // 사용자 ID를 받는 변수
  final String? trainerId; // 트레이너 ID를 받는 변수 (nullable)

  const ProfileUserScreen({Key? key, required this.memberId, this.trainerId})
      : super(key: key); // 생성자에서 두 값을 받음

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 정보 ($memberId)'), // memberId를 제목에 표시
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // 사용자 기본 정보
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[300],
                  child:
                      const Icon(Icons.person, size: 30, color: Colors.white),
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '홍길동', // 사용자 이름 (임시 값, Firestore 연동 필요)
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '여자', // 사용자 성별 (임시 값, Firestore 연동 필요)
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(thickness: 1, color: Colors.grey),

          // 트레이너 정보 표시
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '트레이너 ID',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  trainerId ?? '미등록', // 트레이너 ID가 없으면 '미등록' 표시
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ),
          ),
          const Divider(thickness: 1, color: Colors.grey),

          // 상세 정보 목록
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                _buildInfoRow('생년월일', '등록하기', context),
                _buildInfoRow('연락처', '등록하기', context),
                _buildInfoRow('운동목적', '다이어트, 근력증가', context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 정보 행 구성 함수
  Widget _buildInfoRow(String label, String value, BuildContext context) {
    return InkWell(
      onTap: () {
        // 정보 수정 페이지로 이동 (필요시 구현)
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$label 수정하기 (ID: $memberId)')), // memberId 표시
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text(
                  value,
                  style: const TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.arrow_forward_ios,
                    size: 16, color: Color.fromARGB(255, 8, 8, 8)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
