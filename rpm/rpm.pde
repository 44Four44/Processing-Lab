void settings() {
  size(600, 600);
}

void setup() {
}

float angled = 0;
float deltaAngle = angleOf(width/2, height/2, mouseX, mouseY);
void draw() {
  background(255);
  
  line(300, 300, mouseX, mouseY);
  
  angled += abs(angleOf(width/2, height/2, mouseX, mouseY) - deltaAngle);
  
  deltaAngle = angleOf(width/2, height/2, mouseX, mouseY);
  
  textSize(60);
  fill(0);
  text(angled, 300, 300);
}

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