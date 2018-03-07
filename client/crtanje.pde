int razmak; 
int oblost = 30;
float sirina_odg;

String gameName = "KVIZ";
String welcomeMessage = "Dobrodošli!";
String nameMessage = "Unesite svoje ime:\n";
String serverAddressMessage = "Unesite IP adresu servera:\n";
String closeText = "Zatvori";
String startText = "Počni!";
String highScoreText = "Highscore";
String goBackText = "Nazad";
String replayText = "Igraj opet!";
String loginSuccessText = "Uspješno ste prijavljeni na igru. Molimo pričekajte.\n";

//pocetni zaslon
void startScreen(){
  background(255);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(70);
  text(gameName, width/2, height/10);
  textSize(40);
  text(welcomeMessage, width/2, height/10 + 100);
  textSize(txtMyName.getHeight()/2);
  fill(0);
  text(nameMessage, width/2, height/3);
  textAlign(CENTER, CENTER);
  
  buttonHighScore(colors[0]);
  buttonStart(colors[1]);
  buttonClose(colors[2]);
}

StringList answers = new StringList();

//vrati u kojoj kucici za odgovore se nalazi tocan odgovor
void crtaj_pitanje(String q, String a1, String a2, String a3, String a4) {
  rightContainer = "";
  
  answers = new StringList();
  answers.append(a1);
  answers.append(a2);
  answers.append(a3);
  answers.append(a4);
  
  //promijesaj odgovore
  answers.shuffle();

  for (int i = 0; i < 4; ++i) {
    if (a1 == answers.get(i)) {
      rightContainer += i;
      break;
    }
  }


  //napisi odgovore i pitanje
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(30);
  String tekst = "";
  if(currCategory == 1)
    tekst += "BONUS:\n" + q;
  else
    tekst += q;
    
  if(currCategory == 0){
    PImage nota = loadImage("/audio/nota.jpg");
    nota.resize(nota.width/20, nota.height/20);
    imageMode(CORNER);
    image(nota, height/10 + 10, height/10 + 10);
  }
    
  if(currCategory == 4 || currCategory == 3) text(tekst, height/10 + width*0.3, height/10 + height/60);
  else text(tekst, height/10 + width*0.3, height/10 + 17*height/60);
  text(answers.get(0), height/10 + sirina_odg/2, 2*height/3 + razmak + height/20);
  text(answers.get(1), height/5 + sirina_odg*1.5, 2*height/3 + razmak + height/20);
  text(answers.get(2), height/10 + sirina_odg/2, 2*height/3 + 2*razmak + height/20 + height/10);
  text(answers.get(3), height/5 + sirina_odg*1.5, 23*height/30 + 2*razmak + height/20);
}

void crtajKomande(){
  fill(0);
  textSize(30);
  textAlign(LEFT, CENTER);
  text("A: ", height/10 + 5, 2*height/3 + razmak + height/20);
  text("S: ", height/5 + sirina_odg + 5, 2*height/3 + razmak + height/20);
  text("D: ", height/10 + 5, 2*height/3 + 2*razmak + height/10 + height/20);
  text("F: ", height/5 + sirina_odg + 5, 23*height/30 + 2*razmak + height/20);

}

void crtaj_pravokutnikA(int c) {
  fill(c);
  stroke(0);
  //odgovor 1
  rect(height/10, 2*height/3 + razmak, sirina_odg, height/10, oblost);
  fill(0);
  textSize(30);
  text(answers.get(0), height/10 + sirina_odg/2, 2*height/3 + razmak + height/20);
}

void crtaj_pravokutnikS(int c) {
  fill(c);
  stroke(0);
  //odgovor 2
  rect(height/5 + sirina_odg, 2*height/3 + razmak, sirina_odg, height/10, oblost);
  fill(0);
  textSize(30);
  text(answers.get(1), height/5 + sirina_odg*1.5, 2*height/3 + razmak + height/20);
}

void crtaj_pravokutnikD(int c) {
  fill(c);
  stroke(0);
  //odgovor 3
  rect(height/10, 2*height/3 + 2*razmak + height/10, sirina_odg, height/10, oblost);
  fill(0);
  textSize(30);
  text(answers.get(2), height/10 + sirina_odg/2, 2*height/3 + 2*razmak + height/20 + height/10);
}

void crtaj_pravokutnikF(int c) {
  fill(c);
  stroke(0);
  //odgovor 4
  rect(height/5 + sirina_odg, 23*height/30 + 2*razmak, sirina_odg, height/10, oblost);
  fill(0);
  textSize(30);
  text(answers.get(3), height/5 + sirina_odg*1.5, 23*height/30 + 2*razmak + height/20);
}


void crtaj_pravokutnikPitanja() {
  fill(255);
  stroke(0);
  rect(height/10, height/10, 0.6*width, 17*height/30, oblost);
}

void crtaj_pravokutnikOdgovori() {
  fill(255);
  stroke(0);

  //odgovor 1
  rect(height/10, 2*height/3 + razmak, sirina_odg, height/10, oblost);

  //odgovor 2
  rect(height/5 + sirina_odg, 2*height/3 + razmak, sirina_odg, height/10, oblost);

  //odgovor 3
  rect(height/10, 2*height/3 + 2*razmak + height/10, sirina_odg, height/10, oblost);

  //odgovor 4
  //rect(height/5 + sirina_odg, 2*height/3 + 2*razmak + height/10, sirina_odg, height/10, 30);
  rect(height/5 + sirina_odg, 23*height/30 + 2*razmak, sirina_odg, height/10, oblost);

  crtajKomande();
}

void crtaj_pravokutnikHighscore() {
  rect(0.6*width + height/5, height/10, - 3*height/10 + width/2.5, 17*height/30, oblost);
}

void krajIgre() {
  
  if(scoreSaved == false){
    if(scores == null)
      ucitajHighScore();

    //spremi bodove u tablicu scores, pa u file
    TableRow newRow = scores.addRow();
    newRow.setString(0, myName);
    newRow.setInt(1, Integer.parseInt(myScore));
  
    scores.sortReverse(1);
    
    saveTable(scores, "data/highscore.csv", "header, csv");
    
    scoreSaved = true;
  }
    
  tim = null;
  rightContainer = "";
  rightAnswer = "";
  myAnswer = "";
  
  fill(255);
  rect(0, 0, width, height);
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(40);
  text("Osvojeni bodovi: " + myScore, width/2, height/2);
  
  buttonClose(colors[2]);
  buttonReplay(colors[1]);
  buttonGoBack(colors[4]);
  
}

void loginSuccessful(){
  fill(0);
  stroke(0);
  textAlign(CENTER);
  textSize(20);
  text(loginSuccessText, width/2, 7*height/12 + razmak/2 + 15 + txtMyName.getHeight()*1.25);
}