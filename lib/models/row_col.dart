class RowCol {
  int r;
  int c;

  RowCol(int r, int c) {
    this.r = r;
    this.c = c;
  }

  @override
  String toString() => "r:" + r.toString() + ",c:" + c.toString();

  @override
  // TODO: implement hashCode
  int get hashCode => 10 * r + c;

  @override
  bool operator ==(other) {
    // TODO: implement ==
    return (this.r == other.r) && (this.c == other.c);
  }
}
