import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:word_english/model/study_item_model.dart';
import 'package:word_english/provider/study_setting_provider.dart';

import '../../common/widget/widget_constant.dart';

class StudyItemWidget extends StatefulWidget {
  final int chapterIndex;
  final int chapterId;
  final int partIndex;
  final int partId;
  final StudyItem studyItem;

  const StudyItemWidget(
      {super.key,
      required this.chapterIndex,
      required this.chapterId,
      required this.partIndex,
      required this.partId,
      required this.studyItem});

  @override
  State<StudyItemWidget> createState() => _StudyItemWidgetState();
}

class _StudyItemWidgetState extends State<StudyItemWidget> {
  @override
  void initState() {
    super.initState();
    final studyItemProvider =
        Provider.of<StudySettingProvider>(context, listen: false);
    studyItemProvider.getBookmarkState(widget.studyItem.id);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StudySettingProvider>(
      builder: (context, studySettingProvider, child) {
        return GestureDetector(
          onTap: () {
            studySettingProvider.toggle();
          },
          child: Card(
            elevation: 6,
            color: Colors.white,
            shadowColor: Colors.black,
            child: Stack(
              children: [
                Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      widget.studyItem.eWord.text.bold.size(40).make(),
                      height20,
                      studySettingProvider.visible
                          ? widget.studyItem.kWord.text.size(20).make()
                          : ''.text.size(20).make(),
                    ],
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          studySettingProvider
                              .updateBookmark(widget.studyItem.id);
                          String message = studySettingProvider.bookmarked
                              ? '북마크 추가'
                              : '북마크 제거';
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                              duration: const Duration(milliseconds: 500),
                            ),
                          );
                        },
                        icon: Icon(
                          studySettingProvider.bookmarked
                              ? Icons.bookmark_remove_rounded
                              : Icons.bookmark_add_rounded,
                          size: 40,
                          color: studySettingProvider.bookmarked
                              ? Colors.grey
                              : Colors.black,
                        ),
                      ),
                    ],
                  ).p(8),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
