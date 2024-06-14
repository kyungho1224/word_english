import 'package:flutter/material.dart';
import 'package:nav/nav.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:word_english/model/part_item_model.dart';
import 'package:word_english/screen/s_study.dart';

import '../../common/widget/widget_constant.dart';

class PartItemWidget extends StatefulWidget {
  final chapter;
  final PartItem partItem;

  const PartItemWidget({
    super.key,
    required this.chapter,
    required this.partItem,
  });

  @override
  State<PartItemWidget> createState() => _PartItemWidgetState();
}

class _PartItemWidgetState extends State<PartItemWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Nav.push(
          StudyScreen(
            chapter: widget.chapter,
            partItem: widget.partItem,
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
                width10,
                widget.partItem.partId.text.size(24).bold.make(),
              ],
            ),
            '${0} / ${widget.partItem.studyItemList.length}'
                .text
                .size(20)
                .make(),
          ],
        ).p(16),
      ),
    );
  }
}
