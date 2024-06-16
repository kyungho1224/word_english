import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:velocity_x/velocity_x.dart';
import 'package:word_english/common/constant/app_colors.dart';
import 'package:word_english/common/widget/widget_constant.dart';
import 'package:word_english/provider/chapter_list_provider.dart';
import 'package:word_english/screen/widget/w_linear_progress.dart';

class ChapterItemWidget extends StatefulWidget {
  final int chapterIndex;
  final int chapterId;

  const ChapterItemWidget(
      {super.key, required this.chapterIndex, required this.chapterId});

  @override
  State<ChapterItemWidget> createState() => _ChapterItemWidgetState();
}

class _ChapterItemWidgetState extends State<ChapterItemWidget> {
  @override
  Widget build(BuildContext context) {
    timeago.setLocaleMessages('ko', timeago.KoMessages());

    return Consumer<ChapterListProvider>(
      builder: (context, chapterListProvider, child) {
        int current =
            chapterListProvider.progressCounterByChapterId(widget.chapterIndex);
        int max =
            chapterListProvider.chapterList[widget.chapterIndex].totalCount ??
                400;
        double progress = current / max;
        return Column(
          children: [
            GestureDetector(
              onLongPress: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            '정말로 학습 데이터를 삭제하시겠습니까?',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          const SizedBox(height: 20.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context); // 닫기
                                },
                                child: const Text('취소'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  // TODO: 데이터 삭제 로직 추가
                                  await chapterListProvider
                                      .deleteProgressByChapterId(
                                          widget.chapterId);
                                  Navigator.pop(context); // 닫기
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text('학습 데이터가 삭제되었습니다')),
                                  );
                                },
                                child: const Text('삭제'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              onTap: () {
                Navigator.pushNamed(context, '/part', arguments: {
                  'chapterIndex': widget.chapterIndex,
                  'chapterId': widget.chapterId,
                });
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
                          'Chapter ${chapterListProvider.chapterList[widget.chapterIndex].chapter}'
                              .text
                              .bold
                              .size(24)
                              .make(),
                          chapterListProvider.chapterList[widget.chapterIndex]
                                      .lastModifiedDate ==
                                  null
                              ? '학습 기록 없음'.text.color(AppColors.grey).make()
                              : '최근 학습 ${timeago.format(
                                  chapterListProvider
                                      .chapterList[widget.chapterIndex]
                                      .lastModifiedDate!,
                                  locale: 'ko',
                                )}'
                                  .text
                                  .color(Colors.black)
                                  .make(),
                        ],
                      ).p(16),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomLinearProgress(progress: progress),
                            width10,
                            '진행률 ${(progress * 100).toStringAsFixed(2)}%'
                                .text
                                .make()
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
      },
    );
  }
}
