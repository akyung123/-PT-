import 'package:cloud_firestore/cloud_firestore.dart';

class TaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // 특정 회원의 할 일 목록 가져오기
  Future<List<Map<String, dynamic>>> getTasksForMember(String memberId) async {
    try {
      final snapshot = await _firestore
          .collection('tasks')
          .where('memberId', isEqualTo: memberId)
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id; // Firestore 문서 ID 추가
        return data;
      }).toList();
    } catch (e) {
      throw Exception('할 일 목록 가져오기 실패: ${e.toString()}');
    }
  }

  // 특정 날짜의 할 일 목록 가져오기
  Future<List<Map<String, dynamic>>> getTasksForDate(
      String memberId, DateTime date) async {
    try {
      final snapshot = await _firestore
          .collection('tasks')
          .where('memberId', isEqualTo: memberId)
          .where('date', isEqualTo: date.toIso8601String().split('T')[0])
          .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id; // Firestore 문서 ID 추가
        return data;
      }).toList();
    } catch (e) {
      throw Exception('특정 날짜의 할 일 가져오기 실패: ${e.toString()}');
    }
  }

  // 새로운 할 일 추가
  Future<void> addTask({
    required String memberId,
    required String trainerId,
    required String taskName,
    required DateTime date,
  }) async {
    try {
      final task = {
        'memberId': memberId,
        'trainerId': trainerId,
        'taskName': taskName,
        'date': date.toIso8601String().split('T')[0], // 날짜만 저장
        'completed': false, // 기본값: 완료되지 않음
      };

      await _firestore.collection('tasks').add(task);
    } catch (e) {
      throw Exception('새로운 할 일 추가 실패: ${e.toString()}');
    }
  }

  // 할 일 완료 상태 업데이트
  Future<void> updateTaskCompletion({
    required String taskId,
    required bool completed,
  }) async {
    try {
      await _firestore
          .collection('tasks')
          .doc(taskId)
          .update({'completed': completed});
    } catch (e) {
      throw Exception('할 일 완료 상태 업데이트 실패: ${e.toString()}');
    }
  }

  // 할 일 수정
  Future<void> updateTask({
    required String taskId,
    required String taskName,
    required DateTime date,
  }) async {
    try {
      await _firestore.collection('tasks').doc(taskId).update({
        'taskName': taskName,
        'date': date.toIso8601String().split('T')[0],
      });
    } catch (e) {
      throw Exception('할 일 수정 실패: ${e.toString()}');
    }
  }

  // 할 일 삭제
  Future<void> deleteTask(String taskId) async {
    try {
      await _firestore.collection('tasks').doc(taskId).delete();
    } catch (e) {
      throw Exception('할 일 삭제 실패: ${e.toString()}');
    }
  }
}
