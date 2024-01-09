import 'package:audioplayers/audioplayers.dart';

import 'package:flutter/material.dart';

import 'package:oficina_flutter_2023/app/models/models.dart';

import '../colors/colors.dart';

class PlayerTemplate extends StatefulWidget {
  const PlayerTemplate({super.key});

  @override
  State<PlayerTemplate> createState() => _PlayerTemplateState();
}

class _PlayerTemplateState extends State<PlayerTemplate> {
  @override
  void initState() {
    super.initState();

    _player.onDurationChanged.listen((duration) {
      setState(() {
        _duration = duration;
      });
    });
    _player.onPositionChanged.listen((position) {
      setState(() {
        _position = position;
      });
    });
  }

  bool _isplaying = false;

  bool _fetchingSound = false;

  final _player = AudioPlayer();

  int _playingIndex = 0;

  Duration _duration = const Duration(seconds: 0);

  Duration _position = const Duration(seconds: 0);

  final _pageController = PageController();

  final _musicList = [
    MusicModel(
      coverPhotoUrl:
          'https://i1.sndcdn.com/artworks-000495694974-9u4bgf-t500x500.jpg',
      artistName: 'Legião Urbana',
      musicName: 'Tempo Perdido',
      musicUrl: 'https://precobomapp.com.br/sounds/tempo_perdido.mp3',
    ),
    MusicModel(
      coverPhotoUrl:
          'https://static.quizur.com/i/b/59b767c03d01d1.00211919Charlie-Brown-Jr.png',
      artistName: 'Charlie Brow Jr',
      musicName: 'Como Tudo Deve Ser',
      musicUrl: 'https://precobomapp.com.br/sounds/como_tudo_deve_ser.mp3',
    ),
    MusicModel(
      coverPhotoUrl:
          'https://static.depositphotos.com/storage/image/e28d7f6292f80e937c331f6f5faa220a1df095c0.jpg',
      artistName: 'Billy Ellish',
      musicName: 'Bad Guy',
      musicUrl: 'https://precobomapp.com.br/sounds/happy.mp3',
    ),
    MusicModel(
      coverPhotoUrl:
          'https://imgv3.fotor.com/images/videoImage/ai-generated-beautiful-girl-like-a-beautiful-model-by-Fotor-ai-image-generator_2023-05-16-073426_dnrx.jpg',
      artistName: 'Frim Sabá',
      musicName: 'Papa pua',
      musicUrl: 'https://precobomapp.com.br/sounds/arte.mp3',
    ),
    MusicModel(
      coverPhotoUrl:
          'https://d5nunyagcicgy.cloudfront.net/external_assets/hero_examples/hair_beach_v391182663/original.jpeg',
      artistName: 'Solfi Grim',
      musicName: 'Happy',
      musicUrl: 'https://precobomapp.com.br/sounds/corrida.mp3',
    ),
    MusicModel(
      coverPhotoUrl:
          'https://imgv3.fotor.com/images/gallery/elegant-lady-with-flowers-in-headband-gray-hair-created-by-fotor-ai-image-generator.png',
      artistName: 'Maria Rita',
      musicName: 'Rosas',
      musicUrl: 'https://precobomapp.com.br/sounds/pimenta.mp3',
    ),
    MusicModel(
      coverPhotoUrl:
          'https://img.freepik.com/free-photo/close-up-portrait-attractive-young-woman-isolated_273609-35694.jpg',
      artistName: 'Lee Black',
      musicName: 'Force',
      musicUrl: 'https://precobomapp.com.br/sounds/pimenta.mp3',
    ),
  ];

  void _seekTo(double position) {
    setState(() {
      _player.seek(Duration(seconds: position.toInt()));
    });
  }

  void _setPosition(int position) {
    _position = Duration(seconds: position);
  }

  get _playSound async {
    _changeFetchingSound = true;

    await _player.play(
      UrlSource(_musicList[_playingIndex].musicUrl),
      mode: PlayerMode.mediaPlayer,
    );
    _isplaying = true;
    _changeFetchingSound = false;
  }

  get _definePreviewSound {
    _playingIndex--;

    if (_playingIndex >= 0) {
      setIndexPage = _playingIndex;
      _playSound;
    }
  }

  get _playNextSound {
    _playingIndex++;

    if (_playingIndex <= (_musicList.length - 1)) {
      setIndexPage = _playingIndex;
      _playSound;
    }
  }

  set _changeFetchingSound(bool value) {
    setState(() {
      _fetchingSound = value;
    });
  }

  get _stopSound async {
    await _player.stop();
    setState(() {
      _isplaying = false;
    });
  }

  set setIndexPage(int index) {
    setState(() {
      _pageController.animateToPage(
        index,
        duration: const Duration(seconds: 1),
        curve: Curves.linear,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _stopSound;
        return true;
      },
      child: Scaffold(
        backgroundColor: ProColors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 36, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: ProColors.blackMedium,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {
                          _stopSound;
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.keyboard_arrow_left_rounded,
                          color: ProColors.graySoft,
                        ),
                      ),
                    ),
                    Text(
                      'Now Playing by UNEX',
                      style: TextStyle(
                        color: ProColors.graySoft,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: Icon(
                        Icons.more_vert,
                        color: ProColors.graySoft,
                      ),
                    ),
                  ],
                ),
              ),
              // Image.asset(
              //   'assets/images/photo_woman.png',
              //   fit: BoxFit.cover,
              //   height: 300,
              // ),

              _musicListWidget,
              Column(
                children: [
                  SliderTheme(
                    data: SliderThemeData(
                        overlayShape: SliderComponentShape.noThumb),
                    child: Slider(
                      value: _position.inSeconds.toDouble(),
                      onChanged: (double value) {
                        _seekTo(value);
                      },
                      max: _duration.inSeconds.toDouble(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          _position.toString().split('.').first,
                          style: TextStyle(
                            color: ProColors.grayDark,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          _duration.toString().split('.').first,
                          style: TextStyle(
                            color: ProColors.grayDark,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30)
                    .copyWith(top: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: Icon(
                        Icons.repeat_rounded,
                        color: ProColors.graySoft,
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => _definePreviewSound,
                      icon: Icon(
                        Icons.skip_previous_rounded,
                        color: ProColors.graySoft,
                      ),
                    ),
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: ProColors.greenSoft,
                      ),
                      child: _fetchingSound
                          ? Center(
                              child: CircularProgressIndicator(
                                color: ProColors.graySoft,
                              ),
                            )
                          : IconButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                if (_isplaying) {
                                  _stopSound;
                                  _setPosition(0);
                                } else {
                                  _playSound;
                                }
                              },
                              icon: Icon(
                                _isplaying ? Icons.stop : Icons.play_arrow,
                                color: ProColors.graySoft,
                              ),
                            ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => _playNextSound,
                      icon: Icon(
                        Icons.skip_next_rounded,
                        color: ProColors.graySoft,
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: Icon(
                        Icons.shuffle_sharp,
                        color: ProColors.graySoft,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 32,
                height: 32,
                child: IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {},
                  icon: Icon(
                    Icons.keyboard_arrow_up_outlined,
                    color: ProColors.graySoft,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  'Lyrics',
                  style: TextStyle(
                    color: ProColors.graySoft,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget get _musicListWidget {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.5,
      child: PageView.builder(
        controller: _pageController,
        itemCount: _musicList.length,
        itemBuilder: (context, index) {
          final music = _musicList[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.35,
                width: MediaQuery.sizeOf(context).width * 0.9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    music.coverPhotoUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          music.musicName,
                          style: TextStyle(
                            color: ProColors.graySoft,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          music.artistName,
                          style: TextStyle(
                            color: ProColors.grayLight,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        onPressed: () {},
                        icon: Icon(
                          Icons.heart_broken,
                          color: ProColors.grayDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
        onPageChanged: (value) {
          _playingIndex = value;
        },
      ),
    );
  }
}
