void settings () {
  size(600, 600);
}

void setup() {
}

//all the coordinates of the reflection points of the trajectory path
float[] reflectionPoints = new float[14];

float[] reflectionAngles = new float[7];

//array of marker points
float[][] markers = new float[15][15];

//is true if ball will be hit
boolean[] ballHit = new boolean [666667];

//to caclculate the angle of the shot
PVector cueAngle, initialArm;

//locks the shot in place
boolean shotLock = true;

//adjustable values
float boundaryWidth = 209;
float boundaryHeight = 421;
float tableWidth = boundaryWidth+52;
float tableHeight = boundaryHeight+50;
float cueBallDiameter = 14;
float otherBallsDiameter = 14;

//cue ball
float cueBallX = 300;
float cueBallY = 300;

//for when the user doesn't want to view a ball's trajectory the color's alpha decreases
boolean transparent[] = new boolean [15];

//if user selects this ball
boolean ballSelected[] = new boolean [15];

//flashing counter for when a ball is selected
int flashCounter = 0;

//balls' colors
float ballColor[] = new float [45];

//array with preset colors
//yellow, blue, red, purple, orange, green, mahagony, black
float colors[] = {255, 230, 0, 24, 0, 255, 255, 0, 0, 122, 0, 255, 255, 141, 0, 24, 157, 45, 126, 17, 11, 0, 0, 0};

//an array of numbers
char integers[] = {'1', '2', '3', '4', '5', '6', '7', '8'};

//if ball is 'invisible'
boolean visibility[] = new boolean[15];

//makes drag smoother
boolean cueDragged = false;

//true if the help tab is opened
boolean helpTab = false;

//true if a ball is selected
boolean markerTab = false;

//the ball that was selected
int currentBall = 666;

//marker counter
int markerCount = 0; 


void draw() {
  //flash Counter
  if (flashCounter<600) {
    flashCounter++;
  } else {
    flashCounter = 0;
  }

  //background
  background(180);

  //to caculate initial angle of shot
  initialArm = new PVector(300, 0);
  //if shot is locked then the trajectory line won't move 
  cueAngle = new PVector(mouseX-cueBallX, mouseY-cueBallY);


  //pool table
  noStroke();
  fill(#8B4112);
  rect(300-tableWidth/2, 300-tableHeight/2, tableWidth, tableHeight);

  //inside table
  fill(#40ABD3);
  rect(326-tableWidth/2, 325-tableHeight/2, boundaryWidth, boundaryHeight);

  //rectangle of reflection boundaries inside the pool table
  noFill();
  stroke(80);
  rect(326-tableWidth/2+cueBallDiameter/2, 325-tableHeight/2+cueBallDiameter/2, 
    boundaryWidth-cueBallDiameter, boundaryHeight-cueBallDiameter);

  //pocket/holes
  noStroke();
  fill(0);
  ellipse(318-tableWidth/2, 318-tableHeight/2, 28, 28);
  ellipse(282+tableWidth/2, 318-tableHeight/2, 28, 28);
  ellipse(318-tableWidth/2, 282+tableHeight/2, 28, 28);
  ellipse(282+tableWidth/2, 282+tableHeight/2, 28, 28);
  ellipse(315-tableWidth/2, 300, 22, 22);
  ellipse(285+tableWidth/2, 300, 22, 22);

  //puts cue ball coordinates and direction into reflectionPoints/Angles array
  reflectionPoints[0] = cueBallX;
  reflectionPoints[1] = cueBallY;
  if (shotLock) {
    reflectionAngles[0] = initialAngle();
  }

  //if cue ball is moved
  if (cueDragged) {
    if (mouseX-cueBallDiameter/2>=300-boundaryWidth/2 && mouseX+cueBallDiameter/2<=300+boundaryWidth/2) {
      cueBallX = mouseX;
    }
    if ( mouseY-cueBallDiameter/2>=300-boundaryHeight/2 && mouseY+cueBallDiameter/2<=300+boundaryHeight/2) {
      cueBallY = mouseY;
    }
  }

  //cue ball
  noStroke();
  fill(255);
  ellipse(cueBallX, cueBallY, cueBallDiameter, cueBallDiameter);

  //marker balls
  for (int j = 0; j<15; j++) {

    noStroke();

    //is slightly transparent if the ball is selected
    if (ballSelected[j]) {
      if ((flashCounter/40)%2 == 0) {
        fill(ballColor[3*j], ballColor[3*j+1], ballColor[3*j+2], 255);
      } else {
        fill(ballColor[3*j], ballColor[3*j+1], ballColor[3*j+2], 120);
      }
    } else {
      fill(ballColor[3*j], ballColor[3*j+1], ballColor[3*j+2]);
    }

    //expands a bit when cursor is hovering over a ball
    if (mouseX>markers[j][0]-otherBallsDiameter/2 && mouseX<markers[j][0]+otherBallsDiameter/2 
      && mouseY>markers[j][1]-otherBallsDiameter/2 && mouseY<markers[j][1]+otherBallsDiameter/2
      || ballSelected[j]) {
      ellipse(markers[j][0], markers[j][1], otherBallsDiameter+4, otherBallsDiameter+4);
    } else {
      ellipse(markers[j][0], markers[j][1], otherBallsDiameter, otherBallsDiameter);
    }
  }

  //lines of trajectory
  if (!cueDragged) {
    //ghost balls for cue ball
    for (int l = 0; l<11; l+=2) {
      fill(180);
      ellipse(reflectionPoints[l+2], reflectionPoints[l+3], cueBallDiameter, cueBallDiameter);
    }

    //to reset ball hit in case ball is not his this frame
    for (int a = 0; a<15; a++) {
      ballHit[a] = false;
    }

    stroke(0);
    strokeWeight(2);
    //trajectory lines
    for (int i = 0; i<11; i+=2) {
      //initial shot line is blue
      if (i == 0) {
        stroke(#01108B);
      } else {
        stroke(0);
      }
      //lines connected by points of incidence
      reflection(i/2+1, reflectionPoints[i], reflectionPoints[i+1], reflectionAngles[i/2]);
      line(reflectionPoints[i], reflectionPoints[i+1], reflectionPoints[i+2], reflectionPoints[i+3]);
    }

    //marker ball lines
    for (int y = 0; y<15; y++) {

      //visibility check
      if (visibility[y]) {
        //fill of the ball depends on its ballColor
        stroke(ballColor[3*y], ballColor[3*y+1], ballColor[3*y+2], 40);
        fill(ballColor[3*y], ballColor[3*y+1], ballColor[3*y+2], 40);
      } else {
        //fill of the ball depends on its ballColor
        stroke(ballColor[3*y], ballColor[3*y+1], ballColor[3*y+2]);
        fill(ballColor[3*y], ballColor[3*y+1], ballColor[3*y+2]);
      }
      if (ballHit[y]) {
        for (int z = 0; z<12; z+=3) {
          //calculates the position and angle of the next ghost ball
          markerReflection(y, z);
          if (markers[y][0] != 0 && markers[y][1] != 0) {
            line(markers[y][z], markers[y][z+1], markers[y][z+3], markers[y][z+4]);
          }
        }

        //ghost balls for other balls
        for (int l = 3; l<15; l+=3) {
          noStroke();
          //        fill(ballColor[3*y], ballColor[3*y+1], ballColor[3*y+2], 100);
          ellipse(markers[y][l], markers[y][l+1], otherBallsDiameter, otherBallsDiameter);
        }
      }
    }
  }

  //color guide on the left
  for (int e = 0; e<24; e+=3) {
    noStroke();
    fill(colors[e], colors[e+1], colors[e+2]);
    ellipse(20, 330 + 12*e, 30, 30);

    textSize(30);
    //corresponding number
    text(e/3+1, 50, 340 + 12*e);
  }

  //the help tab on the right
  if (helpTab) {
    fill(150);
    stroke(100);
    rect(450, 0, 450, 600);

    //instructions
    fill(0);
    textSize(16);

    text("Drag cue ball \nto move it", 460, 20);

    text("Click on a ball for\nadditional options", 460, 80);

    text("Numbers 1~8 to\nplace a ball", 460, 150);

    text("'c' : move cue \nball to cursor", 460, 220);

    text("'SPACEBAR' :\nlock the shot\nin place", 460, 290);

    text("'t' and 'y':\ntoggle visibility\nof all balls", 460, 380);

    text("'r': clear all\nballs", 460, 470);

    text("'LEFT' and 'RIGHT'\n arrow keys to \n adjust shot", 460, 540);
  }

  //button to open the help tab
  stroke(100);
  if (mouseX>570 && mouseY < 30) {
    fill(100);
    rect(570, 0, 30, 30);
  } else { 
    fill(150);
    rect(570, 0, 30, 30);
  }
  fill(0);
  textSize(30);
  text("?", 580, 27);

  //markerTab on the right 
  if (markerTab) {
    stroke(100);
    fill(150);
    rect(0, 0, 150, 150);

    //instructions
    fill(0);
    textSize(16);

    text("1~8 to change\ncolor of ball", 10, 20);

    text("'v' : toggle\nvisibility", 10, 80);
  }
}

//function to calculate angles without returning undefined values between two points
float angleOf(float initialX, float initialY, float terminalX, float terminalY) {
  PVector initialLine, terminalLine;
  initialLine = new PVector(300, 0);
  terminalLine = new PVector(terminalX - initialX, terminalY - initialY);
  if (initialY>terminalY) {
    return 2*PI - PVector.angleBetween(initialLine, terminalLine);
  } else {
    return PVector.angleBetween(initialLine, terminalLine);
  }
}

//checks if ball will collide with another ball on its path
boolean checkCollision (float startX, float startY, float shotAngle, float ballX, float ballY, float initialBallDiameter, float incidentBallDiameter) {
  if (sin(abs(shotAngle - angleOf(startX, startY, ballX, ballY)))*(sqrt(pow(ballX-startX, 2)+pow(ballY-startY, 2))) < initialBallDiameter/2 + incidentBallDiameter/2
    && abs(shotAngle - angleOf(startX, startY, ballX, ballY))<PI/2) {
    return true;
  } else {
    return false;
  }
}

//angle of the initial cue shot
float initialAngle() {
  if (mouseY<cueBallY) {
    return 2*PI - PVector.angleBetween(cueAngle, initialArm);
  } else {
    return PVector.angleBetween(cueAngle, initialArm);
  }
}

void keyPressed() {

  //if user wants to change the color of an existing ball
  if (markerTab && currentBall != 666) {
    for (int t = 0; t<8; t++) {
      if (key == integers[t]) {
        //sets color based on the number pressed
        ballColor[3*currentBall] = colors[3*t];
        ballColor[3*currentBall+1] = colors[3*t+1];
        ballColor[3*currentBall+2] = colors[3*t+2];
      }
    }

    //if user toggles the visibility
    if (key == 'v') {
      visibility[currentBall] = !visibility[currentBall];
    }
  } else {
    //sets down a marker ball
    if (markerCount<15) {
      for (int t = 0; t<8; t++) {
        if (key == integers[t] && mouseX-otherBallsDiameter/2>=300-boundaryWidth/2 && mouseX+otherBallsDiameter/2<=300+boundaryWidth/2
          && mouseY-otherBallsDiameter/2>=300-boundaryHeight/2 && mouseY+otherBallsDiameter/2<=300+boundaryHeight/2) {

          //sets color based on the number pressed
          markers[markerCount][0] = mouseX; 
          markers[markerCount][1] = mouseY; 
          ballColor[3*markerCount] = colors[3*t];
          ballColor[3*markerCount+1] = colors[3*t+1];
          ballColor[3*markerCount+2] = colors[3*t+2];
          markerCount++;
        }
      }
    }
  }

  //changes ALL of the balls' visibilities
  if (key == 't') {
    for (int t = 0; t<15; t++) {
      visibility[t] = true;
    }
  }

  if (key == 'y') {
    for (int t = 0; t<15; t++) {
      visibility[t] = false;
    }
  }

  //resets all balls and their transparency
  if (key=='r') {
    for (int k = 0; k<15; k++) {
      for (int n = 0; n<15; n++) {
        markers[k][n] = 0;
      }
      transparent[k] = false;
    }
    markerCount = 0;
  }
  //moves cue ball to cursor
  if (key =='c') {
    cueBallX = mouseX; 
    cueBallY = mouseY;
  }

  //toggles between locking the shot in place and allowing it to follow the cursor
  if (key == ' ') {
    shotLock = !shotLock;
    println("user toggled shotLock");
  }

  if (keyCode == LEFT) {
    reflectionAngles[0] = reflectionAngles[0] +=PI/7200;
  }
  if (keyCode == RIGHT) {
    reflectionAngles[0] = reflectionAngles[0] -=PI/7200;
  }
}

void mousePressed() {

  //if user moves the cue ball
  if (mouseX>cueBallX-cueBallDiameter/2 && mouseX<cueBallX+cueBallDiameter/2 
    && mouseY>cueBallY-cueBallDiameter/2 && mouseY<cueBallY+cueBallDiameter/2) {
    cueDragged = true;
  }

  markerTab = false;

  //if user selects a ball
  for (int b = 0; b<15; b++) {
    if (mouseX>markers[b][0]-otherBallsDiameter/2 && mouseX<markers[b][0]+otherBallsDiameter/2
      && mouseY>markers[b][1]-otherBallsDiameter/2 && mouseY<markers[b][1]+otherBallsDiameter/2) {
      ballSelected[b] = !ballSelected[b];
      markerTab = true;
      currentBall = b;
    } else {
      ballSelected[b] = false;
    }
  }

  //if user open the help tab
  if (mouseX>570 && mouseY < 30) {
    helpTab = !helpTab;
  }
}

void mouseReleased() {
  //cue ball stops moving when mouse is released
  cueDragged = false;
}

int previousHitBall = 666666;



//line of trajectory to check when it crosses the boundaries of the pool table
void reflection (int reflectionNumber, float ballX, float ballY, float ballAngle) {

  //is true if there is going to be a collision so that it will only it a ball or a wall not both
  boolean collided = false;

  //the numbered ball in array markers that will be hit
  int collisionNumber = 666666;

  //the ength from a markers collision ghost ball to the shot ball, so lengths can be compared
  float ballDistance = 666666;  

  //an array to compare all distance values with the min function
  float[] collisions = new float [14];

  //sets all the collisions elemnts to some arbritrary value to prevent NaN
  for (int y = 0; y<14; y++) {
    collisions[y] = 1000;
  }

  //checks if the ball will collide with another ball
  //goes through every marker ball to see which one it hits
  for (int p = 0; p<14; p++) { 
    if (checkCollision(ballX, ballY, ballAngle, markers[p][0], markers[p][1], cueBallDiameter, otherBallsDiameter) && markers[p][0] != 0 && !ballHit[p]) {
      //puts this value into array to text for the minimun (the ball it will hit first)
      collisions[p] = (cos(abs(ballAngle - angleOf(ballX, ballY, markers[p][0], markers[p][1])))
        *(sqrt(pow(markers[p][0]-ballX, 2)+pow(markers[p][1]-ballY, 2))) - sqrt(pow(cueBallDiameter/2+otherBallsDiameter/2, 2)-pow(sin(abs(ballAngle - angleOf(ballX, ballY, markers[p][0], markers[p][1])))
        *(sqrt(pow(markers[p][0]-ballX, 2)+pow(markers[p][1]-ballY, 2))), 2)));

      //q will be the smallest distance from a marker ball in the shot line
      ballDistance = min(collisions);

      /*if the distance from this ball to the shot ball is the shortest in the array,
       it will change the ball number that is hit to the current ball being checked*/
      if (collisions[p] == min(collisions)) {
        collisionNumber = p;

        //true if it is in the shot line of some ball
        ballHit[collisionNumber] = true;
      }
    }
  }

  //values for the ball that was hit
  // only counts as a collision if q and collisionNumber were given values in the for loop above
  if (collisionNumber != 666666 && ballDistance != 666666) {

    //x coordinate of ghost ball
    reflectionPoints[2*reflectionNumber] = ballX + cos(ballAngle)*ballDistance;

    //y cordinate of ghost ball
    reflectionPoints[2*reflectionNumber+1] = ballY + sin(ballAngle)*ballDistance;

    // angle of reflection
    if (angleOf(ballX, ballY, markers[collisionNumber][0], markers[collisionNumber][1]) > ballAngle) {
      reflectionAngles[reflectionNumber] = (angleOf(reflectionPoints[2*reflectionNumber], 
        reflectionPoints[2*reflectionNumber+1], markers[collisionNumber][0], markers[collisionNumber][1]) + 3*PI/2)%(2*PI);
    } else {
      reflectionAngles[reflectionNumber] = (angleOf(reflectionPoints[2*reflectionNumber], 
        reflectionPoints[2*reflectionNumber+1], markers[collisionNumber][0], markers[collisionNumber][1]) + PI/2)%(2*PI);
    }

    //angle of hit ball
    markers[collisionNumber][2] = (angleOf(reflectionPoints[2*reflectionNumber], 
      reflectionPoints[2*reflectionNumber+1], markers[collisionNumber][0], markers[collisionNumber][1]));

    //means that it bounces of a ball not a wall
    collided = true;
  }

  if (!collided) {

    if (ballAngle >= atan((300+boundaryHeight/2-cueBallDiameter/2-ballY)/(300+boundaryWidth/2-cueBallDiameter/2-ballX))
      && ballAngle < PI - atan((300+boundaryHeight/2-cueBallDiameter/2-ballY)/(ballX-300+boundaryWidth/2-cueBallDiameter/2))) {
      //checks if ball will bounce of the bottom side
      reflectionPoints[2*reflectionNumber] = ballX + (300+boundaryHeight/2-cueBallDiameter/2-ballY)/tan(ballAngle);
      reflectionPoints[2*reflectionNumber+1] = 300+boundaryHeight/2-cueBallDiameter/2;
      reflectionAngles[reflectionNumber] = 2*PI - reflectionAngles[reflectionNumber-1];
    } else if (ballAngle >= PI - atan((300+boundaryHeight/2-cueBallDiameter/2-ballY)/(ballX-300+boundaryWidth/2-cueBallDiameter/2)) 
      && ballAngle < PI + atan((ballY-300+boundaryHeight/2-cueBallDiameter/2)/(ballX-300+boundaryWidth/2-cueBallDiameter/2))) {
      //checks if ball will bounce of the left side
      reflectionPoints[2*reflectionNumber] = 300-boundaryWidth/2+cueBallDiameter/2;
      reflectionPoints[2*reflectionNumber+1] = ballY + (300-boundaryWidth/2+cueBallDiameter/2-ballX)*tan(ballAngle);
      reflectionAngles[reflectionNumber] = (3*PI - reflectionAngles[reflectionNumber-1])%(2*PI);
    } else if (ballAngle >= PI + atan((ballY-300+boundaryHeight/2-cueBallDiameter/2)/(ballX-300+boundaryWidth/2+cueBallDiameter/2)) 
      && ballAngle < 2*PI - atan((ballY-300+boundaryHeight/2-cueBallDiameter/2)/(300+boundaryWidth/2-cueBallDiameter/2-ballX))) {
      //checks if ball will bounce of the top side
      reflectionPoints[2*reflectionNumber] = ballX - (ballY-300+boundaryHeight/2-cueBallDiameter/2)/tan(ballAngle);
      reflectionPoints[2*reflectionNumber+1] = 300-boundaryHeight/2+cueBallDiameter/2;
      reflectionAngles[reflectionNumber] = 2*PI - reflectionAngles[reflectionNumber-1];
    } else {
      //checks if ball will bounce of the right side
      reflectionPoints[2*reflectionNumber] = 300+boundaryWidth/2-cueBallDiameter/2;
      reflectionPoints[2*reflectionNumber+1] = ballY + (300+boundaryWidth/2-cueBallDiameter/2-ballX)*tan(ballAngle);
      reflectionAngles[reflectionNumber] = (3*PI - reflectionAngles[reflectionNumber-1])%(2*PI);
    }
  }
}



//line of trajectory to check when it crosses the boundaries of the pool table
void markerReflection (int markerNumber, int reflectionNumber) {

  //is true if there is going to be a collision so that it will only it a ball or a wall not both
  boolean collided = false;

  //the numbered ball in array markers that will be hit
  int collisionNumber = 666666;

  //the ength from a markers collision ghost ball to the shot ball, so lengths can be compared
  float ballDistance = 666666;

  //an array to comparre all distance values with the min function
  float[] collisions = new float [14];

  //sets all the collisions elemnts to some arbritrary value to prevent NaN
  for (int y = 0; y<14; y++) {
    collisions[y] = 1000;
  }

  //checks if the ball will collide with another ball
  //goes through every marker ball to see which one it hits
  for (int p = 0; p<14; p++) {
    if (checkCollision(markers[markerNumber][reflectionNumber], markers[markerNumber][reflectionNumber+1], markers[markerNumber][reflectionNumber+2], markers[p][0], markers[p][1], otherBallsDiameter, otherBallsDiameter) && markers[p][0] != 0 && !ballHit[p] && p != markerNumber) {
      //puts this value into array to text for the minimun (the ball it will hit first)
      collisions[p] = (cos(abs(markers[markerNumber][reflectionNumber+2] - angleOf(markers[markerNumber][reflectionNumber], markers[markerNumber][reflectionNumber+1], markers[p][0], markers[p][1])))
        *(sqrt(pow(markers[p][0]-markers[markerNumber][reflectionNumber], 2)+pow(markers[p][1]-markers[markerNumber][reflectionNumber+1], 2))) - sqrt(pow(otherBallsDiameter/2+otherBallsDiameter/2, 2)-pow(sin(abs(markers[markerNumber][reflectionNumber+2] - angleOf(markers[markerNumber][reflectionNumber], markers[markerNumber][reflectionNumber+1], markers[p][0], markers[p][1])))
        *(sqrt(pow(markers[p][0]-markers[markerNumber][reflectionNumber], 2)+pow(markers[p][1]-markers[markerNumber][reflectionNumber+1], 2))), 2)));

      //q will be the smallest distance from a marker ball in the shot line
      ballDistance = min(collisions);

      //if the distance from this ball to the shot ball is the shortest in the array,
      //it will change the ball number that is hit to the current ball being checked
      if (collisions[p] == min(collisions)) {
        collisionNumber = p;

        //true if it is in the shot line of some ball
        ballHit[collisionNumber] = true;
      }
    }
  }

  // only counts as a collision if q and collisionNumber were given values in the for loop above
  if (collisionNumber != 666666 && ballDistance != 666666 ) {

    //x coordinate of ghost ball
    markers[markerNumber][reflectionNumber+3] = markers[markerNumber][reflectionNumber] + cos(markers[markerNumber][reflectionNumber+2])*ballDistance;

    //y cordinate of ghost ball
    markers[markerNumber][reflectionNumber+4] = markers[markerNumber][reflectionNumber+1] + sin(markers[markerNumber][reflectionNumber+2])*ballDistance;

    // angle of reflection
    if (angleOf(markers[collisionNumber][0], markers[collisionNumber][1], markers[markerNumber][reflectionNumber], markers[markerNumber][reflectionNumber+1]) > (markers[markerNumber][reflectionNumber+2] + PI)%(2*PI)) {
      markers[markerNumber][reflectionNumber+5] = (angleOf(markers[markerNumber][reflectionNumber+3], 
        markers[markerNumber][reflectionNumber+4], markers[collisionNumber][0], markers[collisionNumber][1]) + 3*PI/2)%(2*PI);
 println("NO");
  } else {
      println("OK");
      markers[markerNumber][reflectionNumber+5] = (angleOf(markers[collisionNumber][reflectionNumber+3], 
        markers[collisionNumber][reflectionNumber+4], markers[collisionNumber][0], markers[collisionNumber][1]) - PI/2)%(2*PI);
    }

    markers[collisionNumber][2] = (angleOf(markers[markerNumber][reflectionNumber+3], 
      markers[markerNumber][reflectionNumber+4], markers[collisionNumber][0], markers[collisionNumber][1]));

    //means that it bounces of a ball not a wall
    collided = true;
  }


  if (!collided ) {

    if (markers[markerNumber][reflectionNumber+2] >= atan((300+boundaryHeight/2-otherBallsDiameter/2-markers[markerNumber][reflectionNumber+1])/(300+boundaryWidth/2-otherBallsDiameter/2-markers[markerNumber][reflectionNumber]))
      && markers[markerNumber][reflectionNumber+2] < PI - atan((300+boundaryHeight/2-otherBallsDiameter/2-markers[markerNumber][reflectionNumber+1])/(markers[markerNumber][reflectionNumber]-300+boundaryWidth/2-otherBallsDiameter/2))) {
      //checks if ball will bounce of the bottom side
      markers[markerNumber][reflectionNumber+3] = markers[markerNumber][reflectionNumber] + (300+boundaryHeight/2-otherBallsDiameter/2-markers[markerNumber][reflectionNumber+1])/tan(markers[markerNumber][reflectionNumber+2]);
      markers[markerNumber][reflectionNumber+4] = 300+boundaryHeight/2-otherBallsDiameter/2;
      markers[markerNumber][reflectionNumber+5] = 2*PI - markers[markerNumber][  reflectionNumber+2];
    } else if (markers[markerNumber][reflectionNumber+2] >= PI - atan((300+boundaryHeight/2-otherBallsDiameter/2-markers[markerNumber][reflectionNumber+1])/(markers[markerNumber][reflectionNumber]-300+boundaryWidth/2-otherBallsDiameter/2)) 
      && markers[markerNumber][reflectionNumber+2] < PI + atan((markers[markerNumber][reflectionNumber+1]-300+boundaryHeight/2-otherBallsDiameter/2)/(markers[markerNumber][reflectionNumber]-300+boundaryWidth/2-otherBallsDiameter/2))) {
      //checks if ball will bounce of the left side
      markers[markerNumber][reflectionNumber+3] = 300-boundaryWidth/2+otherBallsDiameter/2;
      markers[ markerNumber][reflectionNumber+4] = markers[markerNumber][reflectionNumber+1] + (300-boundaryWidth/2+otherBallsDiameter/2-markers[markerNumber][reflectionNumber])*tan(markers[markerNumber][reflectionNumber+2]);
      markers[markerNumber][reflectionNumber+5] = (3*PI - markers[markerNumber][reflectionNumber+2])%(2*PI);
    } else if (markers[markerNumber][reflectionNumber+2] >= PI + atan((markers[markerNumber][reflectionNumber+1]-300+boundaryHeight/2-otherBallsDiameter/2)/(markers[markerNumber][reflectionNumber]-300+boundaryWidth/2+otherBallsDiameter/2)) 
      && markers[markerNumber][reflectionNumber+2] < 2*PI - atan((markers[markerNumber][reflectionNumber+1]-300+boundaryHeight/2-otherBallsDiameter/2)/(300+boundaryWidth/2-otherBallsDiameter/2-markers[markerNumber][reflectionNumber]))) {
      //checks if ball will bounce of the top side
      markers[markerNumber][reflectionNumber+3] = markers[markerNumber][reflectionNumber] - (markers[markerNumber][reflectionNumber+1]-300+boundaryHeight/2-otherBallsDiameter/2)/tan(markers[markerNumber][reflectionNumber+2]);
      markers[markerNumber][reflectionNumber+4] = 300-boundaryHeight/2+otherBallsDiameter/2;
      markers[markerNumber][reflectionNumber+5] = 2*PI - markers[markerNumber][  reflectionNumber+2];
    } else {
      //checks if ball will bounce of the right side
      markers[markerNumber][reflectionNumber+3] = 300+boundaryWidth/2-otherBallsDiameter/2;
      markers[markerNumber][reflectionNumber+4] = markers[markerNumber][reflectionNumber+1] + (300+boundaryWidth/2-otherBallsDiameter/2-markers[markerNumber][reflectionNumber])*tan(markers[markerNumber][reflectionNumber+2]);
      markers[markerNumber][reflectionNumber+5] = (3*PI - markers[markerNumber][reflectionNumber+2])%(2*PI);
    }
  }
}