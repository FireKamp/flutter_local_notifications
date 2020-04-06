import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:sudoku_brain/utils/LocalDB.dart';
import 'package:vibration/vibration.dart';

class MediaPlayer {
  static final assetsAudioPlayer = AssetsAudioPlayer();
  static final assetsAudioPlayerBG = AssetsAudioPlayer();

  static final _assets = <String>[
    "assets/audios/button_tap.ogg", // -> 0
    "assets/audios/panel_click.mp3", // -> 1
    "assets/audios/gameplay_interactions.mp3", // -> 2
    "assets/audios/board_bg.mp3", // -> 3
  ];

  static loadPlayAudio(int index) {
    if (LocalDB.isHapticOn) Vibration.vibrate(duration: 30);

    if (LocalDB.isSoundOn) assetsAudioPlayer.open(_assets[index]);
  }

  static playBG(int index) {
    if (LocalDB.isSoundOn) {
      assetsAudioPlayerBG.open(_assets[index]);
      assetsAudioPlayerBG.loop = true;
    }
  }
}
