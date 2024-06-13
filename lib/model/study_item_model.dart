class StudyItem {
  final int id;
  final String eWord;
  final String kWord;
  final String eSentence;
  final String kSentence;

  StudyItem({
    required this.id,
    required this.eWord,
    required this.kWord,
    required this.eSentence,
    required this.kSentence,
  });

  StudyItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        eWord = json['e_word'],
        kWord = json['k_word'],
        eSentence = json['e_sentence'],
        kSentence = json['k_sentence'];
}
