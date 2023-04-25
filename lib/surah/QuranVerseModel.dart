class QuranVerse {
  final String? suraId;
  final String? aya;
  final String? text;

  QuranVerse({
    this.suraId,
    this.aya,
    this.text,
  });

  factory QuranVerse.fromJson(Map<String, dynamic> json) {
    return QuranVerse(
      suraId: json['sura_id'] as String,
      aya: json['aya'] as String,
      text: json['text'] as String,
    );
  }

  get ayahNumber => null;
}
