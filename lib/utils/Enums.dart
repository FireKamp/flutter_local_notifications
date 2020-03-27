// Enums
enum PlayMode { PENCIL, PLAY }
enum LevelTYPE { EASY, MEDIUM, HARD, EXPERT }

class EnumValues {
  static int getEnum(PlayMode mode) {
    return mode.index;
  }
}
