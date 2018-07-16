void settings() {
  size (600, 600);
}

void setup() {
  background(255);
}

float degree = 0;
float cos = 0;
void draw() {
  translate(300, 300);
  colorMode(HSB, 359, 99, 99);

  noFill();
  strokeWeight(20);
  stroke(degree%360, 99, 99);
  rotate(5*(radians(degree))%360);

  arc(200*cos(cos), 200*cos(cos), 100, 100, (radians(degree)-1)%360, (radians(degree)+1)%360);

  degree++;
  cos+=0.1;
}