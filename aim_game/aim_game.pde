void settings () {
  size(600, 600);
}

void setup() {
}

int x = int(random(10, width - 10));
int y = int(random(10, height - 10));
void draw() {
  background(255);

  noStroke();
  fill(0);
  ellipse(x, y, 2, 2);
}