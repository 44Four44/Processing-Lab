void settings() {
  size(320, 600);
}

void setup() {
  background(255);
  frameRate(2);
}
int i;
int j;
int r;
int h = 0;
void draw () {
  colorMode(HSB, 255, 99, 99);
  if (h<255) {
    for (i = 0; i<320; i+=20) {
      for (j = 0; j<320; j+=20) {
        fill(h, 99, 99);
        ellipse(j+10, i+10, 20, 20);
        h++;
        println(h);
      }
    }
  }
    for (r = 215; r>0; r--) {
      noStroke();
      fill(r, 99, 99);
      ellipse(160, 450, r, r);

  }
}