void settings() {
  size(800, 300);
}
void setup() {
}
void draw() {
  background(255);
  //LetterO
  for (int O = 0; O<= PI*2; O+=PI/10) {
    fill(0);
    ellipse(75*cos(O) + 400, 75*sin(O) + 150, 20, 20);
  }

fill(0);
  ellipse(400, 150, 30, 30);
}