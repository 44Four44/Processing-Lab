void settings() {
  size(600, 600);
}

void setup() {
  background(#0FFFE9);
}
float claire = 450;
void draw () {
  fill(#0209BC);
  stroke(0);
  strokeWeight(10);
  rect(100, 100, claire, claire);

  stroke(#88C0FA);
  line(0, 0, claire, claire);
  
  claire = claire - 20;
}