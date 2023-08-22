class SoundModel {
  String nameSound;
  String url;
  SoundModel({
    required this.nameSound,
    required this.url,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'nameSound': nameSound});
    result.addAll({'url': url});

    return result;
  }

  factory SoundModel.fromMap(Map<String, dynamic> map) {
    return SoundModel(
      nameSound: map['nameSound'] ?? '',
      url: map['url'] ?? '',
    );
  }

  factory SoundModel.empty() {
    return SoundModel(
      nameSound: '',
      url: '',
    );
  }
}
