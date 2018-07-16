void settings(){
  size(650, 700);
}

void setup(){};

void draw(){
  
  background(255, 255, 255);
  noFill();
  
  //arcs on the left
  //red arc
  strokeWeight(27);
  stroke(245, 98, 72);
  arc(300, 275, 500, 500, radians(85), radians(285), OPEN);
  
  //yellow arc
  strokeWeight(27);
  stroke(#CDF54D);
  arc(280, 275, 530, 500, radians(85), radians(282), OPEN);
  
  //green arc
  strokeWeight(14);
  stroke(#2FEA7B);
  arc(280, 260, 470, 500, radians(75), radians(275), OPEN);
  
  //blue arc
  strokeWeight(14);
  stroke(#608EE8);
  arc(280, 254, 450, 500, radians(95), radians(275), OPEN);
  
  //purple arc
  strokeWeight(7);
  stroke(210, 98, 242);
  arc(300, 215, 500, 500, radians(85), 3*PI/2, OPEN);
  
  
  //arcs on the right
  
  //red arc
  strokeWeight(27);
  stroke(245, 98, 72);
  arc(390, 550, 500, 520, radians(-70), radians(80), OPEN);
  
  //yellow arc
  strokeWeight(27);
  stroke(#CDF54D);
  arc(390, 525, 500, 500, radians(-85), radians(80), OPEN);
  
  //green arc
  strokeWeight(14);
  stroke(#2FEA7B);
  arc(400, 550, 410, 500, radians(-110), radians(80), OPEN);
  
  //blue arc
  strokeWeight(10);
  stroke(#608EE8);
  arc(400, 510, 450, 490, radians(-80), radians(80), OPEN);
  
  //purple arc
  strokeWeight(7);
  stroke(210, 98, 242);
  arc(400, 500, 450, 500, radians(-110), radians(80), OPEN);
}