void settings() {
  size(600, 450);
}
void setup() {
}
//speed of the snake
float speed = 5;

//background checkerboard
boolean colorGrey = true;

//head of snake coordinates
int headX = 4;
int headY = 7;

//direction of snake
int snakeDirection = 0;

//coordinates of apple
int appleX = 16;
int appleY = 7;

//score
int score = 0;

//array that stores all of the snake squares
int snakeCount = 4;
int [] snakeBits = new int[300];

//checks if snake ate an apple in the previous frame
boolean ateApple = false;

//increases as game goes on and more obstacles
float difficulty = 0;

void draw() {
  frameRate(speed);
  //exponentially increases speed of snake overtime
  if (speed<15) {
    speed+=0.015625;
  }
  //logs the speed everytime it reaches the next whole number
  if (speed%1 == 0) {
    println("speed = " + speed + "fps");
  }

  //background checkerboard
  for (int i = 0; i<20; i++) {
    for (int j =0; j<15; j++) {
      noStroke();
      //to toggle between the colors
      if (colorGrey) {
        fill(240);
        colorGrey = !colorGrey;
      } else {
        fill(255);
        colorGrey = !colorGrey;
      }
      //the squares in the checkboard
      rect(i*30, j*30, 30, 30);
    }
  }
  //checks if snake is alive
  if (lifeCheck()) {
    //apple
    fill(255, 0, 0);
    ellipse(30*appleX + 15, 30*appleY + 15, 30, 30);

    //direction of the snake 
    moveSnake();

    //changes the value of each bit (moves the snake following the head)
    for (int l = 2*snakeCount-1; l>2; l-=2) {
      snakeBits[l] = snakeBits[l-2];
      snakeBits[l-1] = snakeBits [l-3];
    }
    //sets head coordinates
    snakeBits[0] = headX;
    snakeBits[1] = headY;
    //if snakes eats the apple
    if (headX == appleX && headY == appleY) {
      //changes the location of the apple temporarly to prevent snake freezing glitch
      appleX = -1;
      appleY = -1;
      //random location for new apple
      while (appleCheck() || appleX == -1 || appleY == -1 ) {
        appleCheckCounter = false;
        appleX = int(random(0, 19));
        appleY = int(random(0, 14));
      }
      println("new apple at (" + appleX + " , " + appleY + ")");

      score++;
      println("score is " + score);
      ateApple = true;
      //increases speed too
      speed+=0.015625;
    } 

    //head of the snake
    for (int k = 0; k < 2*snakeCount; k+=2) {
      fill(0, 0, 255);
      rect(30*snakeBits[k], 30*snakeBits[k+1], 30, 30);
    }
    if (ateApple) {
      snakeCount++;
      ateApple = false;
    }
    textAlign(LEFT);
    //score in the top left corner
    fill(0);
    textSize(30);
    text(score, 5, 25);
  } else {
    //gameover screen
    textAlign(CENTER);
    textSize(40);
    fill(0);
    text("GAME OVER \n PRESS [SPACE] TO RESTART", 300, 200);
    //resets everything
    speed = 5;
    headX = 4;
    headY = 7;
    snakeDirection = 0;
    appleX = 16;
    appleY = 7;
    score = 0;
    snakeCount = 4;
    snakeBits = new int[300];

    ateApple = false;
    appleCheckCounter = false;
  }
}
//to prevent snake going into itself bug
int actualDirection = 0;
void moveSnake () {
  //if snake is moving right
  if (snakeDirection == 0) {
    actualDirection = 0;
    headX++;
  }
  //if snake is moving up
  if (snakeDirection == 1) {
    actualDirection = 1;
    headY--;
  }
  //if snake is moving left
  if (snakeDirection == 2) {
    actualDirection = 2;
    headX--;
  }
  //if snake is moving down
  if (snakeDirection == 3) {
    actualDirection = 3;
    headY++;
  }
}

void keyPressed() {
  if (keyCode == RIGHT && snakeDirection != 2 && actualDirection != 2) {
    snakeDirection = 0;
    println("right");
  }
  if (keyCode == UP && snakeDirection != 3 && actualDirection != 3) {
    snakeDirection = 1;
    println("up");
  }
  if (keyCode ==LEFT && snakeDirection != 0 && actualDirection != 0) {
    snakeDirection = 2;
    println("left");
  }
  if (keyCode == DOWN && snakeDirection != 1 && actualDirection != 1) {
    snakeDirection = 3;
    println("down");
  }

  //space to restart game after dying
  if (key == ' ') {
    lifeCheckCounter = false;
  }
}

//checks each element in array to see if head bumps into body
boolean lifeCheckCounter = false;
//checks if snake is still dead
boolean lifeCheck() {
  for (int m = 2; m<2*snakeCount; m+=2) {
    if (headX == snakeBits[m] && headY == snakeBits[m+1]) {
      lifeCheckCounter = true;
    }
  }
  if (headX<0 || headX>19 || headY<0 || headY>14) {
    lifeCheckCounter = true;
  }
  return !lifeCheckCounter;
}

//checks each element in array to see if apple is spawned on body
boolean appleCheckCounter = false;
//checks if apple is on snake body
boolean appleCheck() {
  //checks if apple coordinates match with any of the pairs in the array snakeBits
  for (int n = 0; n<300; n+=2) {
    if (appleX == snakeBits[n] && appleY == snakeBits[n+1]) {
      appleCheckCounter = true;
    }
  }
  return appleCheckCounter;
}