import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:word_english/provider/chapter_list_provider.dart';
import 'package:word_english/screen/widget/w_part_item.dart';

import '../model/part_item_model.dart';

class PartScreen extends StatefulWidget {
  final int chapterIndex;
  final int chapterId;

  const PartScreen(
      {super.key, required this.chapterIndex, required this.chapterId});

  @override
  State<PartScreen> createState() => _PartScreenState();
}

class _PartScreenState extends State<PartScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<ChapterListProvider>(context, listen: false).fetchChapters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        title: '초등 영어'.text.make(),
      ),
      body: Consumer<ChapterListProvider>(
        builder: (context, chapterListProvider, child) {
          return Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  'Chapter ${widget.chapterId}'.text.bold.size(24).make(),
                ],
              ).pOnly(left: 16, right: 16, top: 16),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: chapterListProvider
                      .chapterList[widget.chapterIndex].partItemList.length,
                  itemBuilder: (context, index) {
                    List<PartItem> currentList = chapterListProvider
                        .chapterList[widget.chapterIndex].partItemList;
                    return PartItemWidget(
                      chapterIndex: widget.chapterIndex,
                      chapterId: widget.chapterId,
                      partIndex: index,
                      partId: currentList[index].partId,
                    );
                  },
                ).pOnly(top: 20, bottom: 65, left: 20, right: 20),
              ),
            ],
          );
        },
      ),
    );
  }
}
