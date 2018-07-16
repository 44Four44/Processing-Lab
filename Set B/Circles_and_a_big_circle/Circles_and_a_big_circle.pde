void settings() {
  size(320, 600);
}

void setup() {
}
int i;
int j;
void draw () {
  for (i = 1; i<16; i++) {
    for (j = 1; j<16; j++) {
      ellipse(16*i+10, 16*j+10, 20, 20);
    }
  }
}