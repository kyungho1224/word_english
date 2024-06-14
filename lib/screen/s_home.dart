import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:word_english/common/widget/widget_constant.dart';
import 'package:word_english/screen/widget/w_banner.dart';
import 'package:word_english/screen/widget/w_chapter_item.dart';
import 'package:word_english/util/local_json.dart';

import '../../model/chapter_item_model.dart';
import '../common/widget/w_appbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChapterItem> chapterList = [];

  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    final list = await LocalJson.getObjectList<ChapterItem>("json/data.json");
    setState(() {
      chapterList = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BannerWidget(height: 100).p(8), // 배너 이미지
            height20,
            chapterList.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.separated(
                    separatorBuilder: (context, index) => const Divider(
                      thickness: 1,
                      color: Colors.transparent,
                    ),
                    itemBuilder: (context, index) {
                      return ChapterItemWidget(chapterItem: chapterList[index]);
                    },
                    itemCount: chapterList.length,
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(), // SingleChildScrollView로 스크롤을 대신함
                  ),
          ],
        ).pOnly(top: 20, bottom: 65, left: 20, right: 20),
      ),
    );
  }
}