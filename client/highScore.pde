//ucitavanje HighScore
void ucitajHighScore(){
  scores = new Table();
  scores = loadTable("highscore.csv", "header, csv");
  scores.setColumnType(0, "String");
  scores.setColumnType(1, "int");
}

void showHighScoreInGame(){
  
  if(scores == null)
    ucitajHighScore();
  
  float x_koord_texta = 0.6*width + height/5 + sirina_odg/10;
  float y_koord_texta = height/10 + sirina_odg/10;

  float sirina_textboxa = - 3*height/10 + width/2.5 - sirina_odg/5;
  float visina_textboxa = 17*height/30 - sirina_odg/5;

  String lines = new String();
  
  int j = 1;
  for (TableRow row : scores.rows() ) {
    if(j == 21) break;
    String ime = row.getString(0);
    int score = row.getInt(1);
    lines += j + ". " + ime + ' ' + score + '\n';
    j++;
  }

  
  stroke(0);
  fill(255);
  rect(0.6*width + height/5, height/10, - 3*height/10 + width/2.5, 17*height/30, oblost);

  fill(0);
  textAlign(LEFT, CENTER);
  textSize(visina_textboxa/20);
  //hocemo li stavit jos -1 ili imati samo npr. top 20 listu?
  //postavlja prored izmedju linija
  textLeading(visina_textboxa/20);
  text(lines, x_koord_texta, y_koord_texta, sirina_textboxa, visina_textboxa);
}

void showHighScore(){
  if(scores == null)
    ucitajHighScore();
    
  String lines = new String();

  int j = 1;
  for (TableRow row : scores.rows() ) {
    String ime = row.getString(0);
    int score = row.getInt(1);
    lines += j + ". " + ime + ' ' + score + '\n';
    j++;
  }
  
  background(255);
  fill(0);
  textAlign(LEFT, CENTER);
  textSize(20);
  text(lines, width/10, 0, width, height);
  
  buttonGoBack(colors[1]);
}