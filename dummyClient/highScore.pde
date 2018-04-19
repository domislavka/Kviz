int numberOfStars = 100;
float [][] stars = new float[numberOfStars][6];
color[] colorsForStars = {#FF0000,#FF3300,#ff6600,#ff9900,#FFCC00,#FFFF00,#ccff00,#99ff00,#66ff00,#33ff00,#DA70D6, #64EE64, #DC143C, #C0C0C0, #FFFF66, #B0E0E6, #87CEEB, #AFEEEE, #20B2AA};


//ucitavanje HighScore
void ucitajHighScore(){
  scores = new Table();
  scores = loadTable("highscore.csv", "header, csv");
  scores.setColumnType(0, "String");
  scores.setColumnType(1, "int"); 
}

void showCurrHighScores(){
  
  /*
  if(scores == null)
    ucitajHighScore();
  */
  
  float x_koord_texta = 0.6*width + height/5 + sirina_odg/10;
  float y_koord_texta = height/10 + sirina_odg/10;

  float sirina_textboxa = - 3*height/10 + width/2.5 - sirina_odg/5;
  float visina_textboxa = 17*height/30 - sirina_odg/5;

  String lines = new String();
  
  int j = 1;
  for (String igrac : currScores) {
    String[] temp = igrac.split("#");
    lines += j + ". " + temp[0] + ' ' + temp[2] + '\n';
    j++;
  }

  println("lines " + lines);
  
  stroke(0);
  fill(255);
  rect(0.6*width + height/5, height/10, - 3*height/10 + width/2.5, 17*height/30, oblost);

  fill(0);
  stroke(0);
  textAlign(LEFT, CENTER);
  textSize(visina_textboxa/20);
  //postavlja prored izmedju linija
  textLeading(visina_textboxa/20);
  text(lines, x_koord_texta, y_koord_texta, sirina_textboxa, visina_textboxa);
}

void showHighScore(){
  if(scores == null)
    ucitajHighScore();
    
  background(255);
  
  for(i = 0; i < numberOfStars; ++i){
    pushMatrix();
    translate(stars[i][3], stars[i][4]);
    rotate(frameCount / 50.0);
    stroke(colorsForStars[(int)stars[i][2]]);
    fill(colorsForStars[(int)stars[i][2]]);
    star(0, 0, stars[i][0], stars[i][1], (int)stars[i][5]); 
    popMatrix();
  }
  
  String lines = new String();

  int j = 1;
  for (TableRow row : scores.rows() ) {
    if(j == 21) break;
    String ime = row.getString(0);
    int score = row.getInt(1);
    lines += j + ". " + ime + ' ' + score + '\n';
    j++;
  }
  
  fill(0);
  textAlign(LEFT, CENTER);
  textSize(20);
  text(lines, width/10, 0, width, height);
  
  buttonGoBack(colors[1]);
  
}
