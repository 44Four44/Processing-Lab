class ball {
  //initial diameter for tracking score when ball is destroyed
  float initialDiameter = random(50, 100);
  float diameter = initialDiameter;

  float x = random(diameter/2, width - diameter/2); 
  float y = random(diameter/2, height - diameter/2);

  //x and y component parts of the ball's velocity vector
  float xVelocity = random(vxMin, vxMax);
  float yVelocity = random(vyMin, vyMax);

  float velocity = dist(0, 0, xVelocity, yVelocity);

  float mass = pow(diameter/2, 2) * PI;

  float angle = angleOf(0, 0, xVelocity, yVelocity);

  //amount of damage the ball does to the player
  float damage = 200;

  int fill = floor(random(0, 360));

  boolean inCollision = false;

  void move() {
    x += xVelocity;
    y += yVelocity;
  }

  void display() {
    colorMode(HSB, 359, 99, 99);
    strokeWeight(2);
    stroke(0);
    fill(fill, 99, 99);
    ellipse(x, y, diameter, diameter);
    /*   
     fill(0);
     textSize(20);
     text(x + "\n" + y + "\n" + diameter + "\n" + xVelocity + "\n" + yVelocity + "\n" + velocity + "\n" + 
     angle + "\n" + mass + "\n" + xVelocity1 + "\n" + yVelocity1 + "\n" + velocity1 + "\n" + angle1 , x, y);
     */
  }
  /*
  void blockCheck() {
   int n = blockCheckNum(this);
   if (n >= 0) {
   float collisionAngle = angleOf(x, y, blocks[n].x, blocks[n].y);
   if (angle < collisionAngle) {
   angle = (collisionAngle - PI/2 + 2*PI) % 2*PI;
   } else {
   angle = (collisionAngle + PI/2 + 2*PI) % 2*PI;
   }
   xVelocity = velocity * cos(angle);
   yVelocity = velocity * sin(angle);
   }
   }
   */
  /*
  void ballCheck() {
   int n = ballCheckNum(this);
   
   if (n >= 0 && inCollision) {
   ball that = balls.get(n);
   
   float phi = angleOf(x, y, that.x, that.y);
   if (phi > PI) {
   phi-=PI;
   }
   float part = (velocity*cos(angle - phi)*(mass - that.mass) + 
   2*that.mass*that.velocity*cos(that.angle - phi))/(mass + that.mass);
   
   xVelocity1 = part*cos(phi)+velocity*sin(angle-phi)*sin(phi);
   yVelocity1 = part*sin(phi)+velocity*sin(angle-phi)*cos(phi);
   
   velocity1 = dist(0, 0, xVelocity1, yVelocity1);
   angle1 = angleOf(0, 0, xVelocity1, yVelocity1);
   
   if (dist(x, y, that.x, that.y) <= 
   (diameter + that.diameter)/2) {
   float overlap = ((diameter + that.diameter)/2 - dist(x, y, that.x, that.y));
   float angle = angleOf(that.x, that.y, x, y);
   x = x - overlap*cos(angle);
   y = y - overlap*sin(angle);
   }
   } else {
   }
   }
   */
  void wallCheck() {
    if (x < diameter/2 || x > width - diameter/2) {
      xVelocity = -xVelocity;
    }

    if (y < diameter/2 || y > height - diameter/2) {
      yVelocity = -yVelocity;
    }
    angle = angleOf(0, 0, xVelocity, yVelocity);
  }
}
