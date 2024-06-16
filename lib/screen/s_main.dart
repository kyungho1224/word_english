import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:word_english/screen/widget/w_banner_ads.dart';

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
    MediaQueryData mediaQueryData = MediaQuery.of(context);
    double width = mediaQueryData.size.width;
    double height = 50;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        title: '초등 영어'.text.make(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/bookmark');
            },
            icon: const Icon(Icons.bookmark_added_rounded),
          ),
        ],
      ),
      body: Stack(
        children: [
          const HomeScreen().pOnly(bottom: 20),
          // Positioned(
          //   left: 0,
          //   right: 0,
          //   bottom: 0,
          //   child: Container(
          //     color: Colors.grey[300],
          //     height: 80, // 광고 배너 높이 설정
          //     child: Center(
          //       child: BannerAdWidget(
          //         width: width,
          //         height: 80,
          //         adUnitId: 'ca-app-pub-9806382800193660~9431900098',
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
