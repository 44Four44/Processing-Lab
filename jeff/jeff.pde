void settings(){
  size(3600, 800);
};
PImage photo;

void setup(){
  size(400, 400);
  photo = loadImage("Webp.net-resizeimage.jpg");
  frameRate(40);
 
};

float gg = 1;
void draw()
{
  if(gg%3 == 0){
  fill(0);
  rect(0,0, 3600, 800);
  gg++;
}else if(gg%3==1){
  image(photo, 100, 0);
  gg++;
}else{
  fill(255);
  rect(0,0, 3600, 800);
  gg++;
}
}