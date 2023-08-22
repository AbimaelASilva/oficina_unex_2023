import 'package:audioplayers/audioplayers.dart';

class SoundController {
  final _sound = AudioPlayer();

  String _selectedSound = 'https://precobomapp.com.br/sounds/happy.mp3';

  get playSound async {
    await _sound.play(
      UrlSource(_selectedSound),
      mode: PlayerMode.mediaPlayer,
    );
  }

  get stopSound {
    _sound.stop();
  }

  get acttiveLoopSound {
    _sound.onPlayerComplete.listen((event) {});
  }
}
