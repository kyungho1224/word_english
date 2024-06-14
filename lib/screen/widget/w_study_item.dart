import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:word_english/model/study_item_model.dart';
import 'package:word_english/provider/study_item_provider.dart';

import '../../common/widget/widget_constant.dart';

class StudyItemWidget extends StatefulWidget {
  final StudyItem studyItem;

  const StudyItemWidget({super.key, required this.studyItem});

  @override
  State<StudyItemWidget> createState() => _StudyItemWidgetState();
}

class _StudyItemWidgetState extends State<StudyItemWidget> {
  @override
  Widget build(BuildContext context) {
    // bool visible =
    //     Provider.of<StudyItemProvider>(context, listen: false).visible;
    return Consumer<StudyItemProvider>(
      builder: (context, studyItemProvider, child) {
        return GestureDetector(
          onTap: () {
            studyItemProvider.toggle();
          },
          child: Card(
            elevation: 6,
            color: Colors.white,
            shadowColor: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.studyItem.eWord.text.bold.size(40).make(),
                height20,
                studyItemProvider.visible
                    ? widget.studyItem.kWord.text.size(20).make()
                    : ''.text.size(20).make(),
              ],
            ),
          ),
        );
      },
    );
  }
}
