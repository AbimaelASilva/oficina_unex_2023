import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

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

  ///https://www.free-stock-music.com/
  final _listSounds = [
    'https://precobomapp.com.br/sounds/happy.mp3',
    'https://precobomapp.com.br/sounds/arte.mp3',
    'https://precobomapp.com.br/sounds/corrida.mp3',
    'https://precobomapp.com.br/sounds/agencia.mp3',
    'https://precobomapp.com.br/sounds/pimenta.mp3',
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
    //  _verifyDuration;
    await _player.play(
      UrlSource(_listSounds[_playingIndex]),
      mode: PlayerMode.mediaPlayer,
    );
    _changeFetchingSound = false;
    _changeSoundStatus;
  }

  get _definePreviewSound {
    _playingIndex--;

    if (_playingIndex >= 0) {
      _playSound;
    }
  }

  get _playNextSound {
    _playingIndex++;

    if (_playingIndex <= (_listSounds.length - 1)) {
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
    _changeSoundStatus;
  }

  get acttiveLoopSound {
    _player.onPlayerComplete.listen((event) {});
  }

  get _changeSoundStatus {
    setState(() {
      _isplaying = !_isplaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.keyboard_arrow_left_rounded,
                        color: ProColors.graySoft,
                      ),
                    ),
                  ),
                  Text(
                    'Now Playing',
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
            Image.asset(
              'assets/images/photo_woman.png',
              fit: BoxFit.cover,
              height: 300,
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
                        'Bad Guy',
                        style: TextStyle(
                          color: ProColors.graySoft,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        'Billy Ellish',
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
            Column(
              children: [
                SliderTheme(
                  data: const SliderThemeData(),
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 30).copyWith(top: 16),
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
                        ? CircularProgressIndicator(
                            color: ProColors.graySoft,
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
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
