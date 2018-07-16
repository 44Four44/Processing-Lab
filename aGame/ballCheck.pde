int ballCheckNum(ball i) {
  int ball = -1;
  boolean collide = false;
  for (int j = 0; j < balls.size(); j++) {
    ball part = balls.get(j);
    if (dist(i.x, i.y, part.x, part.y) <= 
      (i.diameter + part.diameter)/2 && part != i) {
      ball = j;
      collide = true;
      part.inCollision = true;
    }
  }
  if (collide) {
    i.inCollision = true;
  } else {
    i.inCollision = false;
  }

  return ball;
}
