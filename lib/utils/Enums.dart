// Enums
enum PlayMode { PENCIL, PLAY }
enum LevelTYPE { EASY, MEDIUM, HARD, EXPERT }
enum Sounds { BUTTON_TAP, SUCCESS, FAILURE, BG }

class SoundValues {
  static int getEnum(Sounds sound) {
    return sound.index;
  }
}

class EnumValues {
  static int getEnum(PlayMode mode) {
    return mode.index;
  }
}
