import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:word_english/provider/chapter_list_provider.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({Key? key}) : super(key: key);

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ChapterListProvider>(context, listen: false).fetchChapters();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChapterListProvider>(
      builder: (context, chapterListProvider, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 2,
            backgroundColor: Colors.white,
            shadowColor: Colors.black,
            title: '초등 영어'.text.make(),
          ),
          body: chapterListProvider.getBookmarkWordList().isEmpty
              ? Center(
                  child: '북마크 목록이 없습니다'.text.make(),
                )
              : ListView.builder(
                  itemCount: chapterListProvider.getBookmarkWordList().length,
                  itemBuilder: (context, chapterIndex) {
                    final chapter =
                        chapterListProvider.getBookmarkWordList()[chapterIndex];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        'Chapter ${chapter.chapter}'.text.bold.size(24).make(),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: chapter.partItemList.length,
                          itemBuilder: (context, partIndex) {
                            final part = chapter.partItemList[partIndex];
                            return Card(
                              color: Colors.red.shade100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  'Part ${part.partId}'.text.bold.size(20).make(),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: part.studyItemList.length,
                                    itemBuilder: (context, studyIndex) {
                                      final studyItem =
                                          part.studyItemList[studyIndex];
                                      return Card(
                                        color: Colors.white,
                                        child: ListTile(
                                          title: Text(studyItem.eWord),
                                          subtitle: Text(studyItem.kWord),
                                          trailing: IconButton(
                                            onPressed: () async {
                                              await chapterListProvider
                                                  .updateBookmark(studyItem.id);
                                              setState(() {});
                                            },
                                            icon: const Icon(
                                                Icons.bookmark_remove_rounded),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ).p(8),
                            );
                          },
                        ),
                      ],
                    ).p(8);
                  },
                ),
        );
      },
    );
  }
}
