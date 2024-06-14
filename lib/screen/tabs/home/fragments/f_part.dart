import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:word_english/model/chapter_item_model.dart';

import '../../../../provider/package_info_provider.dart';

class PartFragment extends StatelessWidget {
  final ChapterItem chapterItem;

  const PartFragment({super.key, required this.chapterItem});

  @override
  Widget build(BuildContext context) {
    final appName =
        Provider.of<PackageInfoProvider>(context, listen: false).appName;
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        title: appName.text.make(),
        shadowColor: Colors.black,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15
        ),
        itemCount: chapterItem.partItemList.length,
        itemBuilder: (context, index) {
          return Container(
            color: context.accentColor,
            child: chapterItem.partItemList[index].partId.text.make(),
          );
        },
      ),
    );
  }
}
