import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:word_english/provider/user_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // /* 구글 로그인 인스턴스 초기화 */
  // final GoogleSignIn _googleSignIn = GoogleSignIn(
  //   scopes: [
  //     'email',
  //   ],
  // );
  //
  // /* 현재 로그인 사용자 */
  // GoogleSignInAccount? _currentUser;
  //
  // Future<UserCredential> signInWithGoogle() async {
  //   // 로그인 창 띄우고 로그인
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //
  //   if (googleUser == null) {
  //     print('SignIn canceled');
  //   }
  //
  //   // 사용자 인증 정보 가져오기
  //   final GoogleSignInAuthentication? googleAuth =
  //       await googleUser?.authentication;
  //
  //   // 구글 인증 정보를 파이어베이스 인증 정보로 변환
  //   final credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth?.accessToken,
  //     idToken: googleAuth?.idToken,
  //   );
  //
  //   // 파이어베이스 로그인
  //   return await FirebaseAuth.instance.signInWithCredential(credential);
  // }

  @override
  void initState() {
    super.initState();
    // /* 사용자 변경 리스너 설정 */
    // _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
    //   setState(() {
    //     // 현재 사용자 변경(업데이트)
    //     _currentUser = account;
    //   });
    // });
    // // 사용자 로그인 상태를 유지 위해 자동 로그인 시도
    // _googleSignIn.signInSilently();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            try {
              Provider.of<UserProvider>(context, listen: false)
                  .signInWithGoogle();
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: '로그인 실패 : ${e}'.text.make()),
              );
            }
          },
          child: 'Google SignIn'.text.make(),
        ),
      ),
    );
  }
}
