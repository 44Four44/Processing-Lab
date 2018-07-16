void settings () {
  size(600, 600);
}

void setup() {
  frameRate(5);
}

int start = 1000;

float scale = 1 ;

void draw() {

  background(255);
  
  println(scale) ;
  scale (scale); 


  //for displaying the collatz path of 1 number
  
  fill(0);
   textSize(100);
   textAlign(CENTER);
   text(start, 300, 300);
   
   start = collatz(start);
   

  //goes through every number from 1 ~ 360000
  for (int i = 5607; i <= 5607; i++) {
    drawCollatz(i);
  }
}

int collatz(int number) {
  if (number%2 == 0) {
    return number/2;
  } else {
    return 3*number+1;
  }
}

void drawCollatz(int number) {

  boolean flip = true;
  int newNumber = number;

  while (newNumber != 1) {
    strokeWeight(1);
    stroke(0);
    line((newNumber-1)%600 + 1, (newNumber - newNumber%600)/600, 
      (collatz(newNumber)-1)%600 + 1, (collatz(newNumber) - collatz(newNumber)%600)/600);

    if (flip) {
      fill(0, 0, 255);
    } else {
      fill(255, 0, 0);
    }
    flip = false;

    noStroke();
    ellipse((newNumber-1)%600 + 1, (newNumber - newNumber%600)/600, 10, 10);

    textSize(1);
    textAlign(CENTER);
    fill(0, 255, 0);
  //  text(newNumber, (newNumber-1)%600 + 1, (newNumber - newNumber%600)/600);
    newNumber = collatz(newNumber);
  }
}