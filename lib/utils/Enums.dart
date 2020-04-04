// Enums
enum PlayMode { PENCIL, PLAY }
enum LevelTYPE { EASY, MEDIUM, HARD, EXPERT }

enum RepSelection {
  DUMMY,
  SUNDAY,
  MONDAY,
  TUESDAY,
  WEDNESDAY,
  THURSDAY,
  FRIDAY,
  SATURDAY,
  EVERYDAY
}

class SelValues {
  static int getEnum(RepSelection rep) {
    return rep.index;
  }
}class EnumValues {
  static int getEnum(PlayMode mode) {
    return mode.index;
  }
}
