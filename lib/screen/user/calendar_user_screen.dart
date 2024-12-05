// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:table_calendar/table_calendar.dart';

// class CalendarUserScreen extends StatefulWidget {
//   final DateTime initialDate;

//   const CalendarUserScreen({Key? key, required this.initialDate})
//       : super(key: key);

//   @override
//   _CalendarUserScreenState createState() => _CalendarUserScreenState();
// }

// class _CalendarUserScreenState extends State<CalendarUserScreen> {
//   late DateTime _selectedDate;

//   @override
//   void initState() {
//     super.initState();
//     _selectedDate = widget.initialDate; // 초기 날짜 설정
//     _selectedDateContent = "";
//   }

//   // DateTime _selectedDate = DateTime.now();
//   String _selectedDateContent = ""; // 선택한 날짜의 내용 (기본값: 빈 문자열)

//   @override
//   Widget build(BuildContext context) {
//     String formattedDate =
//         "${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}";

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Calendar User Screen',
//           style: TextStyle(color: Colors.black),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         iconTheme: const IconThemeData(color: Colors.black),
//       ),
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 16),
//           // 달력 위젯
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: CalendarDatePicker(
//               initialDate: _selectedDate,
//               firstDate: DateTime(2020),
//               lastDate: DateTime(2030),
//               onDateChanged: (date) {
//                 setState(() {
//                   _selectedDate = date;
//                   _selectedDateContent = ""; // 새로운 날짜 선택 시 초기화
//                 });

//                 // 팝업 창 띄우기
//                 showDialog(
//                   context: context,
//                   builder: (BuildContext context) {
//                     return AlertDialog(
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       title: const Text(
//                         "Selected Date",
//                         style: TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                       content: Column(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Text(
//                             "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
//                             style: const TextStyle(fontSize: 18),
//                           ),
//                           const SizedBox(height: 16),
//                           const Text(
//                             "No content available for this date.",
//                             style: TextStyle(color: Colors.grey),
//                           ),
//                         ],
//                       ),
//                       actions: [
//                         TextButton(
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                           },
//                           child: const Text(
//                             "Close",
//                             style: TextStyle(color: Colors.black),
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           const SizedBox(height: 16),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Text(
//               "Selected Date: $formattedDate",
//               style: const TextStyle(fontSize: 18, color: Colors.black),
//             ),
//           ),
//           const SizedBox(height: 16),
//           // 내용란
//           Expanded(
//             child: Container(
//               margin: const EdgeInsets.all(16),
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: Colors.grey, width: 1),
//               ),
//               child: _selectedDateContent.isEmpty
//                   ? const Center(
//                       child: Text(
//                         "No content for this date.",
//                         style: TextStyle(color: Colors.grey),
//                       ),
//                     )
//                   : Text(
//                       _selectedDateContent,
//                       style: const TextStyle(fontSize: 16, color: Colors.black),
//                     ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CalendarUserScreen extends StatefulWidget {
  final DateTime initialDate;

  const CalendarUserScreen({Key? key, required this.initialDate})
      : super(key: key);

  @override
  _CalendarUserScreenState createState() => _CalendarUserScreenState();
}

class _CalendarUserScreenState extends State<CalendarUserScreen> {
  late DateTime _selectedDate;
  Map<String, List<String>> _exerciseVideos = {};

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _loadExerciseVideos();
  }

  Future<void> _loadExerciseVideos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('exerciseVideos');
    if (data != null) {
      Map<String, dynamic> jsonData = jsonDecode(data);
      setState(() {
        _exerciseVideos = jsonData.map(
            (key, value) => MapEntry(key, List<String>.from(value as List)));
      });
    }
  }

  Future<void> _saveExerciseVideos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('exerciseVideos', jsonEncode(_exerciseVideos));

    // Firebase에 저장
    FirebaseFirestore.instance
        .collection('exerciseVideos')
        .doc('user123') // 사용자 ID에 따라 다르게 설정 가능
        .set({'data': jsonEncode(_exerciseVideos)});
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDate = selectedDay;
    });
  }

  void _addVideo(String videoTitle) {
    setState(() {
      String key = _selectedDate.toIso8601String().split('T').first;
      if (_exerciseVideos[key] == null) {
        _exerciseVideos[key] = [];
      }
      _exerciseVideos[key]!.add(videoTitle);
      _saveExerciseVideos();
    });
  }

  Future<void> _showAddVideoDialog() async {
    String newVideoTitle = '';
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Video'),
        content: TextField(
          onChanged: (value) => newVideoTitle = value,
          decoration: InputDecoration(hintText: "Enter video title"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (newVideoTitle.isNotEmpty) {
                _addVideo(newVideoTitle);
              }
              Navigator.pop(context);
            },
            child: Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String key = _selectedDate.toIso8601String().split('T').first;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar User Screen'),
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          TableCalendar(
            calendarFormat: CalendarFormat.month,
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _selectedDate,
            selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
            onDaySelected: _onDaySelected,
            calendarStyle: CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Colors.purple,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.purple[100],
                shape: BoxShape.circle,
              ),
              defaultTextStyle: TextStyle(color: Colors.black),
              weekendTextStyle: TextStyle(color: Colors.red),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: (_exerciseVideos[key] ?? []).map((videoTitle) {
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8)),
                      child: const Icon(Icons.play_arrow, color: Colors.white),
                    ),
                    title: Text(videoTitle),
                    subtitle: Text('Description for $videoTitle'),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddVideoDialog,
        backgroundColor: Colors.purple,
        child: const Icon(Icons.add),
      ),
    );
  }
}
