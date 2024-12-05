import 'package:flutter/material.dart';
import 'package:health_mate/screen/user/profile_user_screen.dart';
import 'calendar_user_screen.dart';
import 'chat_user_screen.dart';
import 'package:intl/intl.dart'; // 날짜 형식화를 위한 패키지

// class HomeUserScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Center( // 화면을 중앙에 배치
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start, // 세로축 위쪽으로 배치
//               crossAxisAlignment: CrossAxisAlignment.start, // 가로축 왼쪽 정렬
//               children: [
//                 // 사용자 기본 정보
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   margin: const EdgeInsets.only(bottom: 24),                  decoration: BoxDecoration(
//                     color: Colors.grey[100],
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Row(
//                     children: [
//                       CircleAvatar(
//                         radius: 35,
//                         backgroundColor: Colors.grey[300],
//                         child: Icon(Icons.person, size: 40, color: Colors.white),
//                       ),
//                       const SizedBox(width: 16),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             '홍길동',
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             '부산광역시 서구',
//                             style: TextStyle(fontSize: 14, color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),

//                 // 날짜 선택
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: List.generate(
//                     7,
//                     (index) => Container(
//                       decoration: BoxDecoration(
//                         color: index == 1
//                             ? Colors.purple[100]
//                             : Colors.grey[200], // 선택된 날짜 스타일
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 8.0, horizontal: 12.0),
//                       child: Text(
//                         index == 1 ? 'Today, 04 Oct' : '0${index + 1}',
//                         style: TextStyle(
//                           color: index == 1 ? Colors.purple : Colors.black,
//                           fontSize: 14,
//                           fontWeight:
//                               index == 1 ? FontWeight.bold : FontWeight.normal,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 const SizedBox(height: 24),

//                 // Goal Preview
//                 Text(
//                   'Goal Preview',
//                   style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black),
//                 ),
//                 const SizedBox(height: 16),
//                 Container(
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[100],
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             'In-Progress',
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold),
//                           ),
//                           Text(
//                             '56%',
//                             style: TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                                 color: Colors.purple),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       LinearProgressIndicator(
//                         value: 0.56,
//                         backgroundColor: Colors.grey[300],
//                         color: Colors.purple,
//                         minHeight: 8,
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         'You\'ve burned 1,116.5 out of 2,000 cal.',
//                         style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 24),

//                 // 오늘 운동 루틴 영상
//                 Text(
//                   '오늘 운동루틴 영상',
//                   style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black),
//                 ),
//                 const SizedBox(height: 16),
//                 Expanded(
//                   child: ListView(
//                     children: [
//                       _buildVideoCard('Label', 'Paragraph'),
//                       _buildVideoCard('Label', 'Paragraph'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   // 비디오 카드 구성 함수
//   Widget _buildVideoCard(String title, String subtitle) {
//     return Card(
//       margin: const EdgeInsets.only(bottom: 16),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           children: [
//             Container(
//               height: 60,
//               width: 60,
//               decoration: BoxDecoration(
//                 color: Colors.grey[300],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Icon(Icons.play_arrow, color: Colors.white),
//             ),
//             const SizedBox(width: 16),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   title,
//                   style: TextStyle(
//                       fontSize: 16, fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   subtitle,
//                   style: TextStyle(fontSize: 14, color: Colors.grey[600]),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class HomeUserScreen extends StatelessWidget {
  const HomeUserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime today = DateTime.now();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 사용자 기본 정보
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.grey[300],
                        child: const Icon(Icons.person,
                            size: 40, color: Colors.white),
                      ),
                      const SizedBox(width: 16),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '홍길동',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '부산광역시 서구',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // 날짜 선택
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(7, (index) {
                    DateTime date = today.add(Duration(days: index - 1));
                    bool isSelected = date.day == today.day;

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CalendarUserScreen(
                                  initialDate: date)), // 캘린더 페이지로 이동
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Colors.purple[100]
                              : Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 12.0),
                        child: Text(
                          isSelected
                              ? 'Today, ${DateFormat('dd').format(date)}'
                              : DateFormat('dd').format(date),
                          style: TextStyle(
                            color: isSelected ? Colors.purple : Colors.black,
                            fontSize: 14,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 24),

                // Goal Preview
                const Text(
                  'Goal Preview',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'In-Progress',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '56%',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: 0.56,
                        backgroundColor: Colors.grey[300],
                        color: Colors.purple,
                        minHeight: 8,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'You\'ve burned 1,116.5 out of 2,000 cal.',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

// 오늘 운동 루틴 영상
                const Text(
                  '오늘 운동루틴 영상',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    children: [
                      _buildVideoCard('Label', 'Paragraph'),
                      _buildVideoCard('Label', 'Paragraph'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// 비디오 카드 구성 함수
  Widget _buildVideoCard(String title, String subtitle) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.play_arrow, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
