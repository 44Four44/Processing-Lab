void settings() {
  size(600, 600);
  //fullScreen();
}

int ballAmount = 5;
int blockAmount = 1;

//amount of healthpacks
int hpPackAmount = 3;

//bounds of velocity
float vxMin = 0.5;
float vxMax = 2;
float vyMin = 0.5;
float vyMax = 2;

ArrayList<ball> balls = new ArrayList<ball>();
block[] blocks = new block[blockAmount];

player me = new player();

//array for bullets fired
ArrayList<bullet> bullets = new ArrayList<bullet>();

//array for health packs
ArrayList<hpPack> hpPacks = new ArrayList<hpPack>();

void setup() {
  //ball generator
  for (int i = 0; i < ballAmount; i++) {
    balls.add (new ball());
  }


  //block generator
  for (int i = 0; i < blockAmount; i++) {
    blocks[i] = new block();
  }

  //health pack generator
  for (int i = 0; i < hpPackAmount; i++) {
    hpPacks.add (new hpPack());
  }
}

void draw () {

  colorMode(RGB, 255, 255, 255);
  background(150);

  println(me.health);
  //slow motion for checking physics (hit spacebar)
  if (slow) {
    frameRate(20);
  } else {
    frameRate(200);
  }

  //balls
  for (int i = 0; i < balls.size(); i++) {
    ball part = balls.get(i);
    //check for walls
    part.wallCheck();
    //moves balls
    part.move();
    //draws balls
    part.display();
  }

  //blocks
  for (int i = 0; i < blockAmount; i++) {
    blocks[i].display();
  }

  //health packs
  for (int h = 0; h < hpPacks.size(); h++) {
    hpPack part = hpPacks.get(h);
    part.display();
  }

  //player
  me.move();
  me.hpPackCheck();
  me.ballCheck();
  me.immunityTime();
  me.display();

  if (me.shooting && frameCount % me.rof == 0) {
    //makes a new bullet
    bullets.add(new bullet());
  }

  //bullets
  for (int i = 0; i < bullets.size(); i++) {
    bullet part = bullets.get(i);
    part.move();
    part.ballHitCheck();
    part.wallCheck();
    part.display();
  }

  //health decay over time
  if (me.health > 0) {
    me.health -= me.healthDecay;
  }
  //healthbar on the top
  rectMode(CORNER);
  noStroke();
  fill(#FF0000, 100);
  rect(0, 0, me.health/me.maxHealth*width, 10);


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

  //shooting direction test
  stroke(0);
  strokeWeight(3);
  line(me.x, me.y, mouseX, mouseY);
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

  //testing health
  if (key == 'h') { 
    me.health = me.maxHealth;
  }
}
int count = 0;
void mousePressed() {
  count++;
  me.shooting = true;
}

void mouseReleased() {
  me.shooting = false;
  
}
