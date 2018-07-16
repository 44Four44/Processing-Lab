class bullet {
  float size = 10;

  float x = me.x;
  float y = me.y;

  float velocity = 5;
  ;

  float angle = angleOf(me.x, me.y, mouseX, mouseY);

  float xVelocity = velocity*cos(angle);
  float yVelocity = -velocity*sin(angle);

  //how much it can break;
  float damage = 5;

  //if bullet is being "shot" currently / on the screen
  boolean active = false;  

  void display() {
    fill(0);
    noStroke();
    ellipse(x, y, size, size);
  }

  void move() {
    x+=xVelocity;
    y+=yVelocity;
  }

  //deactivates bullets when they go offscreen
  void wallCheck () {
    //normal no bouncing

    if (x < size/2 || x > width - size/2 || y < size/2 || y > height - size/2) {
      bullets.remove(this);
    }

    /*
    //ricochet testing
     
     if (x < size/2 || x > width - size/2) {
     xVelocity = -xVelocity;
     }
     
     if (y < size/2 || y > height - size/2) {
     yVelocity = -yVelocity;
     }
     */
  }

  //checks if the bullet hit a ball
  void ballHitCheck() {
    for (int j = 0; j < balls.size(); j++) {
      ball part = balls.get(j);
      if (dist(x, y, part.x, part.y) <= (size + part.diameter)/2) {
        if (part.diameter >= 20 + damage) {
          part.diameter -= damage;
        } else {
          balls.remove(part);
          balls.add(new ball());
        }
        bullets.remove(this);
      }
    }
  }
}
