import 'package:assets_audio_player/assets_audio_player.dart';

class MediaPlayer {
  static final assetsAudioPlayer = AssetsAudioPlayer();

  static final _assets = <String>[
    "assets/audios/button_tap.ogg", // -> 0
    "assets/audios/np_error.wav", // -> 1
    "assets/audios/np_success.wav", // -> 2
    "assets/audios/reset_board.wav", // -> 3
    "assets/audios/full_screen.wav", // -> 4
    "assets/audios/game_success.wav", // -> 5
  ];

  static loadPlayAudio(int index) {
    //TODO: Enable once sounds are complete
      assetsAudioPlayer.open(_assets[index]);
  }
}
