import 'package:flutter/material.dart';
import 'package:word_english/common/widget/w_appbar.dart';

import 's_home.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int index;

  @override
  void initState() {
    super.initState();
    index = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackButton: false,
      ),
      body: Stack(
        children: [
          // Navigator(
          //   key: ,
          // ),
          const HomeScreen(),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: Colors.grey[300],
              height: 60, // 광고 배너 높이 설정
              child: const Center(
                child: Text("광고 배너"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
