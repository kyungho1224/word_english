import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:word_english/database/database_helper.dart';
import 'package:word_english/model/study_item_model.dart';
import 'package:word_english/provider/chapter_list_provider.dart';
import 'package:word_english/provider/study_setting_provider.dart';
import 'package:word_english/screen/widget/w_study_item.dart';

class StudyScreen extends StatefulWidget {
  final int chapterIndex;
  final int chapterId;
  final int partIndex;
  final int partId;

  const StudyScreen({
    super.key,
    required this.chapterIndex,
    required this.chapterId,
    required this.partIndex,
    required this.partId,
  });

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  final dbHelper = DatabaseHelper.instance;
  final PageController _pageController = PageController();
  int currentPage = 0;
  List<StudyItem> studyItemList = [];
  late ChapterListProvider provider;

  void _onPageChanged() async {
    int newPage = _pageController.page?.round() ?? 0;
    if (newPage != currentPage) {
      currentPage = newPage;
      _handlePageChange(currentPage);
    }
  }

  void _handlePageChange(int page) async {
    provider.updateProgressWord(
        widget.chapterId, widget.partId, studyItemList[currentPage].id);
    setState(() {});
  }

  void _saveLastModifiedDate() async {
    provider.updateChapterLastModifiedDate(widget.chapterId);
  }

  @override
  void initState() {
    super.initState();
    provider = Provider.of<ChapterListProvider>(context, listen: false);
    studyItemList = provider.chapterList[widget.chapterIndex]
        .partItemList[widget.partIndex].studyItemList;
    _pageController.addListener(_onPageChanged);
    currentPage = _pageController.initialPage;
    _handlePageChange(currentPage);
  }

  @override
  void didChangeDependencies() {
    _saveLastModifiedDate();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _pageController.removeListener(_onPageChanged);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChapterListProvider>(
      builder: (context, chapterListProvider, child) {
        return ChangeNotifierProvider(
          create: (_) => StudySettingProvider(),
          child: Scaffold(
            appBar: AppBar(
              elevation: 2,
              backgroundColor: Colors.white,
              shadowColor: Colors.black,
              title: '초등 영어'.text.make(),
            ),
            body: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    'Chapter ${widget.chapterId}'.text.bold.size(24).make(),
                    'Part ${widget.partId}'.text.bold.size(20).make(),
                  ],
                ).pOnly(left: 16, right: 16, top: 16),
                Expanded(
                  child: Stack(
                    children: [
                      PageView.builder(
                        controller: _pageController,
                        scrollDirection: Axis.vertical,
                        itemCount: chapterListProvider
                            .chapterList[widget.chapterIndex]
                            .partItemList[widget.partIndex]
                            .studyItemList
                            .length,
                        itemBuilder: (context, index) {
                          return StudyItemWidget(
                            chapterIndex: widget.chapterIndex,
                            chapterId: widget.chapterId,
                            partIndex: widget.partIndex,
                            partId: widget.partId,
                            studyItem: studyItemList[index],
                          ).pOnly(left: 16, top: 20, right: 16, bottom: 70);
                        },
                      ),
                      Positioned(
                        bottom: 30,
                        left: 0,
                        right: 0,
                        child: Center(
                          child:
                              '${currentPage + 1} / ${chapterListProvider.chapterList[widget.chapterIndex].partItemList[widget.partIndex].studyItemList.length}'
                                  .text
                                  .size(16)
                                  .bold
                                  .make(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
