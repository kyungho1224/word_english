import 'package:word_english/model/part_item_model.dart';

class ChapterItem {
  final int chapter;
  final List<PartItem> partItemList;
  int? totalCount;
  DateTime? lastModifiedDate;

  ChapterItem({
    required this.chapter,
    required this.partItemList,
    this.totalCount,
    this.lastModifiedDate,
  });

  factory ChapterItem.fromJson(Map<String, dynamic> json) {
    var list = json['parts'] as List;
    var partDataList = list.map((item) => PartItem.fromJson(item)).toList();
    return ChapterItem(chapter: json['chapter_id'], partItemList: partDataList);
  }
}
