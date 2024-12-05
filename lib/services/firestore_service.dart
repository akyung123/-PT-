import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Firestore에 사용자 정보를 저장하는 함수
Future<void> saveUserToFirestore(
    String userId, String email, String userType) async {
  try {
    // Firestore의 "users" 컬렉션에 데이터 저장
    await FirebaseFirestore.instance.collection('users').doc(userId).set({
      'email': email,
      'userType': userType,
      'createdAt': FieldValue.serverTimestamp(),
    });
    print('회원 정보 Firestore에 저장 완료');
  } catch (e) {
    print('Firestore 저장 오류: $e');
  }
}

// 회원가입 처리 함수
Future<void> registerUser(
    String email, String password, String userType) async {
  try {
    // Firebase Authentication에서 사용자 생성
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // 사용자 UID 가져오기
    String userId = userCredential.user!.uid;

    // Firestore에 사용자 정보 저장
    await saveUserToFirestore(userId, email, userType);

    print('회원가입 성공');
  } catch (e) {
    print('회원가입 오류: $e');
  }
}

// 운동 루틴을 Firestore에 저장하는 함수
Future<void> saveRoutineToFirestore(
    String userId, String exercise, String details) async {
  try {
    await FirebaseFirestore.instance.collection('routines').add({
      'userId': userId,
      'exercise': exercise,
      'details': details,
      'createdAt': FieldValue.serverTimestamp(),
    });
    print('운동 루틴 Firestore에 저장 완료');
  } catch (e) {
    print('Firestore 저장 오류: $e');
  }
}

// Firestore에서 운동 루틴을 불러오는 함수
Future<List<Map<String, String>>> loadRoutinesFromFirestore(
    String userId) async {
  try {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('routines')
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs.map((doc) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      return {
        'id': doc.id,
        'exercise': data['exercise'] as String? ?? '',
        'details': data['details'] as String? ?? '',
      };
    }).toList();
  } catch (e) {
    print('Firestore 불러오기 오류: $e');
    return [];
  }
}
