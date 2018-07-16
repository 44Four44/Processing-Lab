float H = 0;
float S = 0;
float E = 0;
void settings(){
  size(3600, 800);
}

void setup(){
// background(S, 99, 99);
 frameRate(60);
  colorMode(HSB, 359, 99, 99);
 background(S, 99, 99);
 frameRate(60);
 if(S>359){
  S=0;
}else{
  S+=10;
}
//
};

void draw(){
 
 colorMode(HSB, 359, 99, 99);
 
//rect(0, 0, 3600, 800);
 fill(S, 99, 99);
 if(S>359){
  S=0;
}else{
  S+=1;
}

  fill(H, 99, 99);
  stroke(0);
  ellipse(mouseX, mouseY, 50, 50);

if(H>359){
  H=0;
}else{
  H+=100;
}


}