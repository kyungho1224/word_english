import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserProvider with ChangeNotifier {

  UserProvider() {
    checkCurrentUser();
  }

  User? _user;

  User? get user => _user;

  void setUser(User? user) {
    _user = user;
    notifyListeners();
  }

  Future<void> checkCurrentUser() async {
    _user = FirebaseAuth.instance.currentUser;
    notifyListeners();
  }

  Future<void> signInWithGoogle() async {
    // 로그인 창 띄우고 로그인
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // 사용자 인증 정보 가져오기
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // 구글 인증 정보를 파이어베이스 인증 정보로 변환
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // 파이어베이스 로그인
    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    setUser(userCredential.user);
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    setUser(null);
  }
}
