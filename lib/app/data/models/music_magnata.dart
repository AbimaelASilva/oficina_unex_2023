class MusicMagnataModel {
  final int idMusic;
  final String dsTitle;
  final String dsDescription;
  final String dsUrl;
  final Lyrics lyrics;
  final Album album;
  MusicMagnataModel({
    required this.idMusic,
    required this.dsTitle,
    required this.dsDescription,
    required this.dsUrl,
    required this.lyrics,
    required this.album,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id_Music': idMusic});
    result.addAll({'ds_Title': dsTitle});
    result.addAll({'ds_Description': dsDescription});
    result.addAll({'ds_Url': dsUrl});
    result.addAll({'lyrics': lyrics.toMap()});
    result.addAll({'album': album.toMap()});

    return result;
  }

  factory MusicMagnataModel.fromMap(Map<String, dynamic> map) {
    return MusicMagnataModel(
      idMusic: map['id_Music']?.toInt() ?? 0,
      dsTitle: map['ds_Title'] ?? '',
      dsDescription: map['ds_Description'] ?? '',
      dsUrl: map['ds_Url'] ?? '',
      lyrics: Lyrics.fromMap(map['lyrics']),
      album: Album.fromMap(map['album']),
    );
  }
  factory MusicMagnataModel.empty() {
    return MusicMagnataModel(
      idMusic: 0,
      dsTitle: '',
      dsDescription: '',
      dsUrl: '',
      lyrics: Lyrics.empty(),
      album: Album.empty(),
    );
  }
}

class Lyrics {
  final int idMusicLyrics;
  final String dsLyrics;
  Lyrics({
    required this.idMusicLyrics,
    required this.dsLyrics,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id_MusicLyrics': idMusicLyrics});
    result.addAll({'ds_Lyrics': dsLyrics});

    return result;
  }

  factory Lyrics.fromMap(Map<String, dynamic> map) {
    return Lyrics(
      idMusicLyrics: map['id_MusicLyrics']?.toInt() ?? 0,
      dsLyrics: map['ds_Lyrics'] ?? '',
    );
  }

  factory Lyrics.empty() {
    return Lyrics(
      idMusicLyrics: 0,
      dsLyrics: '',
    );
  }
}

class Album {
  final int idAlbum;
  final String dsAlbum;

  final int dtRelease;
  final String dsImage;
  final Artist artist;
  Album({
    required this.idAlbum,
    required this.dsAlbum,
    required this.dtRelease,
    required this.dsImage,
    required this.artist,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id_Album': idAlbum});
    result.addAll({'ds_Album': dsAlbum});
    result.addAll({'dt_Release': dtRelease});
    result.addAll({'ds_Image': dsImage});
    result.addAll({'artist': artist.toMap()});

    return result;
  }

  factory Album.fromMap(Map<String, dynamic> map) {
    return Album(
      idAlbum: map['id_Album']?.toInt() ?? 0,
      dsAlbum: map['ds_Album'] ?? '',
      dtRelease: map['dt_Release']?.toInt() ?? 0,
      dsImage: map['ds_Image'] ?? '',
      artist: Artist.fromMap(map['artist']),
    );
  }
  factory Album.empty() {
    return Album(
      idAlbum: 0,
      dsAlbum: '',
      dtRelease: 0,
      dsImage: '',
      artist: Artist.empty(),
    );
  }
}

class InfoAlbum {}

class Artist {
  final int idArtist;
  final String dsArtist;

  Artist({
    required this.idArtist,
    required this.dsArtist,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id_Artist': idArtist});
    result.addAll({'ds_Artist': dsArtist});

    return result;
  }

  factory Artist.fromMap(Map<String, dynamic> map) {
    return Artist(
      idArtist: map['id_Artist']?.toInt() ?? 0,
      dsArtist: map['ds_Artist'] ?? '',
    );
  }
  factory Artist.empty() {
    return Artist(
      idArtist: 0,
      dsArtist: '',
    );
  }
}
