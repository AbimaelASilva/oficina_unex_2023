class MusicModel {
  String coverPhotoUrl;
  String artistName;
  String musicUrl;
  String musicName;
  MusicModel({
    required this.coverPhotoUrl,
    required this.artistName,
    required this.musicName,
    required this.musicUrl,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'nameSound': musicName});
    result.addAll({'url': musicUrl});

    return result;
  }

  factory MusicModel.fromMap(Map<String, dynamic> map) {
    return MusicModel(
      coverPhotoUrl: map['coverPhotoUrl'] ?? '',
      artistName: map['artistName'] ?? '',
      musicName: map['musicName'] ?? '',
      musicUrl: map['musicUrl'] ?? '',
    );
  }

  factory MusicModel.empty() {
    return MusicModel(
      coverPhotoUrl: '',
      artistName: '',
      musicName: '',
      musicUrl: '',
    );
  }
}
