import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oficina_flutter_2023/app/config_app.dart';
import '../data/models/models.dart';
import '../data/provider/music/music.dart';

class AudioController extends GetxController {
  final _sound = AudioPlayer();

  // String _selectedSound = 'https://precobomapp.com.br/sounds/happy.mp3';

  final _musicList = <MusicMagnataModel>[].obs;

  final _musicProviders = MusicProviders();

  List<MusicMagnataModel> get musicList => _musicList;

  // get playSound async {
  //   await _sound.play(
  //     UrlSource(_selectedSound),
  //     mode: PlayerMode.mediaPlayer,
  //   );
  // }

  // get stopSound {
  //   _sound.stop();
  // }

  get acttiveLoopSound {
    _sound.onPlayerComplete.listen((event) {});
  }

  bool isplaying = false;

  bool fetchingSound = false;

  final player = AudioPlayer();

  int playingIndex = 0;

  final _duration = const Duration(seconds: 0).obs;

  final _position = const Duration(seconds: 0).obs;

  Duration get position => _position.value;

  Duration get duration => _duration.value;

  String selectedMusic = '';

  final pageController = PageController();

  // final _musicList = [
  //   MusicModel(
  //     coverPhotoUrl:
  //         'https://i1.sndcdn.com/artworks-000495694974-9u4bgf-t500x500.jpg',
  //     artistName: 'Legião Urbana',
  //     musicName: 'Tempo Perdido',
  //     musicUrl: 'https://precobomapp.com.br/sounds/tempo_perdido.mp3',
  //   ),
  //   MusicModel(
  //     coverPhotoUrl:
  //         'https://static.quizur.com/i/b/59b767c03d01d1.00211919Charlie-Brown-Jr.png',
  //     artistName: 'Charlie Brow Jr',
  //     musicName: 'Como Tudo Deve Ser',
  //     musicUrl: 'https://precobomapp.com.br/sounds/como_tudo_deve_ser.mp3',
  //   ),
  //   MusicModel(
  //     coverPhotoUrl:
  //         'https://static.depositphotos.com/storage/image/e28d7f6292f80e937c331f6f5faa220a1df095c0.jpg',
  //     artistName: 'Billy Ellish',
  //     musicName: 'Bad Guy',
  //     musicUrl: 'https://precobomapp.com.br/sounds/happy.mp3',
  //   ),
  //   MusicModel(
  //     coverPhotoUrl:
  //         'https://imgv3.fotor.com/images/videoImage/ai-generated-beautiful-girl-like-a-beautiful-model-by-Fotor-ai-image-generator_2023-05-16-073426_dnrx.jpg',
  //     artistName: 'Frim Sabá',
  //     musicName: 'Papa pua',
  //     musicUrl: 'https://precobomapp.com.br/sounds/arte.mp3',
  //   ),
  //   MusicModel(
  //     coverPhotoUrl:
  //         'https://d5nunyagcicgy.cloudfront.net/external_assets/hero_examples/hair_beach_v391182663/original.jpeg',
  //     artistName: 'Solfi Grim',
  //     musicName: 'Happy',
  //     musicUrl: 'https://precobomapp.com.br/sounds/corrida.mp3',
  //   ),
  //   MusicModel(
  //     coverPhotoUrl:
  //         'https://imgv3.fotor.com/images/gallery/elegant-lady-with-flowers-in-headband-gray-hair-created-by-fotor-ai-image-generator.png',
  //     artistName: 'Maria Rita',
  //     musicName: 'Rosas',
  //     musicUrl: 'https://precobomapp.com.br/sounds/pimenta.mp3',
  //   ),
  //   MusicModel(
  //     coverPhotoUrl:
  //         'https://img.freepik.com/free-photo/close-up-portrait-attractive-young-woman-isolated_273609-35694.jpg',
  //     artistName: 'Lee Black',
  //     musicName: 'Force',
  //     musicUrl: 'https://precobomapp.com.br/sounds/pimenta.mp3',
  //   ),
  // ];

  void seekTo(double position) {
    player.seek(Duration(seconds: position.toInt()));
  }

  void setPosition(int positionParam) {
    _position.value = Duration(seconds: positionParam);
    update();
  }

  get playSound async {
    changeFetchingSound = true;

    final sufixUrl = musicList[playingIndex].dsUrl;

    final musicUrl = ConfigApp.musicUrl + sufixUrl;
    print(musicUrl);

    await player.play(
      // UrlSource(_musicList[_playingIndex].musicUrl),
      UrlSource(musicUrl),
      mode: PlayerMode.mediaPlayer,
    );
    isplaying = true;
    changeFetchingSound = false;
  }

  get definePreviewSound {
    playingIndex--;

    if (playingIndex >= 0) {
      setIndexPage = playingIndex;
      playSound;
    }
  }

  get playNextSound {
    playingIndex++;

    if (playingIndex <= (musicList.length - 1)) {
      setIndexPage = playingIndex;
      playSound;
    }
  }

  set changeFetchingSound(bool value) {
    fetchingSound = value;
  }

  get stopSound async {
    await player.stop();

    isplaying = false;
  }

  set setIndexPage(int index) {
    pageController.animateToPage(
      index,
      duration: const Duration(seconds: 1),
      curve: Curves.linear,
    );
  }

  void _getMusicList() async {
    try {
      final response = await _musicProviders.getMusicList();
      final random = Random();
      response.shuffle(random);
      _musicList.value = response.toList();
      update();
    } catch (e) {}
  }

  @override
  void onInit() {
    super.onInit();
    player.onDurationChanged.listen((duration) {
      _duration.value = duration;
    });
    player.onPositionChanged.listen((position) {
      _position.value = position;
    });

    pageController.addListener(() {});
    _getMusicList();
  }
}
