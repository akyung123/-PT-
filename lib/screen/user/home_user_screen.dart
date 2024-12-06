import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 날짜 형식화를 위한 패키지
import 'calendar_user_screen.dart';
import '../../services/exercise_routine_manager.dart';

class HomeUserScreen extends StatefulWidget {
  final DateTime initialDate;

  const HomeUserScreen({Key? key, required this.initialDate}) : super(key: key);

  @override
  _HomeUserScreenState createState() => _HomeUserScreenState();
}

class _HomeUserScreenState extends State<HomeUserScreen> {
  late DateTime _selectedDate;
  List<Map<String, String>> _exerciseRoutines = [];

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _loadRoutines();
  }

  Future<void> _loadRoutines() async {
    await ExerciseRoutineManager.loadExerciseRoutines();
    setState(() {
      _exerciseRoutines =
          ExerciseRoutineManager.getRoutinesForDate(_selectedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Home', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
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
                              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
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
                  DateTime date = _selectedDate.add(Duration(days: index - 1));
                  bool isSelected = date.day == _selectedDate.day;

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              CalendarUserScreen(initialDate: date),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.black : Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 12.0),
                      child: Text(
                        DateFormat('dd').format(date),
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.black,
                          fontSize: 14,
                          fontWeight:
                              isSelected ? FontWeight.bold : FontWeight.normal,
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
                              fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                        Text(
                          '56%',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: 0.56,
                      backgroundColor: Colors.grey[300],
                      color: Colors.black,
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

              // 비디오 섹션
              const Text(
                '오늘 운동 루틴 영상',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
              const SizedBox(height: 16),

              Expanded(
                child: ListView.builder(
                  itemCount: 2, // 비디오 카드의 개수
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      color: Colors.white,
                      child: ListTile(
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.play_arrow,
                              size: 30, color: Colors.black),
                        ),
                        title: const Text(
                          'Video Title',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        subtitle: const Text(
                          'Video Description',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios,
                            size: 16, color: Colors.black),
                        onTap: () {
                          // 비디오 상세 화면으로 이동 (필요시 구현)
                        },
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
