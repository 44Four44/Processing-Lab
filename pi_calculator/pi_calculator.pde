void settings () {
  size(600, 600);
}

//total number of points placed
int total = 10000;

//current count of points
float count = 0;

//current number of points in the circle
float hits = 0;

//estimate of pi based on point accuracy
float estimate = 0;

//current x and y of point
float x;
float y;

void setup() {
  frameRate(120);
  background(255);

  strokeWeight(1);
  fill(230);
  stroke(0);
  rect(100, 100, 400, 400);

  noStroke();
  fill(175);
  ellipse(300, 300, 400, 400);

  //graph lines
}



void draw() {
  if (count < total) {
    //random point in square
    x = random(100, 500);
    y = random(100, 500);
    fill(0);

    if (dist(x, y, 300, 300) <= 200) {
      hits++;
      fill(255, 0, 0);
    }

    noStroke();
    ellipse(x, y, 2, 2);

    //count ++
    count++;

    //re estimate
    estimate = 4*hits/count;
  }
  //dipslay estimate of pi
  fill(255);
  noStroke();
  rect(0, 520, 150, 100);

  textSize(40);
  fill(0);
  text(estimate, 5, 565);

  //graph for estimate
  ellipse(200 + 400*count/total, 580 - (estimate - 3)*60, 1, 1);
  stroke(0);
  line(0, 580, 600, 580);
  line(0, 520, 600, 520);

  stroke(255, 0, 0);
  line(0, 580 - (PI - 3)*60, 600, 580 - (PI - 3)*60);

  println(estimate);
}