class QuranTranslation {
  String aya;
  String created_at;
  String id;
  String quran_text_id;
  String sura_id;
  String text;
  String translation_id;
  String updated_at;

  QuranTranslation(this.aya, this.created_at, this.id, this.quran_text_id,
      this.sura_id, this.text, this.updated_at, this.translation_id);

  factory QuranTranslation.fromJson(Map<String, dynamic> json) {
    return QuranTranslation(
      json['aya'] ?? '',
      json['created_at'] ?? '',
      json['id'] ?? '',
      json['quran_text_id'] ?? '',
      json['sura_id'] ?? '',
      json['text'] ?? '',
      json['translation_id'] ?? '',
      json['updated_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aya'] = this.aya;
    data['created_at'] = this.created_at;
    data['id'] = this.id;
    data['quran_text_id'] = this.quran_text_id;
    data['sura_id'] = this.sura_id;
    data['text'] = this.text;
    data['translation_id'] = this.translation_id;
    data['updated_at'] = this.updated_at;
    return data;
  }

  // @override
  // String toString() {
  //   return '{aya: $aya, created_at: $created_at, id: $id, quran_text_id: $quran_text_id, sura_id: $sura_id, text: $text, translation_id: $translation_id , updated_at: $updated_at}';
  // }
}
