void settings(){
  size(320, 620);
}

void setup(){
  background(0);
}

float x1 = 0;
float y1 = 0;
float H = 0;
float changeH = 30;
void draw(){
  
  colorMode(HSB, 359, 99, 99);
  
  //moving circles
  fill(H, 99, 99);
  stroke(150);
  ellipse(x1/4, y1, 50, 50);
  
  //used to make circles start at top again but keeping same x coordinate
  if(y1>620){
    y1 = 0;
    x1 += 3;
    H = changeH;
    changeH += 27;
  }else{
  x1 += 3;
  y1 += 11;
  H += 8;
  }
  
}