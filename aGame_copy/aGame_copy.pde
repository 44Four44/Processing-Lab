void settings() {
  size(600, 600);
  //fullScreen();
}

int ballAmount = 5; 
int blockAmount = 1;

//bounds of velocity
float vxMin = 2;
float vxMax = 7;
float vyMin = 2;
float vyMax = 7;

ball[] balls = new ball[ballAmount];
block[] blocks = new block[blockAmount];

player me = new player();

boolean keys[] = new boolean[128];

void setup() {
  //ball generator
  for (int i = 0; i < ballAmount; i++) {
    balls[i] = new ball();
  }

  //block generator
  for (int i = 0; i < blockAmount; i++) {
    blocks[i] = new block();
  }
}

void draw () {
  colorMode(RGB, 255, 255, 255);
  background(150);

  //slow motion for checking physics (hit spacebar)
  if (slow) {
    frameRate(5);
  } else {
    frameRate(60);
  }

  //player
  me.move();
  me.display();

  //balls
  for (int i = 0; i < ballAmount; i++) {
    //  balls[i].ballCheck();
    //check for walls
    balls[i].wallCheck();
  }
  for (int i = 0; i < ballAmount; i++) {
    //update direction and speed if the ball hit another ball in balls.ballCheck()
    balls[i].update();
  }
  for (int i = 0; i < ballAmount; i++) {
    //moves balls
    balls[i].move();
    //draws balls
    balls[i].display();
  }

  //blocks
  for (int i = 0; i < blockAmount; i++) {
    blocks[i].display();
  }

  //angle function tester
  //line(300, 300, mouseX, mouseY);
  //player coordinates
  // println(me.x + " , " + me.y);
  //movement button tester
  rectMode(CENTER);
  noStroke();
  fill(100);
  if (me.up) {
    rect(width/2, 25, 50, 50);
  }
}

//for toggling slow mo on and off
boolean slow = false;
void keyPressed() {
  //slow mo to check for bugs/physics
  if (key == ' ') {
    slow = !slow;
  }
    println("w");
  //wasd player movement
  if (key == 'w') {
    me.up = true;

  }
  if (key == 'a') {
    me.left = true;
  }
  if (key == 's') {
    me.down = true;
  }
  if (key == 'd') {
    me.right = true;
  }
  keys[key] = true;
}

void keyReleased() {
  //stop wasd movement controls
  if (key == 'w') {
    me.up = false;
   // println("w release");
  }
  if (key == 'a') {
    me.left = false;
  }
  if (key == 's') {
    me.down = false;
  }
  if (key == 'd') {
    me.right = false;
  }
  keys[key] = false;
}

float angleOf(float initialX, float initialY, float terminalX, float terminalY) {
  PVector initialLine, terminalLine;
  initialLine = new PVector(300, 0);
  terminalLine = new PVector(terminalX - initialX, terminalY - initialY);
  if (initialY<terminalY) {
    return 2*PI - PVector.angleBetween(initialLine, terminalLine);
  } else {
    return PVector.angleBetween(initialLine, terminalLine);
  }
}

class ball {

  float diameter = random(50, 100);

  float x = random(diameter/2, width - diameter/2); 
  float y = random(diameter/2, height - diameter/2);

  float xVelocity = random(vxMin, vxMax);
  float yVelocity = random(vyMin, vyMax);

  float velocity = dist(0, 0, xVelocity, yVelocity);

  float mass = pow(diameter/2, 2) * PI;

  float angle = angleOf(0, 0, xVelocity, yVelocity);


  float xVelocity1 = xVelocity;
  float yVelocity1 = yVelocity;
  float velocity1 = velocity;

  float angle1 = angle;

  int fill = floor(random(0, 360));

  boolean inCollision = false;

  void move() {
    x += xVelocity/2;
    y += yVelocity/2;
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

  void ballCheck() {
    int n = ballCheckNum(this);

    if (n >= 0 && inCollision) {
      ball that = balls[n];

      float phi = angleOf(this.x, this.y, that.x, that.y);
      if (phi > PI) {
        phi-=PI;
      }
      float part = (this.velocity*cos(this.angle - phi)*(this.mass - that.mass) + 
        2*that.mass*that.velocity*cos(that.angle - phi))/(this.mass + that.mass);

      this.xVelocity1 = part*cos(phi)+this.velocity*sin(this.angle-phi)*sin(phi);
      this.yVelocity1 = part*sin(phi)+this.velocity*sin(this.angle-phi)*cos(phi);

      this.velocity1 = dist(0, 0, xVelocity1, yVelocity1);
      this.angle1 = angleOf(0, 0, xVelocity1, yVelocity1);
/*
      if (dist(this.x, this.y, that.x, that.y) <= 
        (this.diameter + that.diameter)/2) {
        float overlap = ((this.diameter + that.diameter)/2 - dist(this.x, this.y, that.x, that.y));
        float angle = angleOf(that.x, that.y, this.x, this.y);
        this.x = this.x - overlap*cos(angle);
        this.y = this.y - overlap*sin(angle);
      }
      */
    } else {
    }
  }

  void wallCheck() {
    if (x < diameter/2 || x > width - diameter/2) {
      xVelocity1 = -xVelocity;
    }

    if (y < diameter/2 || y > height - diameter/2) {
      yVelocity1 = -yVelocity;
    }
    angle1 = angleOf(0, 0, xVelocity1, yVelocity1);
  }

  void update() {
    xVelocity = xVelocity1;
    yVelocity = yVelocity1;
    velocity = velocity1;
    angle = angle1;
  }
}

int ballCheckNum(ball i) {
  int ball = -1;
  boolean collide = false;
  for (int j = 0; j < ballAmount; j++) {
    if (dist(i.x, i.y, balls[j].x, balls[j].y) <= 
      (i.diameter + balls[j].diameter)/2 && balls[j] != i) {
      ball = j;
      collide = true;
      balls[j].inCollision = true;
    }
  }
  if (collide) {
    i.inCollision = true;
  } else {
    i.inCollision = false;
  }

  return ball;
}

class block {
  float diameter = random(50, 100);

  float x = random(diameter/2, width - diameter/2); 
  float y = random(diameter/2, height - diameter/2);

  int fill = 0;
  void display() {
    colorMode(RGB, 255, 255, 255);
    strokeWeight(2);
    stroke(255);
    fill(fill);
    ellipse(x, y, diameter, diameter);
  }
}

int blockCheckNum(ball i){
  int block = -1;
  for(int j = 0; j < blockAmount; j++){
    if(dist(i.x, i.y, blocks[j].x, blocks[j].y) <= 
    (i.diameter + blocks[j].diameter)/2) {
      block = j;
    }
  }
  
  return block;
}

class player {

  float size = 20;

  float x = 300;
  float y = 300;

  float speed = 5;

  //for wasd moving
  boolean up = false;
  boolean left = false;
  boolean down = false;
  boolean right = false;

  void display() {
    rectMode(CENTER);
    fill(0);
    rect(x, y, size, size);
  }

  void move() {
    //w
    if (keys['w']) {
      y-=speed;
    }
    //a
    if (keys['a']) {
      x-=speed;
    }
    //s
    if (keys['s']) {
      y+=speed;
    }
    //d
    if (keys['d']) {
      x+=speed;
    }
  }
}