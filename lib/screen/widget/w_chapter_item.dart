import 'package:flutter/material.dart';
import 'package:nav/nav.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:word_english/common/constant/app_colors.dart';
import 'package:word_english/common/widget/widget_constant.dart';
import 'package:word_english/model/chapter_item_model.dart';
import 'package:word_english/screen/widget/w_linear_progress.dart';

import '../s_part.dart';

class ChapterItemWidget extends StatefulWidget {
  final ChapterItem chapterItem;

  const ChapterItemWidget({super.key, required this.chapterItem});

  @override
  State<ChapterItemWidget> createState() => _ChapterItemWidgetState();
}

class _ChapterItemWidgetState extends State<ChapterItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            // Nav.push(PartFragment(chapterItem: widget.chapterItem),
            //     navAni: NavAni.Right);

            // Navigator.pushNamed(
            //   context,
            //   '/part',
            //   arguments: widget.chapterItem,
            // );

            Nav.push(
              PartScreen(
                chapterItem: widget.chapterItem,
              ),
              navAni: NavAni.Right,
            );

            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) {
            //       return PartScreen(chapterItem: widget.chapterItem);
            //     },
            //   ),
            // );
          },
          child: Card(
            elevation: 3,
            color: Theme.of(context).cardColor,
            child: Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 140,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      'Chapter ${widget.chapterItem.chapter}'
                          .text
                          .bold
                          .size(24)
                          .make(),
                      '최근 학습 xx일 전'.text.color(AppColors.grey).make(),
                    ],
                  ).p(16),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomLinearProgress(progress: 0.3),
                        width10,
                        '진행률 %'.text.make()
                      ],
                    ).p(16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
