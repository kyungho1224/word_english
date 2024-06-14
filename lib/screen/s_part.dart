import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:word_english/common/widget/w_appbar.dart';
import 'package:word_english/common/widget/widget_constant.dart';
import 'package:word_english/model/chapter_item_model.dart';

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
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    'Part'.text.size(24).bold.make(),
                    width10,
                    currentList[index].partId.text.size(24).bold.make(),
                  ],
                ),
                '${0} / ${currentList[index].studyItemList.length}'
                    .text
                    .size(20)
                    .make(),
              ],
            ).p(16),
          );
        },
      ).pOnly(top: 20, bottom: 65, left: 20, right: 20),
    );
  }
}
