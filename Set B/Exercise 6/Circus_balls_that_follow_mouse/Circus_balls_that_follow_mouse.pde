void settings() {
  size(320, 600);
}

void setup() {
}
int i = 5;
int j = 5;

void draw() {
  background(255);
  while (i<mouseX) {
    while (j<mouseY) {
      colorMode(HSB, 255, 99, 99);
      noStroke();
      fill(((i-5)*(j-5))%255, 99, 99);
      ellipse(i+5, j+5, 10, 10);
      j+=10;
    }
    i+=10;
    j=5;
  }
  i=5;
  j=5;
}