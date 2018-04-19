// downloaded from http://processing.org/examples/star.html

void star(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

void ucitajZvijezde(){
  for(int i = 0; i < numberOfStars; ++i){
       stars[i] = new float[6];
       stars[i][0] = random(10, 25);
       stars[i][1] = random(10, 25);
       stars[i][2] = random(0, colorsForStars.length);
       // x koordinata
       stars[i][3] = random(0, width);
       // y koordinata
       stars[i][4] = random(0, height);
       // broj vrhova
       stars[i][5] = random(5, 10);
    }
}
