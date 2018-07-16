void settings() {
  size(600, 600);
}

float arrayX[] = new float[50];


void setup() {
  for (int i = 0; i<600; i+=12) {
    arrayX[i/12] = i;
  }
}

void draw() {
  for (int j = 0; j<50; j++) {
      line(arrayX[j], 0, arrayX[49-j], 600);
  }
}