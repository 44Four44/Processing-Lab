void settings(){
  size(600, 600);
}

void setup(){}

String text1;
void draw(){
rect(60, 60, 60, 60);
rect(140, 60, 60, 60);
text(text1+100, 300, 300);

noLoop();
println(a, plus,b);

}

float a = 1;
float b = 2;

boolean overButton1 = false;
boolean overButton2 = false;
float answer;
char plus = '+';

void mousePressed() {
  //checks if user clicked on button1
  if (mouseX > 60 && mouseX <120 && mouseY > 60 && mouseY < 120) {
    overButton1 = true;
    println("4");
    text1 += 4;
 
  } else {
    overButton1 = false;
  }{
  if (mouseX > 140 && mouseX <200 && mouseY > 60 && mouseY < 120) {
    overButton2 = true;
    println("+");
    text1 += "+";
  } else {
    overButton2 = false;
  }
  }}
  
  
  void addition(){
    println(3+b);
  }
  
  