class hpPack {
  float size = 20;

  float x = random(size, width - size);
  float y = random(size, height - size);

  //amount the pack heals for
  float strength = 150;

  void display () {
    rectMode(CENTER);
    stroke(#FFFFFF);
    fill (#FF0000);
    rect(x, y, size, size);
  }
}
