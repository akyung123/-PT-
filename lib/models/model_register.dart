// model_register.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterFieldModel extends ChangeNotifier {
  String email = "";
  String password = "";
  String passwordConfirm = "";

  void setEmail(String email) {
    this.email = email;
    notifyListeners();
  }

  void setPassword(String password) {
    this.password = password;
    notifyListeners();
  }

  void setPasswordConfirm(String passwordConfirm) {
    this.passwordConfirm = passwordConfirm;
    notifyListeners();
  }

  Future<void> registerWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      // 회원가입 성공 시 추가 작업 (예: 사용자 Firestore에 저장)
      print("회원가입 성공: ${userCredential.user?.uid}");
    } on FirebaseAuthException catch (e) {
      print("회원가입 실패: ${e.message}");
      rethrow;
    } catch (e) {
      print("알 수 없는 오류: $e");
      rethrow;
    }
  }
}
