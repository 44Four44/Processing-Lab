//Creates Asteroids
class Asteroid {
  float AsX = random(width-100);
  float AsY = random(height-height/4*1.75);
    
  void showAs() {
    noStroke();
    fill(39, 100, 40);
    ellipse(AsX, AsY, 100, 100);
  }
}