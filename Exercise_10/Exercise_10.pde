import processing.pdf*;

void setup() {
  size(400, 400);
  noLoop();
  beginRecord(PDF, "yes.pdf"); 
}

void draw() {
  // Draw something good here
  line(0, 0, width/2, height);
  fill(255, 0, 0);
  ellipse(0, 0, 300, 300);
  // Draw something good here
  line(0, 0, width/2, height);

  endRecord();
}