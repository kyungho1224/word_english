import 'package:flutter/material.dart';

class CustomLinearProgress extends StatelessWidget {
  final double progress;
  const CustomLinearProgress({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 10, // 진행 표시기의 높이 설정
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5), // 둥근 모서리 설정
          color: Colors.grey.shade300, // 배경색 설정
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5), // 둥근 모서리 설정
          child: LinearProgressIndicator(
            value: progress, // 진행률 값
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue), // 진행률 색상 설정
            backgroundColor: Colors.grey.shade300, // 배경색 설정
          ),
        ),
      ),
    );
  }
}
