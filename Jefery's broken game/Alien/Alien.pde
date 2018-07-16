//Creates Aliens
class Alien {
  float AlXSpeed = random(-1, 1);
  float AlYSpeed = random(1, 5);
  float AlX = int(random(width-50));
  float AlY = random(-200, -10);

  void move() {
    AlY = AlY + AlYSpeed;
    AlX = AlX + AlXSpeed;
    if (AlY>height-height/4*1.75) {
      AlY = random(-200, -100);
      AlX = int(random(width-50));
    } else if (AlX>width) {
      AlY = random(-200, -100);
      AlX = int(random(width-50));
    } else if (AlX<0) {
      AlY = random(-200, -100);
      AlX = int(random(width-50));
    }
  }
  void remove() {
    AlY = random(-200, -100);
    AlX = int(random(width-50));
  }
  void showAl() {
    fill(77, 100, 50);
    noStroke();
    rect(AlX, AlY, 80, 80);
  }
}