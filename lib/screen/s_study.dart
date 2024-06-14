import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:word_english/model/part_item_model.dart';
import 'package:word_english/provider/study_item_provider.dart';
import 'package:word_english/screen/widget/w_study_item.dart';

import '../common/widget/w_appbar.dart';

class StudyScreen extends StatefulWidget {
  final chapter;
  final PartItem partItem;

  const StudyScreen({
    super.key,
    this.chapter,
    required this.partItem,
  });

  @override
  State<StudyScreen> createState() => _StudyScreenState();
}

class _StudyScreenState extends State<StudyScreen> {
  final PageController _pageController = PageController();
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        showBackButton: false,
      ),
      body: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              'Chapter ${widget.chapter}'.text.bold.size(24).make(),
              'Part ${widget.partItem.partId}'.text.bold.size(20).make(),
            ],
          ).pOnly(left: 16, right: 16, top: 16),
          Expanded(
            child: Stack(
              children: [
                PageView.builder(
                  controller: _pageController,
                  scrollDirection: Axis.vertical,
                  itemCount: widget.partItem.studyItemList.length,
                  itemBuilder: (context, index) {
                    return StudyItemWidget(
                      studyItem: widget.partItem.studyItemList[index],
                    ).pOnly(left: 16, top: 20, right: 16, bottom: 70);
                  },
                ),
                Positioned(
                  left: 30,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: widget.partItem.studyItemList.length,
                        effect: const WormEffect(
                            dotHeight: 10,
                            dotWidth: 10,
                            spacing: 6,
                            dotColor: Colors.grey,
                            activeDotColor: Colors.blue),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 0,
                  right: 0,
                  child: Center(
                    child:
                        '${currentPage + 1} / ${widget.partItem.studyItemList.length}'
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.bookmark_add_sharp,
          size: 30,
          color: Colors.white,
        ),
        onPressed: () {
          print(widget.partItem.studyItemList[currentPage].id);
        },
      ),
    );
  }
}
