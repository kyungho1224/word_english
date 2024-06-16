import 'package:flutter/material.dart';
import 'package:nav/nav.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:word_english/provider/chapter_list_provider.dart';
import 'package:word_english/screen/s_study.dart';

import '../../common/widget/widget_constant.dart';

class PartItemWidget extends StatefulWidget {
  final int chapterIndex;
  final int chapterId;
  final int partIndex;
  final int partId;

  const PartItemWidget({
    super.key,
    required this.chapterIndex,
    required this.chapterId,
    required this.partIndex,
    required this.partId,
  });

  @override
  State<PartItemWidget> createState() => _PartItemWidgetState();
}

class _PartItemWidgetState extends State<PartItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChapterListProvider>(
      builder: (context, chapterListProvider, child) {
        int progressCount = chapterListProvider.progressCounterByPartId(
            widget.chapterIndex, widget.partIndex);
        int allCount = chapterListProvider.chapterList[widget.chapterIndex]
            .partItemList[widget.partIndex].studyItemList.length;
        return GestureDetector(
          onTap: () {
            Nav.push(
              StudyScreen(
                chapterIndex: widget.chapterIndex,
                chapterId: widget.chapterId,
                partIndex: widget.partIndex,
                partId: widget.partId,
              ),
              navAni: NavAni.Right,
            );
          },
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    'Part'.text.size(24).bold.make(),
                    width5,
                    chapterListProvider.chapterList[widget.chapterIndex]
                        .partItemList[widget.partIndex].partId.text
                        .size(24)
                        .bold
                        .make(),
                    Expanded(child: Container()),
                    progressCount == allCount
                        ? const Icon(Icons.star)
                        : const Icon(Icons.star_border),
                  ],
                ),
                '$progressCount / $allCount'.text.size(20).make(),
              ],
            ).p(16),
          ),
        );
      },
    );
  }
}
