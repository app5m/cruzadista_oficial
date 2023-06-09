class WordPosition {
  int startRow;
  int startCol;
  int endRow;
  int endCol;
  bool isHorizontal;

  WordPosition(this.startRow, this.startCol, this.endRow, this.endCol,
      this.isHorizontal);

  bool containsCell(int row, int col) {
    if (isHorizontal) {
      return row == startRow && col >= startCol && col <= endCol;
    } else {
      return col == startCol && row >= startRow && row <= endRow;
    }
  }
  @override
  String toString() {
    return 'Start: ($startRow, $startCol), End: ($endRow, $endCol), Horizontal: $isHorizontal';
  }
}
