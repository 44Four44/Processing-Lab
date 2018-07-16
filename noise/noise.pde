void settings() {
  size(wideness, tallness);
}

void setup() {
}

int wideness = 600;
int tallness = 600;
int Ydensity = 30;
//  /speed

float noise = 0;

float x = 0;

float firstY = 0;
float secondY = -1;

float roughness = 0.01;
float thickness = 40;

float points[] = new float[Ydensity];

int hp = 3;

color shipColor = #00FF0A;
void draw() {
  background(0);

  moveDown();
  for (int j = 0; j < Ydensity - 1; j++) {
    strokeWeight(thickness);
    stroke(255);
    line(points[j], tallness/Ydensity*j, points[j + 1], tallness/Ydensity*j);
  }

  checkLife();

  fill(shipColor);
  noStroke();
  ellipse(mouseX, mouseY, 20, 20);
}

void moveDown() {
  //shifts points down
  for (int i = Ydensity - 1; i > 0; i--) {
    points[i] = points[i-1];
  }

  //new point
  noise += roughness;
  points[0] = noise(noise) * wideness;
}

void checkLife() {
  color white = #FFFFFF;
  if (get(mouseX, mouseY) == white) {
    shipColor = #00FF0A;
  } else {
    shipColor = #FF0000;
  }
}