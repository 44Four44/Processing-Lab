void settings() {
  size(600, 700);
}

import processing.pdf.*;

//for the text font
PFont textFont;

//reddish color
color themeColor1 = #FFFFFF;
color themeColor2 = #000000;
color themeColor3 = #000000;

//to store the 25 numbers for each card
String cardsRNG [][] = new String [5][25];

//number of pages of cards
int numberOfFiles = 0;

//the base
int base = 10;

//textSize depends on base
int textSize = 30;

//toggles the free space
boolean freeSpace = false;

//oggles ink friendly mode
boolean inkSafe = false;

//final pdf
PGraphicsPDF pdf;

void setup() {
  size(100, 100);

  //fills the cards with base 10 when the program is first run
  RNG(10);

  //font
  textFont = createFont("YuppyTC-Regular-48.vlw", 50);

  //second window 
  String[] sketch = {"YourSketchNameHere"};
  HELP app = new HELP();
  PApplet.runSketch(sketch, app);

  //render
  pdf = (PGraphicsPDF) createGraphics(width, height, PDF, "graphics.pdf");
}

void draw() {
  //changes colors depending on ink mode
  if (inkSafe) {
    themeColor1 = #FFFFFF;
    themeColor2 = #000000;
    themeColor3 = #000000;
  } else {
    themeColor1 = #F7393D;
    themeColor2 = #F7393D;
    themeColor3 = #FFFFFF;
  }

  background(themeColor1);

  //outside rectangle borders
  noFill();
  stroke(themeColor3);
  if (inkSafe) {
    strokeWeight(1);
  } else {
    strokeWeight(5);
  }

  //card #1
  rect(10, 10, 280, 330, 30);
  //card #2
  rect(310, 10, 280, 330, 30);
  ///card #3
  rect(10, 360, 280, 330, 30);
  //card #4
  rect(310, 360, 280, 330, 30);

  //changes the textSize based on the base
  if (base == 10) {
    textSize = 30;
  }
  if (base == 2) {
    textSize = 11;
  }
  if (base == 8) {
    textSize = 23;
  }
  if (base == 16) {
    textSize = 30;
  }

  //grid squares
  //first card
  for (int i = 0; i<5; i++) {
    for (int j = 0; j<5; j++) {
      //square grid
      if (inkSafe) {
        strokeWeight(1);
      } else {
        strokeWeight(6);
      }

      stroke(themeColor2);
      fill(255);
      rect(i*50+25, j*50+75, 50, 50, 15);

      //number in squares
      fill(0);
      textSize(textSize);
      textAlign(CENTER);
      text(String.valueOf(cardsRNG[1][5*i+j]), i*50+50, j*50+110);
    }
  }

  //second card
  for (int i = 0; i<5; i++) {
    for (int j = 0; j<5; j++) {
      //square grid
      if (inkSafe) {
        strokeWeight(1);
      } else {
        strokeWeight(6);
      }

      stroke(themeColor2);
      fill(255);
      rect(i*50+325, j*50+75, 50, 50, 15);

      //number in squares
      fill(0);
      textSize(textSize);
      textAlign(CENTER);
      text(String.valueOf(cardsRNG[2][5*i+j]), i*50+350, j*50+110);
    }
  }

  //third card
  for (int i = 0; i<5; i++) {
    for (int j = 0; j<5; j++) {
      //square grid
      if (inkSafe) {
        strokeWeight(1);
      } else {
        strokeWeight(6);
      }

      stroke(themeColor2);
      fill(255);
      rect(i*50+25, j*50+425, 50, 50, 15);

      //number in squares
      fill(0);
      textSize(textSize);
      textAlign(CENTER);
      text(String.valueOf(cardsRNG[3][5*i+j]), i*50+50, j*50+460);
    }
  }

  //fourth card
  for (int i = 0; i<5; i++) {
    for (int j = 0; j<5; j++) {
      //square grid
      if (inkSafe) {
        strokeWeight(1);
      } else {
        strokeWeight(6);
      }

      stroke(themeColor2);
      fill(255);
      rect(i*50+325, j*50+425, 50, 50, 15);

      //number in squares
      fill(0);
      textSize(textSize);
      textAlign(CENTER);
      text(String.valueOf(cardsRNG[4][5*i+j]), i*50+350, j*50+460);
    }
  }

  //free spaces
  //first card
  if (freeSpace) {
    fill(255);
    stroke(themeColor2);
    //white square to go over numbers
    rect(125, 175, 50, 50, 15);
    rect(125, 525, 50, 50, 15);
    rect(425, 175, 50, 50, 15);
    rect(425, 525, 50, 50, 15);

    //text
    textAlign(CENTER);
    textSize(18);
    fill(0);
    text("FREE", 150, 207);
    text("FREE", 150, 557);
    text("FREE", 450, 207);
    text("FREE", 450, 557);
  }

  //Bingo title circles
  fill(255);
  stroke(themeColor2);

  //first card 
  for (int k = 4; k>-1; k--) {
    ellipse(55+48*k, 35, 60, 60);
  }

  //second card 
  for (int k = 4; k>-1; k--) {
    ellipse(355+48*k, 35, 60, 60);
  }


  //third card 
  for (int k = 4; k>-1; k--) {
    ellipse(55+48*k, 385, 60, 60);
  }

  //fourth card 
  for (int k = 4; k>-1; k--) {
    ellipse(355+48*k, 385, 60, 60);
  }

  //card title text
  if (inkSafe) {
    textFont(textFont, 50);
  } else {
    textFont(textFont, 50);
  }
  fill(themeColor2);
  textAlign(LEFT);

  //first card 
  text("B  I N G O", 40, 53);

  //second card 
  text("B  I N G O", 340, 53);

  //third card 
  text("B  I N G O", 40, 403);

  //fourth card 
  text("B  I N G O", 340, 403);

  //text subscripted after the word 'BINGO' to indicate the base
  fill(themeColor3);
  textAlign(LEFT);
  textSize(17);

  text(base, 265, 70);
  text(base, 565, 70);
  text(base, 265, 420);
  text(base, 565, 420);


  //for the covering the cards
  if (card2) {
    fill(themeColor1);
    noStroke();
    rect(300, 0, 300, 350);
  }
  if (card3) {
    fill(themeColor1);
    noStroke();
    rect(0, 350, 300, 350);
  }
  if (card4) {
    fill(themeColor1);
    noStroke();
    rect(300, 350, 300, 350);
  }
}
boolean card2 = true;
boolean card3 = true;
boolean card4 = true;
void keyPressed() {

  //card number and window size changes when numbers 1~7 are pressed
  if (key == '1') { 
    card2 = true;
    card3 = true;
    card4 = true;
  }

  if (key == '2') {
    card2 = false;
    card3 = true;
    card4 = true;
  }

  if (key == '3') {
    card2 = false;
    card3 = false;
    card4 = true;
  }

  if (key == '4') {
    card2 = false;
    card3 = false;
    card4 = false;
  }

  //free space
  if (key == 'f') {
    freeSpace = !freeSpace;
  }

  //ink friendly mode
  if (key == 'i') {
    inkSafe= !inkSafe;
  }

  //changes the base 
  if (key == 'q') {
    if (base != 2) {
      RNG(2);
    }
    base = 2;
  }
  if (key == 'w') {
    if (base != 8) {
      RNG(8);
    }
    base = 8;
  }
  if (key == 'e') {
    if (base != 10) {
      RNG(10);
    }
    base = 10;
  }
  if (key == 'r') {
    if (base != 16) {
      RNG(16);
    }
    base = 16;
  }

  //generates new random cards
  if (key == ' ') {
    RNG(base);
  }

  //saves the bingo card(s) to a pdf
  if (key == ENTER) {
    toPDF();
  }
}

void RNG (int base) {
  for (int i = 1; i<5; i++) {
    for (int j = 0; j<25; j++) {
      do {
        //ranges of randomization change bassed on the base
        if (base == 10) {
          cardsRNG[i][j] = convertToBase(str(int(random(15*floor(j/5)+1, 15*floor(j/5)+16))), base);
        }
        if (base == 2) {
          cardsRNG[i][j] = convertToBase(str(int(random(10*floor(j/5)+1, 10*floor(j/5)+11))), base);
        }
        if (base == 8) {
          cardsRNG[i][j] = convertToBase(str(int(random(30*floor(j/5)+1, 30*floor(j/5)+31))), base);
        }
        if (base == 16) {
          cardsRNG[i][j] = convertToBase(str(int(random(50*floor(j/5)+1, 50*floor(j/5)+51))), base);
        }
      } while (checkDuplicate(cardsRNG[i][j], i, j));
      //it will keep on ranodomizing an integer until it is different from all of the other integers on the card
    }
  }
}

//function to check if a number is already on the card
boolean checkDuplicate (String cardvalue, int cardNumber, int valueNumber) {

  //is true if there is at least one duplicate
  boolean repeat = false;

  //loop checks for duplicates in every other number in the 5x5 card 
  for (int l = 0; l<25; l++) {
    if (cardvalue.equals(cardsRNG[cardNumber][l])) {

      //it won't check if its itself
      if (l != valueNumber) {
        repeat = true;
      }
    }
  }
  return repeat;
}

//base converter
String convertToBase (String number, int base) {
  //if the base is decimal it won't change anything
  if (base == 10) {
    return number;
  } else if (base == 2) {
    return str(int(binary(int(number))));
  } else if (base == 8) {
    return cut(octal(number));
  } else if (base == 16) {
    return cut(hex(int(number)));
  } else {
    return "@@";
  }
}

//converts decimal to octal
String octal (String number) {
  return str(floor(int(number)/64)) + str(floor((int(number)%64)/8)) + str(((int(number))%64)%8);
}

//function to cut off the leading zeroes of a number
String cut (String number) {
  String newNumber = number;
  //if first character is 0, it will remove it
  while (newNumber.charAt(0) == '0') {
    newNumber = newNumber.substring(1);
  }
  return newNumber;
}


//function to convert screen to jpeg then collect all of them into a pdf file
void toPDF() {
  if (numberOfFiles<20) {
    //increases page count
    numberOfFiles++;
    println(numberOfFiles);
    //creates jpeg
    PImage partialSave = get(0, 0, width, height);

    //saves the picture
    partialSave.save("Separate pages/page ~ " + numberOfFiles + ".jpg");

    //records the pages into one pdf
    pdf = (PGraphicsPDF)beginRecord(PDF, "ALL_CARDS.pdf");

    //records each page
    for (int i = 1; i <= numberOfFiles; i++) {
      PImage cardjpeg = loadImage("Separate pages/page ~ " + i + ".jpg");

      image(cardjpeg, 0, 0);

      //to prevent blank last page besides the needed blank page
      if (i !=  numberOfFiles) {
        pdf.nextPage();
      }
    }
    endRecord();
  }
}

//second window
public class HELP extends PApplet {

  public void settings() {
    size(200, 400);
  }
  public void draw() {
    background(#F7393D);
    fill(0);
    textSize(35);
    //title
    text("CONTROLS", 7, 35);

    //controls
    textSize(20);
    textLeading(20);

    text("Keys 1~4 for # of\nBingo cards", 7, 70);

    text("'q' - binary\n'w' - octal\n'e' - decimal\n'r' - hexadecimal", 7, 120);

    text("SPACEBAR to \ngenerate new cards", 7, 215);

    text("'f ' - free space", 7, 275);

    text("'i ' - b/w mode", 7, 305);

    text("ENTER to save \ncard(s) to a pdf", 7, 345);

    text("Max 20 saves to pdf", 2, 395);
  }
}