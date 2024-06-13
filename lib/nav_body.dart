import 'package:flutter/material.dart';
import 'package:word_english/screen/community/s_community.dart';
import 'package:word_english/screen/home/s_home.dart';
import 'package:word_english/screen/my/s_my.dart';
import 'package:word_english/screen/others/s_others.dart';

class NavBody extends StatelessWidget {
  final int index;

  const NavBody({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return const HomeScreen();
    } else if (index == 1) {
      return const MyScreen();
    } else if (index == 2) {
      return const CommunityScreen();
    }
    return const OthersScreen();
  }
}
