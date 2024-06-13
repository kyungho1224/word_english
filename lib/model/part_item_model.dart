import 'package:word_english/model/study_item_model.dart';

class PartItem {
  final int partId;
  final List<StudyItem> studyItemList;

  PartItem({
    required this.partId,
    required this.studyItemList,
  });

  factory PartItem.fromJson(Map<String, dynamic> json) {
    var tmpList = json['data'] as List;
    var studyDataList =
        tmpList.map((item) => StudyItem.fromJson(item)).toList();
    return PartItem(partId: json['part_id'], studyItemList: studyDataList);
  }
}