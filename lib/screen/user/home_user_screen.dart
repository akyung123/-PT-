import 'package:flutter/material.dart';
import 'package:health_mate/screen/user/profile_user_screen.dart';
import 'calendar_user_screen.dart';
import 'chat_user_screen.dart';
import 'package:intl/intl.dart'; // 날짜 형식화를 위한 패키지
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:table_calendar/table_calendar.dart';
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

  void _onDateChanged(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
      _exerciseRoutines =
          ExerciseRoutineManager.getRoutinesForDate(_selectedDate);
    });
  }

  Future<void> _showAddRoutineDialog() async {
    String exerciseName = '';
    int weight = 0;
    int reps = 0;
    int sets = 0;

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Exercise Routine'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              onChanged: (value) => exerciseName = value,
              decoration: const InputDecoration(
                hintText: "Enter exercise name",
                hintStyle: TextStyle(color: Colors.grey),
                border: UnderlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            _buildNumberInputRow(
                "Weight (kg)", weight, (value) => weight = value),
            _buildNumberInputRow("Reps", reps, (value) => reps = value),
            _buildNumberInputRow("Sets", sets, (value) => sets = value),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.black)),
          ),
          TextButton(
            onPressed: () {
              if (exerciseName.isNotEmpty) {
                ExerciseRoutineManager.addRoutine(
                    _selectedDate, exerciseName, weight, reps, sets);
                setState(() {
                  _exerciseRoutines =
                      ExerciseRoutineManager.getRoutinesForDate(_selectedDate);
                });
              }
              Navigator.pop(context);
            },
            child: const Text('Add', style: TextStyle(color: Colors.black)),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberInputRow(
      String label, int initialValue, Function(int) onChanged) {
    TextEditingController controller =
        TextEditingController(text: initialValue.toString());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.black)),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.do_not_disturb_on, color: Colors.black),
              onPressed: () {
                int newValue = (int.parse(controller.text) - 5)
                    .clamp(0, double.infinity)
                    .toInt();
                controller.text = newValue.toString();
                onChanged(newValue);
              },
            ),
            IconButton(
              icon: const Icon(Icons.remove, color: Colors.black),
              onPressed: () {
                int newValue = (int.parse(controller.text) - 1)
                    .clamp(0, double.infinity)
                    .toInt();
                controller.text = newValue.toString();
                onChanged(newValue);
              },
            ),
            Container(
              width: 40,
              child: TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                onChanged: (value) =>
                    onChanged(int.tryParse(value) ?? initialValue),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.add, color: Colors.black),
              onPressed: () {
                int newValue = (int.parse(controller.text) + 1).toInt();
                controller.text = newValue.toString();
                onChanged(newValue);
              },
            ),
            IconButton(
              icon: const Icon(Icons.add_circle, color: Colors.black),
              onPressed: () {
                int newValue = (int.parse(controller.text) + 5).toInt();
                controller.text = newValue.toString();
                onChanged(newValue);
              },
            ),
          ],
        ),
      ],
    );
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
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
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
                                CalendarUserScreen(initialDate: date)),
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
                        isSelected
                            ? 'Today, ${DateFormat('dd').format(date)}'
                            : DateFormat('dd').format(date),
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
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
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

// 운동 루틴 섹션
              const Text(
                '운동 루틴',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),

              const SizedBox(height: 16),

// 운동 루틴 목록
              Expanded(
                child: ListView.builder(
                  itemCount: _exerciseRoutines.length,
                  itemBuilder: (context, index) {
                    final routine = _exerciseRoutines[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        leading: const Icon(Icons.fitness_center,
                            color: Colors.black),
                        title: Text(routine['exercise'] ?? '',
                            style: const TextStyle(color: Colors.black)),
                        subtitle: Text(routine['details'] ?? '',
                            style: const TextStyle(color: Colors.grey)),
                        trailing: IconButton(
                          icon: Icon(Icons.close, color: Colors.black),
                          onPressed: () {
                            ExerciseRoutineManager.deleteRoutine(
                                _selectedDate, index);
                            setState(() {});
                          },
                        ),
                      ),
                    );
                  },
                ),
              ),

// 운동 루틴 추가 버튼
              FloatingActionButton(
                onPressed: _showAddRoutineDialog,
                backgroundColor: Colors.black,
                child: const Icon(Icons.add, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
