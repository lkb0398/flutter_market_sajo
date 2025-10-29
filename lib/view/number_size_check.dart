class NumberSizeCheck {
  int numberSizeCheck(int number) {
    if (number > 1000000000) {
      return -1;
    }
    return number;
  }
}
