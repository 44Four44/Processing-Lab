void settings() {
  size(960, 600);
}

PImage jake;
int pxlSize = 1;
int increment = 1;
void setup() {
  frameRate(60);
  jake = loadImage("jake.png");
}

void draw() {
  image(jake, 480, 0);

  for (int i = 0; i<480; i+=pxlSize) {
    for (int j = 0; j<600; j+=pxlSize) {
      noStroke();
      fill(get(i+480, j));
      rect(i, j, pxlSize, pxlSize);
    }
  }
  //zoom in part
  
  
  if (pxlSize == 100) {
    increment = -1;
  } else if (pxlSize == 1) {
    increment = 1;
  }
  pxlSize+=increment;
  
}