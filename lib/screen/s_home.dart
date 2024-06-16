import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:word_english/provider/chapter_list_provider.dart';
import 'package:word_english/screen/widget/w_chapter_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() async {
    Provider.of<ChapterListProvider>(context, listen: false).fetchChapters();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<ChapterListProvider>(context, listen: false).fetchChapters();
  }

  @override
  Widget build(BuildContext context) {
    print('call build');
    return Consumer<ChapterListProvider>(
      builder: (context, chapterListProvider, child) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              chapterListProvider.chapterList.isEmpty
                  ? const Center(
                child: CircularProgressIndicator(),
              )
                  : ListView.separated(
                separatorBuilder: (context, index) => const Divider(
                  thickness: 1,
                  color: Colors.transparent,
                ),
                itemBuilder: (context, index) {
                  return ChapterItemWidget(
                    chapterIndex: index,
                    chapterId: chapterListProvider
                        .chapterList[index].chapter,
                  );
                },
                itemCount: chapterListProvider.chapterList.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
              ),
            ],
          ).pOnly(
            top: 20,
            bottom: 20,
            left: 20,
            right: 20,
          ),
        );
      },
    );
  }
}
