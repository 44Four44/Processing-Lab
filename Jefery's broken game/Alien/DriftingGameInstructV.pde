/* 
 Description: A triangle hits aliens and avoids asteroids for points.
 Author: Jeffrey Lin
 Date of last edit: January 19th, 2017
 */

PFont name;
PFont start;
PFont title;
boolean startGame;
boolean open;
boolean ded;
boolean startTimer;
int x;
int y ;
int score;
int timer;
int points;
int resetTimer;
float pointAx;
float pointAy;
float pointBx;
float pointBy;
float pointCx;
float pointCy;

Asteroid[] asteroids = new Asteroid[10];
Alien[] aliens = new Alien[12];
//Makes program fullscreen
void settings() {
  fullScreen();
}

void setup() {
  colorMode(HSB, 360, 100, 100, 1);
  background(213, 100, 12, 1);
  //configures the booleans
  startGame = false;
  open = true;
  ded = false;
  startTimer = false;

  //starting values
  y = 0;
  x = 0;
  score = 0;
  points = 0;
  timer = 0;

  //Alien and Asteroid classes run for a certain number of times
  for (int i = 0; i < asteroids.length; i++) {
    asteroids[i] = new Asteroid();
  }
  for (int i = 0; i < aliens.length; i++) {
    aliens[i] = new Alien();
  }
}

void draw() {
  //coordinates for the triangle
  pointAx = width/16*7.5+x;
  pointAy = height/4*3+y;
  pointBx = width/16*8.5+x;
  pointBy = height/4*3+y;
  pointCx = width/2+x;
  pointCy = height/4*2.5+y;
  //triggers screen changes
  if (open == true) {
    mainScreen();
  }
  if (startGame == true) {
    gameScreen();
    ded = false;
  }
  if (ded == true) {
    dedScreen();
  }
}
//game over screen
void dedScreen() {
  fill(0);
  rect(0, 0, width, height);
  textFont(start);
  fill(0, 0, 100);
  text("GAME OVER", width/2, height/2-100);
  text("Press a Key to Return to Main Screen", width/2, height/2);
}
//in-game screen
void gameScreen() {
  fill(247, 45, 11, 1);
  rect(0, 0, width, height);
  for (int i = 0; i < asteroids.length; i++) {
    asteroids[i].showAs();
  }
  for (int i = 0; i < aliens.length; i++) {
    aliens[i].showAl();
    aliens[i].move();
  }
  fill(0, 0, 100);
  triangle(pointAx, pointAy, pointBx, pointBy, pointCx, pointCy);
  fill(192, 100, 85);
  noStroke();
  ellipse(width/2-1+x, height/8*5.5+y-5, 25, 25);
  fill(0, 0, 100);
  textFont(name);
  text("Score: " + str(score+points), width-100, height-150);
  text("EXIT (ESC)", 100, 50);
  text("MAIN MENU (M)", 125, 100);
  if (startGame == true) {
    timer =   millis()/1000-resetTimer;
    text(timer, width-100, height-100);
  }
  if (timer == 60) {
    startGame = false;
    ded = true;
      score = 0;
    x = 0;
    y = 0;
  }
  //Collision for Asteroids
  for (int i = 0; i < asteroids.length; i++) {
    if (dist(pointAx, pointAy, asteroids[i].AsX, asteroids[i].AsY) < 50) {
      ded = true;
      startGame = false;
    };
  }
  for (int i = 0; i < asteroids.length; i++) {
    if (dist(pointBx, pointBy, asteroids[i].AsX, asteroids[i].AsY) < 50) {
      ded = true;
      startGame = false;
    };
  }
  for (int i = 0; i < asteroids.length; i++) {
    if (dist(pointCx, pointCy, asteroids[i].AsX, asteroids[i].AsY) < 50) {
      ded = true;
      startGame= false;
    };
  }
  //Collision for Aliens
  for (int i = 0; i < aliens.length; i++) {
    if (dist(pointCx, pointCy, aliens[i].AlX, aliens[i].AlY) < 40) {
      score = score + 10;
      aliens[i].remove();
      
    };
  }
  for (int i = 0; i < aliens.length; i++) {
    if (dist(pointBx, pointBy, aliens[i].AlX, aliens[i].AlY) < 40) {
      score = score +10;
    aliens[i].remove();
    };
  }
  for (int i = 0; i < aliens.length; i++) {
    if (dist(pointAx, pointAy, aliens[i].AlX, aliens[i].AlY) < 40) {
      score = score +10;
     aliens[i].remove();
    };
  }
}
//menu
void mainScreen() {
  fill(213, 100, 12, 1);
  rect(0, 0, width, height);
  name = createFont("Rockwell", 30);
  textAlign(CENTER);
  textFont(name);
  fill(0, 0, 100);
  text("EXIT (ESC)", 100, 50);
  text("JEFFREY LIN", width/2, height/8);
  title = createFont("Blackadder ITC", 150);
  textFont(title);
  text("Drifting", width/2, height/3);
  fill(188, 100, 81);
  rect(width/7*3, height/2, width/7*1, 100);
  start = createFont("Rockwell", 65);
  textFont(title);
  textFont(start);
  fill(0, 0, 100);
  text("PLAY", width/2, height/2+75);
  text("Information (i)", width/2, height/2+200);
}
void mouseClicked() {
  //enables 'play' button
  if (mouseX>=width/7*3&&mouseX<width/7*4&&mouseY>=height/2&&mouseY<height/2+100&&open==true) {
    open = false;
    startGame=true;
    startTimer = true;
    //subtracts the millis() to allow for continual use
    if (startTimer == true) {
      resetTimer =   millis()/1000;
      startTimer = false;
    }
  }
}
void keyPressed() {
  //opens menu from in-game
  if (startGame ==true) {
    if (key == 'm') {
      open = true;
      startGame= false;
      x = 0;
      y = 0;
        score = 0;
    }
    //allows character to move
    if (keyCode == UP&&pointCy>0) {
      y = y - 20;
    } else if (keyCode == DOWN&&pointAy<height&&pointBy<height) {
      y = y + 20;
    } else if (keyCode == LEFT&&pointAx>0) {
      x = x -20;
    } else if (keyCode == RIGHT&&pointBx<width) {
      x = x +20;
    }
  }
  //information menu
  if (key == 'i'&&open==true&&startGame == false) {
    open = false;
    fill(213, 100, 12, 1);
    rect(0, 0, width, height);
    fill(0, 0, 100);
    text("Instructions", width/2, height/3);
    text("Use Up/Down/Left/Right to Move", width/2, height/3+100);
    text("Score Points By Hitting Aliens", width/2, height/3+200);
    text("Please Be Cautious of Asteroids", width/2, height/3+300);
    text("Press a Key to Return to Main Screen", width/2, height/3+400);
  } else {
    open =true;
  }
  //returns to main menu from dead screen
  if (keyPressed == true) {
    if (ded == true) {
      ded = false;
      open = true;
    }
  }
}