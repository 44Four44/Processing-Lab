int blockCheckNum(ball i){
  int block = -1;
  for(int j = 0; j < blockAmount; j++){
    if(dist(i.x, i.y, blocks[j].x, blocks[j].y) <= 
    (i.diameter + blocks[j].diameter)/2) {
      block = j;
    }
  }
  
  return block;
}