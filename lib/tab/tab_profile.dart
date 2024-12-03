import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 정보'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          // 사용자 기본 정보
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, size: 30, color: Colors.white),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '홍길동',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '여자',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
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
          SnackBar(content: Text('$label 수정하기')),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Text(
                  value,
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
                const SizedBox(width: 8),
                Icon(Icons.arrow_forward_ios, size: 16, color: const Color.fromARGB(255, 8, 8, 8)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
