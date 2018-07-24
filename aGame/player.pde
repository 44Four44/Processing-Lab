class player {

  float size = 20;

  float x = 300;
  float y = 300;

  float speed = 2;

  color fill = #000000;

  //for wasd moving
  boolean up = false;
  boolean left = false;
  boolean down = false;
  boolean right = false;

  //true when shooting
  boolean shooting = false;

  //shooting speed/ 1 bullet per 'rof' frames
  float rof = 20;

  //health
  float maxHealth = 1000;
  float health = maxHealth;
  float healthDecay = 0.5;

  //short immunity after taking damage
  boolean immune = false;
  float immuneMax = 600;
  float immuneTime = immuneMax;

  //score of the player
  float score = 0;
  float scoreConstant = 1;
  
  //multiplier for not getting hit by balls
  float multiplier = 1;
  void display() {
    rectMode(CENTER);
    //flashes if player is immune
    if (immune) {
      if (frameCount % 100 < 50) {
        fill(fill, 100);
      } else {
        fill(fill);
      }
    } else {
      fill(fill);
    }
    noStroke();
    rect(x, y, size, size);
  }

  //checks if the player collides with a ball
  void ballCheck() {
    for (int j = 0; j < balls.size(); j++) {
      ball part = balls.get(j);
      if (dist(x, y, part.x, part.y) <= (size + part.diameter)/2 && !immune) {
        if (health  >= part.damage) {
          health -= part.damage;
        } else {
          health = 0;
        }
        immune = true;
      }
    }
  }

  //checks if the player goes over a health pack
  void hpPackCheck () {
    for (int h = 0; h < hpPacks.size(); h++) {
      hpPack part = hpPacks.get(h);
      if (x >= part.x - (part.size + size)/2 && x <= part.x + (part.size + size)/2
        && y >= part.y - (part.size + size)/2 && y <= part.y + (part.size + size)/2) {
        if (health > maxHealth - part.strength) {
          health = maxHealth;
        } else {
          health += part.strength;
        }
        hpPacks.remove(part);
        hpPacks.add(new hpPack());
      }
    }
  }

  //counts down immunity time
  void immunityTime() {
    if (immune && immuneTime > 0) {
      immuneTime--;
    } else {
      immune = false;
      immuneTime = immuneMax;
    }
  }
  void move() {
    //w
    if (up) {
      //in the case the player is close to the wall
      if (y - speed < size/2) {
        y = size/2;
      } else {
        y-=speed;
      }
    }
    //a
    if (left) {
      //in the case the player is close to the wall
      if (x - speed < size/2) {
        x = size/2;
      } else {
        x-=speed;
      }
    }
    //s
    if (down) {
      //in the case the player is close to the wall
      if (y + speed > height - size/2) {
        y = height - size/2;
      } else {
        y+=speed;
      }
    }
    //d
    if (right) {
      //in the case the player is close to the wall
      if (x + speed > width - size/2) {
        x = width - size/2;
      } else {
        x+=speed;
      }
    }
  }
}
