import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> loginUser(String email, String password) async {
    try {
      // Firebase 로그인
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      String userId = userCredential.user!.uid;

      // Firestore에서 사용자 유형 가져오기
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();

      if (userDoc.exists) {
        return userDoc['userType'];
      } else {
        return null; // 사용자 정보를 찾을 수 없음
      }
    } catch (e) {
      throw Exception('로그인 실패: ${e.toString()}');
    }
  }
}
