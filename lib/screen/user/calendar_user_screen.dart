import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarUserScreen extends StatefulWidget {
  final String memberId;

  CalendarUserScreen({required this.memberId});

  @override
  _CalendarUserScreenState createState() => _CalendarUserScreenState();
}

class _CalendarUserScreenState extends State<CalendarUserScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  DateTime _focusedDay = DateTime.now();
  Map<DateTime, List<String>> _tasks = {}; // 날짜별 할 일 목록

  @override
  void initState() {
    super.initState();
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    final snapshot = await _firestore
        .collection('tasks')
        .where('memberId', isEqualTo: widget.memberId)
        .get();

    Map<DateTime, List<String>> tasks = {};
    for (var doc in snapshot.docs) {
      final data = doc.data();
      final date = DateTime.parse(data['date']);
      if (!tasks.containsKey(date)) {
        tasks[date] = [];
      }
      tasks[date]!.add(data['taskName']);
    }

    setState(() {
      _tasks = tasks;
    });
  }

  List<String> _getTasksForDay(DateTime day) {
    return _tasks[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('회원 캘린더'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(day, _focusedDay),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _focusedDay = selectedDay;
              });
            },
          ),
          Expanded(
            child: ListView(
              children: _getTasksForDay(_focusedDay)
                  .map((task) => ListTile(title: Text(task)))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
