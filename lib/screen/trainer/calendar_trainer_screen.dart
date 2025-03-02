import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarTrainer extends StatelessWidget {
  const CalendarTrainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calendar App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalendarTrainerScreen(),
    );
  }
}

class CalendarTrainerScreen extends StatefulWidget {
  const CalendarTrainerScreen({Key? key}) : super(key: key);

  @override
  _CalendarTrainerScreenState createState() => _CalendarTrainerScreenState();
}

class _CalendarTrainerScreenState extends State<CalendarTrainerScreen> {
  late DateTime _selectedDay;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = DateTime.now();
    _focusedDay = DateTime.now();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay; // update `_focusedDay` here as well
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        backgroundColor: Colors.blue,
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          TableCalendar(
            calendarFormat: CalendarFormat.month,
            availableCalendarFormats: const {
              CalendarFormat.month: '1 Month', // 월 모드만 표시
            },
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: _onDaySelected,
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
