import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ExerciseRoutineManager {
  static Map<String, List<Map<String, String>>> _exerciseRoutines = {};

  // Firestore 및 SharedPreferences에서 운동 루틴 로드
  static Future<void> loadExerciseRoutines() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('exerciseRoutines');
    if (data != null) {
      Map<String, dynamic> jsonData = jsonDecode(data);
      _exerciseRoutines = jsonData.map((key, value) => MapEntry(
          key,
          (value as List)
              .map((item) => Map<String, String>.from(item))
              .toList()));
    }
  }

  // Firestore 및 SharedPreferences에 운동 루틴 저장
  static Future<void> saveExerciseRoutines() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('exerciseRoutines', jsonEncode(_exerciseRoutines));

    FirebaseFirestore.instance
        .collection('exerciseRoutines')
        .doc('user123') // 사용자 ID에 따라 변경 가능
        .set({'data': jsonEncode(_exerciseRoutines)});
  }

  // 새로운 운동 루틴 추가
  static void addRoutine(
      DateTime date, String exercise, int weight, int reps, int sets) {
    String key = date.toIso8601String().split('T').first;
    if (_exerciseRoutines[key] == null) {
      _exerciseRoutines[key] = [];
    }
    _exerciseRoutines[key]!.add({
      'exercise': exercise,
      'details': '${weight}kg / ${reps} reps / ${sets} sets',
    });
    saveExerciseRoutines();
  }

  // 특정 날짜의 운동 루틴 가져오기
  static List<Map<String, String>> getRoutinesForDate(DateTime date) {
    String key = date.toIso8601String().split('T').first;
    return _exerciseRoutines[key] ?? [];
  }

  // 운동 루틴 삭제
  static void deleteRoutine(DateTime date, int index) {
    String key = date.toIso8601String().split('T').first;
    if (_exerciseRoutines[key] != null &&
        _exerciseRoutines[key]!.length > index) {
      _exerciseRoutines[key]!.removeAt(index);
      saveExerciseRoutines();
    }
  }
}
