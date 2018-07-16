float y1 = 0;

float x1 = 0;

float y2 = 0;

float x2 = 0;

float H = 0;

void settings(){
  size(400, 650);
}

void setup(){
  background(0);
}

void draw(){
  
  noStroke();
  colorMode(HSB,359,99,99);
  fill(H, 99, 99);
  ellipse(200, y1, 15+x1/3.5, 15+y1/3.5);
  y1+=2;
  x1+=2;
 
  ellipse(x2, 325, 15+x2/6, 15+y2/6);
  y2+=0.7;
  x2+=0.7;
  
  if(H>390){
    H=0;
}else{
    H+=10;
}
}