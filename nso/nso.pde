void settings() {
  fullScreen();
}

void setup() {
  //sets every note to its off state
  for (int m = 0; m < noteArraySize; m++) {
    note[3][m] = 0;
  }

  //  frameRate(10);

  //font
  goodFont = loadFont("STYuanti-SC-Regular-48.vlw");
}

//note array size
int noteArraySize = 50;

//cursor array size
int cursorArraySize = 20;

//keeps all of the notes' information
float[][] note = new float[14][noteArraySize]; 
// note[0][x] : x coordinate
// note[1][x] : y coordinate
// note[2][x] : timer 
// note[3][x] : type of note
// note[4][x] : color (HSB)
// note[5][x] : score
// note[6][x] : slider end X
// note[7][x] : slider end Y
// note[8][x] : slider start X 
// note[9][x] : slider start Y
// note[10][x] : slider life
// note[11][x] : slider middle of arc X/center X
// note[12][x] : slider middle of arc Y/center Y
// note[13][x] : note place

//for the cursor trail
float[][] cursor = new float[3][cursorArraySize];
// note[0][x] : x coordinate
// note[1][x] : y coordinate
// note[2][x] : timer 

// ~~adjustable values~~

float frequency = 60; 

float noteLife = 120; 

float noteLastChance = 6;

float[] noteHitIntervaul = {1, 0.5, 0.3, 0.15, 0, 1, 0.6, 0.4, 0.2, 0};
int[] noteHitScore = {0, 50, 150, 400, 400, 150, 50, 0};

float boundDistance = 400; 

float boundAngle = PI/3;

//speed at which slider slides at (pixels/second)
float speed = 300; 

//speed variance
float speedVariance = 20;

// ~~adjustable values~~

//difficulty
int difficulty = 1;


//angle between most and second recent most notes
float noteAngle = 666;

//coordinates of most and second most recent notes
float notePos1X;
float notePos1Y;

float notePos2X;
float notePos2Y;

//type of most recent note
float lastNoteType = 1;

//duration of last note
float lastTime = 0;

//next frequency
float nextFrequency = frequency;

// amount of notes in song
int noteCount = 0;

//current order of note (helps with order when playing) resets when combo changes
int noteOrder = 1;
// ~~styling stuff~~
//time for a note to fade out
int fadeTime = 20;

//time for the score to fade
int scoreFadeTime = 60;

//time for a note to fade in
int fadeInTime = 15;

//cursor size when not pressed
float cursorDiameter = 40;

//diameter of note
float noteDiameter = 100; 

//background color
float background = 0;

//font for score
PFont goodFont;

//difference of color change when notes change position?
int colorChange = 0;
// ~~styling stuff~~

// ~~slider stuff~~
//slider bounds (increases when pressed)
float sliderCircleSize = noteDiameter;

//is the slider being slided?
boolean firstSliderHeld = false;
// ~~slider stuff~~


// ~~scoring stuff~~
//score text size
int scoreText = 40;

//score
int score = 0; 

//score shown
int scoreDisplay = 0;

//score from most recent note
int nextScore;

//combo
int combo = 1;
// ~~scoring stuff~~

//1 = startscreen 2 = gameplaying 3 = endscreen
int gameStage = 1;

//duration of game in frames
float gameLength = 3600;
//timer frame
float timer = 0; 

//actual timer for whole game
float actualTimer = 0;

void draw() {
  if (gameStage  == 1) {
    startScreen();
  } else if (gameStage  == 2) {
    game();
  } else if (gameStage  == 3) {
    endGame();
  }
}

void keyPressed() {
  //note hit key (basically a click)
  if ( key == 'z' || key == 'x') {

    //cursor gets bigger to show cursor was pressed
    cursorDiameter = 55; 

    //noteCheck
    noteCheck("press");
  } 

  if ( key == 'p') {
    startScreen();
    gameStage = 1;
  }

  if (key == ' ') {
    startGame(char(difficulty));
    gameStage = 2;
  }

  if (gameStage == 1) {
    if (key == '1' || key == '2' || key == '3' ||key == '4') {
      startGame(key);
      gameStage = 2;
    }
  }
}

void mousePressed() {
  //note hit key (basically a click)
  if ( mouseButton == LEFT || mouseButton == RIGHT) {

    //cursor gets bigger to show cursor was pressed
    cursorDiameter = 55; 

    //note check
    noteCheck("press");
  }
}


void keyReleased() {
  //cursor goes back to normal when not held
  if (key == 'z' || key == 'x') {
    cursorDiameter = 40;

    //note check
    noteCheck("release");
  }
}

void mouseReleased() {
  //cursor goes back to normal when not held
  if ( mouseButton == LEFT || mouseButton == RIGHT) {
    cursorDiameter = 40;

    //note check
    noteCheck("release");
  }
}

//get the angle of a line given start and end points
float angleOf(float startX, float startY, float endX, float endY) {

  //using the angle of function in vectors
  PVector initialArm, terminalArm; 

  //initial arm is the x axis and the terminal arm is the actual angle
  initialArm = new PVector(100, 0); 
  terminalArm = new PVector(endX - startX, endY - startY); 

  if (startY > endY) {
    return 2*PI - PVector.angleBetween(initialArm, terminalArm);
  } else {
    return PVector.angleBetween(initialArm, terminalArm);
  }
}

void newCircleNote() {

  //next empty slot for a note
  int next = 666; 

  // reorganizes note order
  reOrganize(); 

  //finds the next empty slot for a note
  for (int l = noteArraySize - 1; l>=0; l--) {
    if (note[3][l] == 0) {
      next = l;
    }
  }

  //calculates previous two notes' angle
  if (noteCount >= 2) {
    noteAngle = angleOf(notePos1X, notePos1Y, notePos2X, notePos2Y);
  }

  if (next != 666) {

    println("new circle note");

    if (noteCount == 0 || notePos2X < 100 || notePos2X > width - 100 || notePos2Y < 100 || notePos2Y > height - 100) {
      //if its the first note it makes it random anywhere on the screen
      note[0][next] = random(noteDiameter, width - noteDiameter); 
      note[1][next] = random(noteDiameter, height - noteDiameter);

      //changes color scheme kind of
      colorChange+=10;

      //resets order
      noteOrder = 1;
    } else if (noteCount == 1) {
      note[0][next] = random(notePos2X - boundDistance/2, notePos2X + boundDistance/2); 
      note[1][next] = random(notePos2Y - boundDistance/2, notePos2Y + boundDistance/2);
    } else {
      //placed the note in the bounds
      do {
        note[0][next] = random(notePos2X - boundDistance/2, notePos2X + boundDistance/2); 
        note[1][next] = random(notePos2Y - boundDistance/2, notePos2Y + boundDistance/2);
      } while (!(angleOf(notePos2X, notePos2Y, note[0][next], note[1][next]) 
        >= noteAngle - boundAngle/2
        || angleOf(notePos2X, notePos2Y, note[0][next], note[1][next]) 
        <= noteAngle + boundAngle/2));
    }

    //"truncates" the coordinates if they go to far near the edge of the screen

    //left
    if (note[0][next] < 40 + noteDiameter/2) {
      note[0][next] = 40 + noteDiameter/2;
    }
    //top
    if (note[1][next] < 40 + noteDiameter/2) {
      note[1][next] = 40 + noteDiameter/2;
    }
    //right
    if (note[0][next] > width - 40 - noteDiameter/2) {
      note[0][next] = width - 40 - noteDiameter/2;
    }
    //bottom
    if (note[1][next] > height - 40 - noteDiameter/2) {
      note[1][next] = height - 40 - noteDiameter/2;
    }



    //for testing thingszz
    //  note[0][next] = random(noteDiameter, width - noteDiameter); 
    // note[1][next] = random(noteDiameter, height - noteDiameter);

    note[2][next] = noteLife; 
    note[3][next] = 1; 
    note[4][next] = ((noteCount + colorChange) * 10) % 359;
    note[10][next] = 0;
    note[13][next] = noteOrder;
    //most recent duration
    lastTime = note[10][next];

    //find 2 most recent notes' coordinates
    if (noteCount == 0) {
      notePos2X = note[0][next]; 
      notePos2Y = note[1][next];
    } else if (noteCount >= 1) {
      notePos1X = notePos2X; 
      notePos1Y = notePos2Y; 

      notePos2X = note[0][next]; 
      notePos2Y = note[1][next];
    }

    //gets the last note kind. In this case it's a circle
    lastNoteType = 1;

    //note count++
    noteCount++;

    //note order++
    noteOrder++;
  }
}

//circle note 
void circleNote(int place) {

  //font
  textFont(goodFont); 


  colorMode(HSB, 359, 99, 99); 

  //circle
  if (note[3][place] == 1) {
    if (note[2][place] > noteLife - fadeInTime) {
      fill(note[4][place], 99, 99, 255 * (noteLife - note[2][place])/fadeInTime); 
      stroke(0, 0, 99, 255 * (noteLife - note[2][place])/fadeInTime);
    } else {
      fill(note[4][place], 99, 99); 
      stroke(0, 0, 99);
    }
  } else {
    noStroke(); 
    fill(note[4][place], 99, 99, 255 * (fadeTime + note[2][place])/fadeTime);
  }
  strokeWeight(6);
  ellipse(note[0][place], note[1][place], noteDiameter, noteDiameter); 

  //closing circle
  noFill(); 
  strokeWeight(6); 
  stroke(note[4][place], 99, 99); 

  //the else is a for a very short time where the approaching circle 
  //will remain on the note giving a small chance to still hit it

  if (note[2][place] > noteLastChance) {     
    ellipse(note[0][place], note[1][place], 2*noteDiameter*((note[2][place] - noteLastChance)/noteLife) + noteDiameter, 
      2*noteDiameter*((note[2][place] - noteLastChance)/noteLife) + noteDiameter);
  } else if (note[2][place] > 0) {
    ellipse(note[0][place], note[1][place], noteDiameter, noteDiameter);
  } else {
    stroke(0, 0, 99, 255 * (fadeTime + note[2][place])/fadeTime); 
    ellipse(note[0][place], note[1][place], noteDiameter - note[2][place]/fadeTime*40, noteDiameter - note[2][place]/fadeTime*40);
  }

  colorMode(RGB, 255, 255, 255); 

  //text for the order they should be clicked in
  fill(0, 0, 0, 255 * (fadeTime + note[2][place])/fadeTime); 
  textSize(30); 
  textAlign(CENTER); 
  text(int(note[13][place]), note[0][place], note[1][place] + 15); 

  showScore(place);

  //useful editing tools
  //text(note[2][place], note[0][place], note[1][place] + 40);
}

//slider note
void newSliderNote() {                                                                                                            

  //next empty slot for a note
  int next = 666; 

  // reorganizes note order
  reOrganize(); 

  //finds the next empty slot for a note
  for (int l = noteArraySize - 1; l>=0; l--) {
    if (note[3][l] == 0) {
      next = l;
    }
  }

  //calculates previous two notes' angle
  if (noteCount >= 2) {
    noteAngle = angleOf(notePos1X, notePos1Y, notePos2X, notePos2Y);
  }

  if (next != 666) {

    println("new slider note");

    if (noteCount == 0 || notePos2X < 100 || notePos2X > width - 100 || notePos2Y < 100 || notePos2Y > height - 100) {
      //if its the first note it makes it random anywhere on the screen
      note[0][next] = random(noteDiameter, width - noteDiameter); 
      note[1][next] = random(noteDiameter, height - noteDiameter);

      //changes color scheme kind of
      colorChange+=10;

      //resets order
      noteOrder = 1;
    } else if (noteCount == 1) {
      note[0][next] = random(notePos2X - boundDistance/2, notePos2X + boundDistance/2); 
      note[1][next] = random(notePos2Y - boundDistance/2, notePos2Y + boundDistance/2);
    } else {
      //placed the note in the bounds
      do {
        note[0][next] = random(notePos2X - boundDistance/2, notePos2X + boundDistance/2); 
        note[1][next] = random(notePos2Y - boundDistance/2, notePos2Y + boundDistance/2);
      } while (!(angleOf(notePos2X, notePos2Y, note[0][next], note[1][next]) 
        >= noteAngle - boundAngle/2
        || angleOf(notePos2X, notePos2Y, note[0][next], note[1][next]) 
        <= noteAngle + boundAngle/2));
    }

    //"truncates" the coordinates if they go to far near the edge of the screen

    //left
    if (note[0][next] < 40 + noteDiameter/2) {
      note[0][next] = 40 + noteDiameter/2;
    }
    //top
    if (note[1][next] < 40 + noteDiameter/2) {
      note[1][next] = 40 + noteDiameter/2;
    }
    //right
    if (note[0][next] > width - 40 - noteDiameter/2) {
      note[0][next] = width - 40 - noteDiameter/2;
    }
    //bottom
    if (note[1][next] > height - 40 - noteDiameter/2) {
      note[1][next] = height - 40 - noteDiameter/2;
    }

    //note sliding duration
    if (difficulty == 1) {
      note[10][next] = frequency/(pow(2, floor(random(0, 2))));
    } else {
      note[10][next] = frequency/(pow(2, floor(random(0, 3))));
    }

    note[2][next] = note[10][next] + noteLife; 
    note[3][next] = 2; 
    note[4][next] = ((noteCount + colorChange) * 10) % 359;
    note[5][next] = 0; 

    //end of the slider
    do {
      note[6][next] = random(note[0][next] - speed*note[10][next]/60 - speedVariance/2, note[0][next] + speed*note[10][next]/60 + speedVariance/2); 
      note[7][next] = random(note[1][next] - speed*note[10][next]/60 - speedVariance/2, note[1][next] + speed*note[10][next]/60 + speedVariance/2);
    } while (note[6][next] < 40 + noteDiameter/2 || note[6][next] > width -  40 - noteDiameter/2
      || note[7][next] < 40 + noteDiameter/2 || note[7][next] > height -  40 - noteDiameter/2
      || dist(note[0][next], note[1][next], note[6][next], note[7][next]) < speed*note[10][next]/60 - speedVariance/2);

    note[8][next] = note[0][next];
    note[9][next] = note[1][next];
    note[13][next] = noteOrder;

    //most recent duration
    lastTime = note[10][next];

    //finds 2 most recent notes' coordinates
    notePos1X = note[0][next]; 
    notePos1Y = note[1][next];
    notePos2X = note[6][next]; 
    notePos2Y = note[7][next];

    //gets the last note kind. In this case it's a circle
    lastNoteType = 2;

    //note count++
    noteCount++;

    //note order++
    noteOrder++;
  }
}

//circle note 
void sliderNote(int place) {
  //slider note check for score

  //font
  textFont(goodFont); 

  stroke(255);

  colorMode(HSB, 359, 99, 99); 

  //slider note fade in
  if (note[3][place] == 2) {
    if (note[2][place] > noteLife + note[10][place] - fadeInTime) {
      //white outline
      strokeWeight(106);
      stroke(0, 0, 99, 255 * (noteLife + note[10][place] - note[2][place])/fadeInTime);
      line(note[8][place], note[9][place], note[6][place], note[7][place]);

      //inside slider fill
      strokeWeight(94);
      stroke(note[4][place], 60, 99, 255 * (noteLife + note[10][place] - note[2][place])/fadeInTime);
      line(note[8][place], note[9][place], note[6][place], note[7][place]);

      //fill for the circles
      fill(note[4][place], 99, 99, 255 * (noteLife + note[10][place] - note[2][place])/fadeInTime); 
      stroke(0, 0, 99, 255 * (noteLife + note[10][place] - note[2][place])/fadeInTime);
      strokeWeight(6);

      //start and end circles
      ellipse(note[8][place], note[9][place], noteDiameter, noteDiameter);
      ellipse(note[6][place], note[7][place], noteDiameter, noteDiameter);
    } else {
      //white outline
      strokeWeight(106);
      stroke(0, 0, 99, 255);
      line(note[8][place], note[9][place], note[6][place], note[7][place]);

      //inside slider fill
      strokeWeight(94);
      stroke(note[4][place], 60, 99, 255);
      line(note[8][place], note[9][place], note[6][place], note[7][place]);

      //fill for the circles
      fill(note[4][place], 99, 99); 
      stroke(0, 0, 99);
      strokeWeight(6);

      //start and end circles
      ellipse(note[8][place], note[9][place], noteDiameter, noteDiameter);
      ellipse(note[6][place], note[7][place], noteDiameter, noteDiameter);
    }
  } else {
    //white outline
    strokeWeight(106);
    stroke(0, 0, 99, 255 * (fadeTime + note[2][place])/fadeTime);
    line(note[8][place], note[9][place], note[6][place], note[7][place]);

    //inside slider fill
    strokeWeight(94);
    stroke(note[4][place], 60, 99, 255 * (fadeTime + note[2][place])/fadeTime);
    line(note[8][place], note[9][place], note[6][place], note[7][place]);

    //start and end circles
    fill(note[4][place], 99, 99, 255 * (fadeTime + note[2][place])/fadeTime);
    stroke(0, 0, 99, 255 * (fadeTime + note[2][place])/fadeTime);
    strokeWeight(6);
    noStroke();

    ellipse(note[8][place], note[9][place], noteDiameter, noteDiameter);
    ellipse(note[6][place], note[7][place], noteDiameter, noteDiameter);

    //fill for the circles 
    fill(note[4][place], 99, 99, 255 * (fadeTime + note[2][place])/fadeTime);
  }

  if (note[2][place] < note[10][place] && note[2][place] >= 0) {
    //ellipse moves in a line towards destination 
    note[0][place] += 1/note[10][place]*(note[6][place] - note[8][place]);
    note[1][place] += 1/note[10][place]*(note[7][place] - note[9][place]);
  }

  //note
  ellipse(note[0][place], note[1][place], noteDiameter, noteDiameter);

  //closing circle
  noFill(); 
  strokeWeight(6); 
  stroke(note[4][place], 99, 99); 

  //closing circle
  if (note[2][place] > note[10][place]) {     
    ellipse(note[0][place], note[1][place], 2*noteDiameter*((note[2][place] - note[10][place])/noteLife) + noteDiameter, 
      2*noteDiameter*((note[2][place] - note[10][place])/noteLife) + noteDiameter);
  } else if (note[2][place] > note[10][place]) {
    ellipse(note[0][place], note[1][place], noteDiameter, noteDiameter);
  } else if (note[2][place] > 0) {
    stroke(0, 0, 99, 255);
    ellipse(note[0][place], note[1][place], noteDiameter, noteDiameter);
  } else {
    stroke(0, 0, 99, 255 * (fadeTime + note[2][place])/fadeTime); 
    ellipse(note[6][place], note[7][place], noteDiameter - note[2][place]/fadeTime*40, noteDiameter - note[2][place]/fadeTime*40);
    ellipse(note[8][place], note[9][place], noteDiameter - note[2][place]/fadeTime*40, noteDiameter - note[2][place]/fadeTime*40);
  }

  colorMode(RGB, 255, 255, 255); 

  //text for the order they should be clicked in
  fill(0, 0, 0, 255 * (fadeTime + note[2][place])/fadeTime); 
  textSize(30); 
  textAlign(CENTER); 
  text(int(note[13][place]), note[0][place], note[1][place] + 15); 

  colorMode(HSB, 359, 99, 99);

  //timer for slider note score
  if (place == firstActive()) {
    if (firstSliderHeld 
      && dist(note[0][place], note[1][place], mouseX, mouseY) < sliderCircleSize/2
      && note[2][place] <= note[10][place]) {
      //add on the slider timer
      note[5][place]++;

      //bounds increase
      sliderCircleSize = noteDiameter*2;

      //bound for when slider is being slood
      noFill();
      strokeWeight(6);
      stroke(note[4][place], 99, 99); 
      ellipse(note[0][place], note[1][place], sliderCircleSize, sliderCircleSize);
    } else {
      //bounds go back to normal note size
      sliderCircleSize = noteDiameter;
    }
  }

  colorMode(RGB, 255, 255, 255);

  //shows the score
  showScore(place);
}

//checks what note the mouse if over and what score it gets
void noteCheck(String action) {

  //to stop the for loop after a note is found
  boolean notDone = true; 

  for (int j = 0; j < noteArraySize; j++) {
    if (notDone) {
      if (note[3][j] == 1 && action == "press") {
        if (dist(note[0][j], note[1][j], mouseX, mouseY) < noteDiameter/2 && note[3][j] > 0) {

          // for circle notes
          //notes only if note is the first active note 
          if (j == firstActive()) {

            //assigns the score given based on the time the note was hit at
            for (int r = 0; r < 8; r++) {

              //if it was hit before the approach circle hits the note
              if (r <= 3) {
                if (note[2][j] <= noteHitIntervaul[r] * (noteLife - noteLastChance) +noteLastChance &&
                  note[2][j] > noteHitIntervaul[r+1] * (noteLife - noteLastChance) + noteLastChance) {
                  nextScore = noteHitScore[r]; 

                  println("early" + "  " + nextScore);
                }
              } else {
                //if it hits after the approach circle hits the circle
                if (note[2][j] <= noteHitIntervaul[r+1] * noteLastChance &&
                  note[2][j] > noteHitIntervaul[r+2] * noteLastChance) {
                  nextScore = noteHitScore[r]; 
                  println("late" + "  " + nextScore);
                } else if (note[2][j] == 0) {
                  //for when the time is exactly at the lastchance time
                  nextScore = 0; 
                  println("zero" + "  " + nextScore);
                }
              }
            }
          } else {
            nextScore = 0; 
            println("wrong order" + "  " + nextScore);
          }
          //stops the for loop when a score is found
          notDone = false; 

          //turns off the note
          note[3][j] = -note[3][j];
          note[2][j] = 0; 

          //assigns the score
          note[5][j] = nextScore;
        }
      } else if (note[3][j] == 2) {
        if (dist(note[0][j], note[1][j], mouseX, mouseY) < noteDiameter/2 && note[3][j] > 0) {
          //before circle starts moving
          if (j == firstActive()) {
            if (note[2][j] > note[10][j] && note[5][j] >= 0 && action == "press") {
              //cap for score penalty
              if ((note[2][j] - note[10][j])/2 >= note[10][j] * noteHitIntervaul[1]) {
                note[5][j] -= note[10][j] * noteHitIntervaul[1] - 1;
              } else {
                note[5][j] -= (note[2][j] - note[10][j])/2;
              }
              firstSliderHeld = true;
            } else {
              //press to begin timer
              if (action == "press") {
                firstSliderHeld = true;
              } else if (action == "release") {
                //release to stop timer
                firstSliderHeld = false;
              }
            }
          } else {
            nextScore = 0; 
            println("wrong order" + "  " + nextScore);

            //turns off the note
            note[3][j] = -note[3][j];
            note[2][j] = 0;
          }
          //stops the for loop when a score is found
          notDone = false;
        } else {
          firstSliderHeld = false;
        }
      }
    }
  }
}

//gets rid of empty note slots
void reOrganize() {

  //temporary position counter
  int position = 0; 

  for (int n = 0; n<noteArraySize; n++) {
    if (note[3][n] != 0) {
      //moves that note's information to the first empty position
      for (int x = 0; x<14; x++) {  
        note[x][position] = note[x][n];
      }
      if (n != position) {
        note[3][n] = 0;
      }

      //since one position got filled position goes up by one
      position++;
    }
  }
}

//finds the first active note slot
int firstActive () {
  //first active
  int first = 0; 
  for (int t = noteArraySize - 1; t>=0; t--) {
    if (note[3][t] > 0) {
      first = t;
    }
  }

  return first;
}

//draw a line in polar form
void polarLine(int x, int y, float angle, float dist) {
  line(x, y, x+cos(angle)*dist, y-sin(angle)*dist);
}


//resets game
void reset () {
  //sets every note to its off state
  for (int m = 0; m<noteArraySize; m++) {
    note[3][m] = 0;
  }

  noteCount = 0; 
  score = 0; 
  scoreDisplay = 0;
  combo = 0;
  actualTimer = 0;
}

void showScore(int place) {

  //score decoder
  if (note[2][place] == -1) {

    //circle note
    if (note[3][place] == -1) {
      score+= combo * note[5][place];

      //combo
      if (note[5][place] == 0) {
        combo = 1;
      } else {
        combo++;
      }
    }

    //slider note
    if (note[3][place] == -2) {

      //stops holding note
      firstSliderHeld = false;

      //bound back to normal
      //   sliderCircleSize = noteDiameter;

      if (note[5][place] <= 0) {
        note[5][place] = 0;
        score += note[5][place];
      } else {
        //finds which score intervaul the note is in
        //to stop repeating
        boolean notDone = true;
        for (int c = 0; c < 4; c++) {
          if (notDone) {
            if (note[5][place]/note[10][place] > 1 - noteHitIntervaul[c]
              && note[5][place]/note[10][place] <= 1 - noteHitIntervaul[c + 1]) {
              note[5][place] = noteHitScore[c];
              score += combo * note[5][place];
              notDone = false;
            }
          }
        }
      }
      //combo
      if (note[5][place] == 0) {
        combo = 1;
      } else {
        combo++;
      }
    }
  }

  //fading score
  textAlign(CENTER); 


  if (note[2][place] < 0) {

    //color
    color fill; 

    noStroke(); 

    //color depending on score
    if (note[5][place] == noteHitScore[0]) {
      fill = #FF0000;
    } else if (note[5][place] == noteHitScore[1]) {
      fill = #FFEA00;
    } else if (note[5][place] == noteHitScore[2]) {
      fill = #00FF30;
    } else {
      fill = #00D7FF;
    }

    //text size fade in timing
    if (note[2][place] > -scoreFadeTime/10) {
      textSize(scoreText + 20 * (-10*note[2][place]/scoreFadeTime - 1));
    } else {
      //text increases in size
      textSize(scoreText + 5 * (1 - (10*(scoreFadeTime + note[2][place])/scoreFadeTime/9)));
    }

    //fade timing
    if (note[2][place] > -scoreFadeTime/4) {
      //fade in
      fill(fill, 255 * -note[2][place]/fadeTime);
    } else if (note[2][place] > -scoreFadeTime/2) {
      //opaque
      fill(fill, 255);
    } else {
      //fade out
      fill(fill, 255 * 2*(scoreFadeTime + note[2][place])/scoreFadeTime);
    }

    if (note[5][place] == noteHitScore[0]) {
      pushMatrix();
      translate(note[0][place], note[1][place]);
      rotate(PI/4);
      rect(-28, -7, 56, 14);
      rect(-7, -28, 14, 56);
      popMatrix();
    } else { 
      //stacks them to create outlining effect for white text
      for (int u = -2; u < 3; u++) {

        text(int(note[5][place]), note[0][place] + u, note[1][place] + 20); 
        text(int(note[5][place]), note[0][place], note[1][place] + 20 + u);
      }
    }

    //fade timing
    if (note[2][place] > -scoreFadeTime/4) {
      //fade in
      fill(255, 255, 255, 255 * -note[2][place]/fadeTime);
    } else if (note[2][place] > -scoreFadeTime/2) {
      //opaque
      fill(255, 255, 255, 255);
    } else {
      //fade out
      fill(255, 255, 255, 255 * 2*(scoreFadeTime + note[2][place])/scoreFadeTime);
    }

    //inside white text
    if (note[5][place] == noteHitScore[0]) {
      pushMatrix();
      translate(note[0][place], note[1][place]);
      rotate(PI/4);
      rect(-25, -4, 50, 8);
      rect(-4, -25, 8, 50);
      popMatrix();
    } else {
      text(int(note[5][place]), note[0][place], note[1][place] + 20);
    }
  }
}

//start screen
void startScreen() {
  textFont(goodFont);
  background(0);
  textSize(200);
  textAlign(CENTER);
  text("nso", width/2, 200);

  textSize(70);
  textAlign(CENTER);
  text("Ethan", width/2, 300);

  textSize(40);
  textAlign(CENTER);
  text("Use mouse buttons, 'z' or 'x' to hit the notes\nat the right time as the ring closes in ", width/2, 400);

  textSize(40);
  textAlign(CENTER);
  text("Hold and follow the slider notes", width/2, 550);

  textSize(40);
  textAlign(CENTER);
  text("Choose a difficulty to start!", width/2, 650);
  text("'1' : easy   '2' : normie   '3' : problematic   '4' : de wae", width/2, 725);
}

//sets difficulty
void startGame(char difficile) {

  actualTimer = 0;
  reset();

  difficulty = int(difficile);

  //sets variables for difficulty
  if (difficulty == '1') {
    frequency  = 60; 
    noteLife = 110;
    boundDistance = 300;
    boundAngle = PI/4;
    speed = 300;
    speedVariance = 20;
    float[] setAccuracy = {1, 0.7, 0.5, 0.25, 0, 1, 0.5, 0.4, 0.1, 0};
    for (int i = 0; i < 10; i++) {
      noteHitIntervaul[i] = setAccuracy[i];
    }
  } else if (difficulty == '2') {
    frequency  = 60; 
    noteLife = 80;
    boundDistance = 350;
    boundAngle = PI/4;
    speed = 400;
    speedVariance = 80;
    float[] setAccuracy = {1, 0.6, 0.4, 0.2, 0, 1, 0.5, 0.3, 0.2, 0};
    for (int i = 0; i < 10; i++) {
      noteHitIntervaul[i] = setAccuracy[i];
    }
  } else if (difficulty == '3') {
    frequency  = 40; 
    noteLife = 60;
    boundDistance = 400;
    boundAngle = PI/3;
    speed = 550;
    speedVariance = 150;
    float[] setAccuracy = {1, 0.5, 0.3, 0.15, 0, 1, 0.7, 0.5, 0.2, 0};
    for (int i = 0; i < 10; i++) {
      noteHitIntervaul[i] = setAccuracy[i];
    }
  } else if (difficulty == '4') {
    frequency  = 20; 
    noteLife = 45;
    boundDistance = 600;
    boundAngle = PI;
    speed = 700;
    speedVariance = 200;
    float[] setAccuracy = {1, 0.4, 0.3, 0.1, 0, 1, 0.7, 0.5, 0.3, 0};
    for (int i = 0; i < 10; i++) {
      noteHitIntervaul[i] = setAccuracy[i];
    }
  }
}

//end game screen
void endGame() {
  textFont(goodFont);
  background(0);
  textSize(100);
  textAlign(CENTER);
  text("Time's up!", width/2, 200);
  text("Your Score:", width/2, 300);
  text(score, width/2, 400);
  text("press space to retry\npress p to change difficulty", width/2, 600);
}

//actual game
void game() {

  background(background); 

  textFont(goodFont);

  noCursor();

  //counts down each note life/time
  for (int  q = 0; q<noteArraySize; q++) {
    if (note[3][q] != 0) {
      note[2][q]--;
      if (note[2][q] == 0) {
        //changes int fade time
        note[3][q] = -note[3][q];
      }
      if (note[2][q] == -scoreFadeTime) {
        note[3][q] = 0;
      }
    }
  }

  //reorganize to be tidy
  reOrganize(); 

  //note generator
  for (int i = noteArraySize - 1; i >= 0; i--) {
    //if it is a hit circle type of note
    if (abs(note[3][i]) == 1) {
      circleNote(i);
    }

    //slider note
    if (abs(note[3][i]) == 2) {
      sliderNote(i);
    }
  }

  //new note
  if (timer >= nextFrequency + lastTime ) {
    if (random(0, 1) < 0.5) {
      newCircleNote();
    } else {
      newSliderNote();
    }
    //timer reset
    timer = 0;
    //new random next frequency
    nextFrequency = frequency/(pow(2, floor(random(0, 3))));
  }

  //useful editing tools
  /*
  //spawn boundary on most recent note
   strokeWeight(3);
   noFill();
   stroke(#FFAE17);
   ellipse(notePos2X, notePos2Y, boundDistance, boundDistance);
   
   //circle around second most recent note
   stroke(0, 0, 255);
   ellipse(notePos1X, notePos1Y, noteDiameter + 30, noteDiameter + 30);
   
   //line connecting previous two mentioned notes (to show the angle);
   stroke(0, 255, 0);
   line(notePos1X, notePos1Y, notePos2X, notePos2Y);
   rect(notePos2X - 10, notePos2Y - 10, 20, 20);
   
   //angle indicator (to check if the angleOf function is working)
   textAlign(LEFT);
   textSize(40);
   fill(255);
   text(degrees(angleOf(width/2, height/2, mouseX, mouseY)), width - 150, 50);
   
   stroke(0, 255, 0);
   line(width/2, height/2, mouseX, mouseY);
   
   //bpm displayer
   if ((frameCount - noteLife) % frequency  == 0) {
   background(0, 0, 255);
   }
   
   for (int d = 0; d<noteArraySize; d++) {
   //shows information
   if (note[3][d] > 0) {
   for (int b = 0; b < 6; b++) {
   fill(255);
   textSize(20);
   text(note[b][d], note[0][d], note[1][d] - b*20 - noteDiameter/2 - 10);
   }
   }
   }
   
   */

  //score
  colorMode(RGB);
  textAlign(LEFT); 
  fill(255); 
  textSize(60); 
  if (scoreDisplay < score) {
    if (score - scoreDisplay <= 150) {
      scoreDisplay+=5;
    } else if (score - scoreDisplay <= 300) {
      scoreDisplay+=10;
    } else if (score - scoreDisplay <= 900) {
      scoreDisplay += 25;
    } else {
      scoreDisplay += 50;
    }
  }
  text(scoreDisplay, 10, 50); 

  //instructions
  textSize(30);
  text("'p' to return to main menu", width - 400, 50); 

  //time
  textSize(30);
  text("time left : " + floor((gameLength - actualTimer)/60), width - 210, 90); 
  
  //combo
  textSize(60);
  text("x" + combo, 20, height - 25);

  //mouse trail coordinates
  for (int v = cursorArraySize - 1; v > 0; v--) {
    //everything else gets pushed back
    cursor[0][v] = cursor[0][v-1];
    cursor[1][v] = cursor[1][v-1];
    cursor[2][v] = cursor[2][v-1];

    //cursor timer
    cursor[2][v]-= 200/cursorArraySize;
  }

  //leading coordinate
  cursor[0][0] = mouseX;
  cursor[1][0] = mouseY;
  cursor[2][0] = 200;


  //cursor trail
  for (int w = 0; w < cursorArraySize - 1; w++) {
    stroke(255, 255, 255, cursor[2][w]);
    line(cursor[0][w], cursor[1][w], cursor[0][w + 1], cursor[1][w + 1]);
  }

  //cursor
  noFill(); 
  strokeWeight(4); 
  stroke(#AA00AA); 
  ellipse(mouseX, mouseY, cursorDiameter, cursorDiameter); 

  fill(255); 
  noStroke(); 
  ellipse(mouseX, mouseY, 7, 7); 

  //timer goes up by 1
  timer++;

  if (actualTimer < gameLength) {
    actualTimer++;
  } else {
    gameStage = 3;
    actualTimer = 0;
  }
}