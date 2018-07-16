float angleOf(float initialX, float initialY, float terminalX, float terminalY) {
  PVector initialLine, terminalLine;
  initialLine = new PVector(300, 0);
  terminalLine = new PVector(terminalX - initialX, terminalY - initialY);
  if (initialY<terminalY) {
    return 2*PI - PVector.angleBetween(initialLine, terminalLine);
  } else {
    return PVector.angleBetween(initialLine, terminalLine);
  }
}