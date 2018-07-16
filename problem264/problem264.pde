void settings() {
  size(600, 600);
}

void setup() {
}

//the bounds of the graph on the screen; not actually the 'scale'
float scale = 1;

void draw() {
  //set the origin to centre of screen
  translate(300, 300);

  background(255);

  //x and y axis
  strokeWeight(1);
  line(0, 300, 0, -300);
  line(-300, 0, 300, 0);

  //setting the bounds
  scale(20/scale);

  fill(0);
  rect(0, 0, 250, 250);
    rect(3000, 3000, 250, 250);
}
                                             
                                             
void mouseWheel(MouseEvent event) {
  if (scale - event.getCount() > 0) {
    scale -= event.getCount();
    println(scale);
  }
}