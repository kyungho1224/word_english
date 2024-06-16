class StudyItem {
  final int id;
  final String eWord;
  final String kWord;
  final String eSentence;
  final String kSentence;
  final bool bookmark;
  final bool viewer;

  StudyItem({
    required this.id,
    required this.eWord,
    required this.kWord,
    required this.eSentence,
    required this.kSentence,
    required this.bookmark,
    required this.viewer,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'e_word': eWord,
      'k_word': kWord,
      'e_sentence': eSentence,
      'k_sentence': kSentence,
      'bookmark': bookmark ? 1 : 0,
      'viewer' : viewer ? 1 : 0
    };
  }

  StudyItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        eWord = json['e_word'],
        kWord = json['k_word'],
        eSentence = json['e_sentence'],
        kSentence = json['k_sentence'],
        bookmark = json['bookmark'] == 1,
        viewer = json['viewer'] == 1;
}
