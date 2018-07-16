class block {
  float diameter = random(50, 100);

  float x = random(diameter/2, width - diameter/2); 
  float y = random(diameter/2, height - diameter/2);

  int fill = 0;
  void display() {
    colorMode(RGB, 255, 255, 255);
    strokeWeight(2);
    stroke(255);
    fill(fill);
    ellipse(x, y, diameter, diameter);
  }
}
