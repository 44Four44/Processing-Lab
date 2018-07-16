void settings() {
  fullScreen();
}

PImage img;
PImage idubbbz;
void setup() {
  img = loadImage("rice.png");
  idubbbz = loadImage("idubbbz.png");
}
void draw() {
  imageMode(CENTER);
  image(idubbbz, mouseX, mouseY);
  image(img, width - mouseX, height - mouseY);
}