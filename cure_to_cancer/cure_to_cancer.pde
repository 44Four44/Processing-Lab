void settings() {
  size(600, 600);
}
float h = 0;
float x = 500;
float y = 500;
void setup() {
  frameRate(30);
}
boolean timer = true;
void draw() {
  colorMode(HSB, 255, 99, 99);
  background(random(0, 255), 99, 99);
  textAlign(CENTER);
  textSize(100);
  fill(0);
  text("CANCER", 300, 300);
  if (timer) {
    strokeWeight(50);
    fill(255, 0, 0);
    stroke(255, 0, 0);
    ellipse(300, 300, x%500, y%500);

    strokeWeight(30);
    stroke(255, 0, 0);
    line(x%50, -y%500,-y%500, -x%50);
  }
  textAlign(CENTER);
  textSize(random(50, 300));
  fill(random(0, 255));
  text("CANCER", 300, 300);
  timer = !timer;
  h+=10;
  y-=30;
  x+=50;
  
}