void settings() {
  size(320, 600);
}

void setup() {
}
float hsb = 0;
void draw() {


  for (int i = 0; i < 319; i += 20) {

    pushMatrix();
    translate(0, i);
    for (int x = 10; x < 321; x += 20) {
      colorMode(HSB, 320, 99, 99);
      stroke(0);
      fill(x, 99, 99);
      ellipse(x, 10, 20, 20);
    }
    popMatrix();
  }

  colorMode(HSB, 210, 99, 99);
  for (int y = 210; y>1; y-=1) {
    noStroke();
    fill(y, 99, 99);
    ellipse(160, 450, y, y);
  }
}