void settings() {
  size(600, 600);
}

void setup() {
}

// x coordinate of graph
// every 30 pixels represents 1 unit, so a 300x300 quadrant is scaled to 10x10
float xCoordinate;

//fill color for input box
float fillColor1 = 200;

//fill color for reset box
float fillColor2 = 200;

//fill color for most things
float buttonFill = 200;

//fill color for boxes a, b, c,d and X
float boxAFill = 200;
float boxBFill = 200;
float boxCFill = 200;
float boxDFill = 200;
float boxXFill = 200;

//stroke color for buttons
float buttonStroke = 120;

//first movable point in the center
float midlineX = 300;
float midlineY = 300;

//second movable point on the crest and trough
float crestX = 300 + 15*PI;
float crestY = 270;

float midlineDiameter;
float crestlineDiameter;

//string inputs and float values of input boxes
String stringA = "1.00";
float floatA = 1;

String stringB = "1.00";
float floatB = 1;

String stringC = "0.00";
float floatC = 0;

String stringD = "0.00";
float floatD = 0;

String stringX = "0.00";
float floatX = 0;

//slider point
float sliderX = 0;
float sliderDiameter = 15;


void draw() {
  //amplitude 
  float a = (midlineY - crestY)/30;

  //horizontal stretch (period)
  float b = 15*PI/(crestX - midlineX);

  //phase shift
  float c = (300-midlineX)/30;

  //midline
  float d = (300-midlineY)/30;

  background(255);
  //y axis
  line(300, 0, 300, 10);
  line(300, 50, 300, 555);
  line(300, 595, 300, 600);

  //x axis
  line(0, 300, 600, 300);

  //vertical gridlines
  for (int i = 30; i<=570; i+=30) {
    stroke(150);
    strokeWeight(0.5);
    line(i, 0, i, 600);
  }

  //horizontal gridlines
  for (int j = 30; j<=570; j+=30) {
    stroke(150);
    strokeWeight(0.5);
    line(0, j, 600, j);

    // a lot of small lines joining the points on the graph
    // the xCoordinate must be first divided by 30
    // the function output of xCoordinate is multiplied by 30
    // y coordinates for lines are multiplied by -1
    // the +300 is to center it at origin (300, 300)
    // Sinusoidal function is transformed by a, b, c, and d
    for (xCoordinate = -300; xCoordinate < 301; xCoordinate+=5) {
      stroke(0);
      strokeWeight(2);
      line(xCoordinate+300, -30*a*sin(b*(xCoordinate/30+c))-30*d+300, xCoordinate+305, -30*a*sin(b*((xCoordinate+5)/30+c))+300-30*d);
    }

    midlineDiameter = 12;
    crestlineDiameter = 12;
    if ((mouseX>midlineX - midlineDiameter && mouseX<midlineX + midlineDiameter && mouseY>midlineY - midlineDiameter && mouseY<midlineY + midlineDiameter)
      &&!(mouseX>crestX - midlineDiameter && mouseX<crestX + midlineDiameter && mouseY>crestY - midlineDiameter && mouseY<crestY + midlineDiameter)) {
      midlineDiameter = 17;
    }
    if ((mouseX>crestX - midlineDiameter && mouseX<crestX + midlineDiameter && mouseY>crestY - midlineDiameter && mouseY<crestY + midlineDiameter)
      &&!(mouseX>midlineX - midlineDiameter && mouseX<midlineX + midlineDiameter && mouseY>midlineY - midlineDiameter && mouseY<midlineY + midlineDiameter)) {
      crestlineDiameter = 17;
    }

    //Movable points
    stroke(0);
    fill(100);
    strokeWeight(2);
    ellipse(midlineX, midlineY, midlineDiameter, midlineDiameter);

    fill(100);
    strokeWeight(2);
    ellipse(crestX, crestY, crestlineDiameter, crestlineDiameter);

    //equation on the top
    textAlign(LEFT);
    if (openBox) {
      fill(0);
      textSize(30);
      text("f(x)=a*sin(b*(x+c))+d", 220, 40);
    } else {
      fill(0);
      textSize(30);
      text("f(x)=a*sin(b*(x+c))+d", 145, 40);
    }
    //to deal with negative signs and 0 for the equation a tthe bottom
    String aCut; 
    String bCut;
    String cCut;
    String dCut;
    String bracketR;
    String bracketL;
    if (a==1) {
      aCut = "";
    } else {
      aCut = String.format("%.2f", a)+"*";
    }

    if (b==0.99999976) {
      bCut = "";
    } else {
      bCut = String.format("%.2f", b)+"*";
    }

    if (c<0) {
      cCut = String.format("%.2f", c);
      bracketR = "(";
      bracketL = ")";
    } else if (c==0) {
      cCut = "";
      bracketR = "";
      bracketL = "";
    } else {
      cCut = "+"+String.format("%.2f", c);
      bracketR = "(";
      bracketL = ")";
    }

    if (d<0) {
      dCut = String.format("%.2f", d);
    } else if (d==0) {
      dCut = "";
    } else {
      dCut = "+"+String.format("%.2f", d);
    }
    //equation on the bottom
    fill(0);
    textSize(30);
    textAlign(CENTER);
    text("f(x)=" + aCut + "sin(" + bCut + bracketR+ "x" + cCut + ")" + bracketL + dCut, 300, 585);

    // checks if user clicked on the menu box to open it
    if (openBox) {
      //vertical line that goes with the moving point
      stroke(150);
      strokeWeight(1.5);
      for (int k = 0; k<600; k+=30) {
        line(floatX*30+300, k, floatX*30+300, k+15);
      }
      strokeWeight(2);
      //sliding point on the graph
      fill(170);
      stroke(0);
      ellipse(floatX*30+300, -30*a*sin(b*(floatX+c))-30*d+300, 18, 18);

      fill(buttonFill);
      stroke(buttonStroke);
      rect(0, 0, 200, 250);

      //boxA
      textAlign(LEFT);
      textSize(30);
      fill(0);
      text("a=", 40, 30);

      fill(boxAFill);
      stroke(buttonStroke);
      rect(90, 5, 100, 25);

      //boxB
      fill(0);
      text("b=", 38, 60);

      fill(boxBFill);
      stroke(buttonStroke);
      rect(90, 35, 100, 25);

      //boxC
      fill(0);
      text("c=", 42, 90);

      fill(boxCFill);
      stroke(buttonStroke);
      rect(90, 65, 100, 25);

      //boxD
      fill(0);
      text("d=", 38, 120);

      fill(boxDFill);
      stroke(buttonStroke);
      rect(90, 95, 100, 25);

      //displayed values for a, b, c and d
      textSize(20);
      fill(0);
      text(stringA, 95, 25);

      textSize(20);
      fill(0);
      text(stringB, 95, 55);

      textSize(20);
      fill(0);
      text(stringC, 95, 85);

      textSize(20);
      fill(0);
      text(stringD, 95, 115);

      //slider x input box
      textSize(30);
      fill(0);
      text("x=", 38, 165);

      fill(boxXFill);
      stroke(buttonStroke);
      rect(90, 145, 100, 25);

      //slider x text
      textSize(20);
      fill(0);
      text(stringX, 95, 165);

      //slider line
      stroke(0);
      line(15, 185, 185, 185);
      line(15, 175, 15, 195);
      line(185, 175, 185, 195);

      //text for domain
      textSize(13);
      text("-10", 3, 210);
      text("10", 175, 210);

      //slider y text
      textSize(30);
      fill(0);
      text("y=", 40, 230);
      textSize(20);
      text((a*sin(b*(floatX+c))+d), 85, 230);

      //slider draggable point
      fill(150);
      ellipse(100+8.5*sliderX, 185, sliderDiameter, sliderDiameter);
    } else {
      openBox = false;
    }

    // checks if mouse is over the input box, if true then changes fillColor to be darker
    if (mouseX < 30 && mouseY < 30) {
      overBox = true;
      fillColor1 = 100;
    } else {
      overBox = false;
      fillColor1 = 200;
    }

    //input box in the top left corner
    fill(fillColor1);
    stroke(100);
    strokeWeight(3);
    rect(0, 0, 30, 30);

    // checks if mouse is over the reset button, if true then changes fillColor to be darker
    if (mouseX>570 && mouseY < 30) {
      overReset = true;
      fillColor2 = 100;
    } else {
      overReset = false;
      fillColor2 = 200;
    }

    //reset button in the top right corner
    fill(fillColor2);
    stroke(100);
    strokeWeight(3);
    rect(570, 0, 30, 30);

    strokeWeight(2);
    arc(585, 15, 18, 18, -PI/2, PI);
    fill(150);
    triangle(576, 10, 573, 15, 579, 15);
  }
}



//boolean to check if cursor e is over the input box
boolean overBox = false;

// boolean to toggle between having the input box opened or closed
boolean openBox = false;

// boolean to check if cursor is over the reset button
boolean overReset = false;

//checks if value a's input box was clicked by user
boolean boxA = false;

//checks if value b's input box was clicked by user
boolean boxB = false;

//checks if value c's input box was clicked by user
boolean boxC = false;

//checks if value d's input box was clicked by user
boolean boxD = false;

//the slider box input of X
boolean boxX = false;

//prevents input boxes from looping when ENTER key is held
boolean enterLock = true;

void mousePressed() {
  //checks if the input menu box is currently open
  if (openBox) {
    //checks if user clicked on boxA
    if (mouseX>90 && mouseX<190 && mouseY>5 && mouseY<30) {
      boxA = true;
      boxAFill = 150;
      println("boxA is currently active");
    } else {
      boxA = false;
      boxAFill = 200;
    }
    //checks if user clicked on boxB
    if (mouseX>90 && mouseX<190 && mouseY>35 && mouseY<60) {
      boxB = true;
      boxBFill = 150;
      println("boxB is currently active");
    } else {
      boxB = false;
      boxBFill = 200;
    }
    //checks if user clicked on boxC
    if (mouseX>90 && mouseX<190 && mouseY>65 && mouseY<90) {
      boxC = true;
      boxCFill = 150;
      println("boxC is currently active");
    } else {
      boxC = false;
      boxCFill = 200;
    }
    //checks if user clicked on boxD
    if (mouseX>90 && mouseX<190 && mouseY>95 && mouseY<120) {
      boxD = true;
      boxDFill = 150;
      println("boxD is currently active");
    } else {
      boxD = false;
      boxDFill = 200;
    }
    //checks if user clicked on the slider x input box
    if (mouseX>90 && mouseX<190 && mouseY>145 && mouseY<170) {
      rect(90, 145, 100, 25);
      boxX = true;
      boxXFill = 150;
      println("boxX is currently active");
    } else {
      boxX = false;
      boxXFill = 200;
    }
  }
  //checks if user clicked on the input box, and toggle it between true and false
  if (overBox) {
    openBox = !openBox;
    println("openBox is"+ " "+openBox);
  } 
  //checks if user clicked on the reset box
  if (overReset) {
    //resets the midline point
    midlineX = 300;
    midlineY = 300;
    //resets the crest pooint
    crestX = 300 + 15*PI;
    crestY = 270;

    //resets the a.b.c.d values in the onput boxes
    stringA = "1.00";
    stringB = "1.00";
    stringC = "0.00";
    stringD = "0.00";

    //resets the sliderX value
    floatX = 0;
    stringX = "0.00";

    println("function was reset");
  }
}



void mouseDragged() {
  //checks if user is dragging slider point
  if (mouseX>92.5+8.5*sliderX && mouseX<107.5+8.5*sliderX && mouseY>170 && mouseY<200 && mouseX>11 && mouseX<187) {
    sliderX = (mouseX-100)/8.5;
    println("slider is being adjusted");
    println(sliderX);
  }

  //checks if user is dragging the midline dragging point
  if ((mouseX>midlineX - midlineDiameter && mouseX<midlineX + midlineDiameter && mouseY>midlineY - midlineDiameter && mouseY<midlineY + midlineDiameter)
    &&!(mouseX>crestX - midlineDiameter && mouseX<crestX + midlineDiameter && mouseY>crestY - midlineDiameter && mouseY<crestY + midlineDiameter)) {
    midlineX = mouseX;
    midlineY = mouseY;
  }
  if ((mouseX>crestX - midlineDiameter && mouseX<crestX + midlineDiameter && mouseY>crestY - midlineDiameter && mouseY<crestY + midlineDiameter)
    &&!(mouseX>midlineX - midlineDiameter && mouseX<midlineX + midlineDiameter && mouseY>midlineY - midlineDiameter && mouseY<midlineY + midlineDiameter)) {
    crestX = mouseX;
    crestY = mouseY;
  }

  //updates the a, b, c and d values after moving the points2
  floatA = (midlineY - crestY)/30;
  stringA = String.format("%.2f", floatA);

  floatB = 15*PI/(crestX - midlineX);
  stringB = String.format("%.2f", floatB);

  floatC = 10 - midlineX/30 ;
  stringC = String.format("%.2f", floatC);

  floatD = 10 - midlineY/30 ;
  stringD = String.format("%.2f", floatD);

  //updates slider point when slider is moved
  floatX = sliderX;
  stringX = String.format("%.2f", sliderX);
}



void mouseReleased() {
  if (mouseX>midlineX - midlineDiameter && mouseX<midlineX + midlineDiameter && mouseY>midlineY - midlineDiameter && mouseY<midlineY + midlineDiameter) {
    println("midline point = (" + midlineX + " , " + midlineY+ ")");
  }

  if (mouseX>crestX - midlineDiameter && mouseX<crestX + midlineDiameter && mouseY>crestY - midlineDiameter && mouseY<crestY + midlineDiameter) {
    println("crest point = (" + crestX + " , " + crestY + ")");
  }
}

void keyPressed() {
  //opens the input menu if it isn't open and also activates boxX for quick changing
  if (key == ENTER && !openBox && enterLock) {
    openBox = true;
    boxA = true;
    boxAFill = 150;
    enterLock = false;
  }
  if (key == ENTER && !(boxA||boxB||boxC||boxD||boxX) && enterLock) {
    boxA = true;
    boxAFill = 150;
    enterLock = false;
  }
  //checks if boxX is currently active
  if (boxX) {
    if ((key=='0'||key=='1'||key=='2'||key=='3'||key=='4'||key=='5'||key=='6'||key=='7'||key=='8'||key=='9'||key=='.'||key=='-')&&stringA.length()<7) {
      stringX+=key;
    }
    //removes the last charcter from the string if user presses backspace
    if (key==BACKSPACE) {
      //checks if string has a greater length than 0 to prevent -1 length error
      if (stringX.length()>0) {
        stringX = stringX.substring(0, stringX.length()-1);
      }
    }
    //deactivated box if user presses enter key
    if (key == ENTER && enterLock) {
      enterLock = false;
      boxX = false;
      boxXFill = 200;
    }
    floatX = float(stringX);
    sliderX = floatX;
  }
  //checks if boxA is currently active
  if (boxA) {
    //checks if input is related to a number
    if ((key=='0'||key=='1'||key=='2'||key=='3'||key=='4'||key=='5'||key=='6'||key=='7'||key=='8'||key=='9'||key=='.'||key=='-')&&stringA.length()<7) {
      stringA+=key;
    }
    //removes the last charcter from the string if user presses backspace
    if (key==BACKSPACE) {
      //checks if string has a greater length than 0 to prevent -1 length error
      if (stringA.length()>0) {
        stringA = stringA.substring(0, stringA.length()-1);
      }
    }
    //goes to the next box if user presses ENTER key
    if (key == ENTER && enterLock) {
      boxB = true;
      boxBFill = 150;
      boxA = false;
      boxAFill = 200;
      enterLock = false;
      println("boxB is currently active");
    }
    floatA = float(stringA);
    crestY = midlineY-30*floatA;
  }
  //checks if boxB is currently active
  if (boxB) {
    //checks if input is related to a number
    if ((key=='0'||key=='1'||key=='2'||key=='3'||key=='4'||key=='5'||key=='6'||key=='7'||key=='8'||key=='9'||key=='.'||key=='-')&&stringB.length()<7) {
      stringB+=key;
    }
    //removes the last charcter from the string if user presses backspace
    if (key==BACKSPACE) {
      //checks if string has a greater length than 0 to prevent -1 length error
      if (stringB.length()>0) {
        stringB = stringB.substring(0, stringB.length()-1);
      }
    }
    //goes to the next box if user presses ENTER key
    if (key == ENTER && enterLock) {
      boxC = true;
      boxCFill = 150;
      boxB = false;
      boxBFill = 200;
      enterLock = false;
      println("boxC is currently active");
    }
    floatB = float(stringB);
    crestX = 15*PI/floatB+midlineX;
  }
  //checks if boxC is currently active
  if (boxC) {
    //checks if input is related to a number
    if ((key=='0'||key=='1'||key=='2'||key=='3'||key=='4'||key=='5'||key=='6'||key=='7'||key=='8'||key=='9'||key=='.'||key=='-')&&stringC.length()<7) {
      stringC+=key;
    }
    //removes the last charcter from the string if user presses backspace
    if (key==BACKSPACE) {
      //checks if string has a greater length than 0 to prevent -1 length error
      if (stringC.length()>0) {
        stringC = stringC.substring(0, stringC.length()-1);
      }
    }
    //goes to the next box if user presses ENTER key
    if (key == ENTER && enterLock) {
      boxD = true;
      boxDFill = 150;
      boxC = false;
      boxCFill = 200;
      enterLock = false;
      println("boxD is currently active");
    }
    floatC = float(stringC);
    midlineX = 300 - 30*floatC;
    crestX = 15*PI/floatB+midlineX;
  }
  //checks if boxD is currently active
  if (boxD) {
    //checks if input is related to a number
    if ((key=='0'||key=='1'||key=='2'||key=='3'||key=='4'||key=='5'||key=='6'||key=='7'||key=='8'||key=='9'||key=='.'||key=='-')&&stringD.length()<7) {
      stringD+=key;
    }
    //removes the last charcter from the string if user presses backspace
    if (key==BACKSPACE) {
      //checks if string has a greater length than 0 to prevent -1 length error
      if (stringD.length()>0) {
        stringD = stringD.substring(0, stringD.length()-1);
      }
    }
    //exits the input menu if user presses ENTER key 
    if (key == ENTER && enterLock) {
      boxD = false;
      boxDFill = 200;
      openBox = false;
      enterLock = false;
      println("openBox is false");
    }
    floatD = float(stringD);
    midlineY = 300 - 30*floatD;
    crestY = midlineY - 30*floatA;
  }
}

void keyReleased() {
  //makes enterLock false until key is released so it won't continuosly loop
  if (key == ENTER) {
    enterLock = true;
  }
}