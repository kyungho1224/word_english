import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:word_english/common/widget/w_appbar.dart';
import 'package:word_english/model/chapter_item_model.dart';
import 'package:word_english/screen/widget/w_part_item.dart';

import '../model/part_item_model.dart';

class PartScreen extends StatelessWidget {
  final ChapterItem chapterItem;

  const PartScreen({super.key, required this.chapterItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackButton: false,
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15),
        itemCount: chapterItem.partItemList.length,
        itemBuilder: (context, index) {
          List<PartItem> currentList = chapterItem.partItemList;
          return PartItemWidget(
            chapter: chapterItem.chapter,
            partItem: currentList[index],
          );
        },
      ).pOnly(top: 20, bottom: 65, left: 20, right: 20),
    );
  }
}
