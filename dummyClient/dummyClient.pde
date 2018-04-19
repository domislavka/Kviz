/*
dummyClient napravljen za Dane otvorenih vrata kako bi se lakše pitanja
i highscore-ovi prikazivali na platnu u ucionici. ovaj client nema mogucnost
odgovaranja na pitanja, njemu server salje listu igraca na pocetku i nakon
svakog pitanja trenutne highscoreove igraca. Po primitku takve informacije
on azurira na svom ekranu, bodovno stanje igraca i ceka sljedece pitanje koje
ce prikazat.
*/

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
import processing.net.*;
import java.net.InetAddress;
import controlP5.*;
import processing.video.*;

import java.util.Comparator;

// Movie[] videos;

InetAddress inet;
String ipAddr, myID = "0", myName = "dummyClient"; // Ovo promijeniti kod svakog klijenta!!!
String serverAddress;
int port = 12345;

Client c;
String input, datas[], serverData[];

Table scores = null;
TableRow question;
int currCategory = -1;
int currNumber = -1;
String myAnswer = "";
String rightAnswer = "";
String rightContainer = "";
int state = 0;
// String myScore = "0";
boolean begin = false;
// boolean scoreSaved = false;
boolean videoplay = false;
int rand_slika = 0;
boolean multiplayer = true;

pitanja Questions;

timer tim;

StringList currScores = new StringList();

int vrijemeZaOdgovor = 10;

void setup() {
  fullScreen();
  //size(800, 600);
  smooth();
  // frameRate(60);

  Questions = new pitanja();

  sirina_odg = 0.6*width - height/10;
  sirina_odg /= 2;
  razmak = height/60;

  serverAddress = "127.0.0.1";
  //serverAddress = "10.1.239.104";
  
  /*
  videos = new Movie[Questions.tabs_q[4].getRowCount()];
  for(int i = 0;i < Questions.tabs_q[4].getRowCount();++i){
    videos[i] = new Movie(this, "video/video" + i + ".mp4");
  }
  */
  
  ucitajZvijezde();
  ucitajVatromet();
}

void draw() {
  switch(state) {
    case 0:
      startScreen();
      mouseOver();
      multiplayer = true;
      break;
    case 1:
      if (begin == false) {
        c.write("myID" + "#" + myID + "#" + "name" + "#"+ myName + "#" + "Begin");
        begin = true;
      }
      game();
      break;
    case 2:
      showHighScore();
      mouseOver();
      break;
    case 3:
      noStroke();
      fill(50, 0, 40, 20);
      rect(0, 0, width, height);
      
      if(!prikaziSamoJednom){
        krajIgre();
        prikaziSamoJednom = true;
      }
      if(once == false){
        for (int i = 0; i < fs.length; i++){
          if((fs[i].hidden)&&(!once)){
            fs[i].launch();
            once = true;
          }
        }
        once = false;
      }
      for (int i = 0; i < fs.length; i++){
        fs[i].draw();
      }
      
      // prikazi krajnje bodovno stanje igraca i gumbove
      fill(255);
      textAlign(LEFT, CENTER);
      textSize(30);
      
      String lines = "";
      
      int j = 1;
      for (String igrac : currScores) {
        String[] temp = igrac.split("#");
        lines += j + ". " + temp[0] + ' ' + temp[2] + '\n';
        j++;
      }
      
      text(lines, width/2, height/2);
      buttonReplay(colors[1]);
      buttonGoBack(colors[4]);
      mouseOver();
      break;
    case 4:
    /*
      switch(rand_slika) {
      case 0: slika_1(currNumber);
              break;
      case 1: slika_2(currNumber);
              break;
      case 2: slika_3(currNumber);
              break;
      }
    */
      slika_1(currNumber);
      tim.timer_draw();
      if(stoperica.second() == vrijemeZaOdgovor){
        state = 1;
        myAnswer = "";
        slika_loadana=false;
        stoperica = null;
      }
      break;
    case 5:
       /*if(videoplay){
        videos[currNumber].play();
        videoplay = false;
      }
      imageMode(CENTER);
      image(videos[currNumber], height/10 + width * 0.3, height/10 + 17*height/60, height*0.8, height*0.5 - 5);
      tim.timer_draw();
      if(stoperica.second() == vrijemeZaOdgovor){
        state = 1;
        myAnswer = "";
        videos[currNumber].stop();
        stoperica = null;
      }*/
      break;
    case 6:
      if(stoperica == null){
        controlP5 = new ControlP5(this);
        t = controlP5.addTextlabel("..", "..", 10, 10);
        stoperica = new ControlTimer();
        stoperica.setSpeedOfTime(1);
      }
      if(stoperica.second() < pocetakOdbrojavanja){
        beginCountdown();
      }
      else{
        stoperica = null;
        state = 1;
        colorCountdown = 0;
      }
      break;
    case 7:
      crtaj_tutorijal();
      mouseOver();
      break;
    default:
      //BSOD
      fill(0, 0, 255);
      break;
  }
}

void movieEvent(Movie m){
  m.read();
}

void game() {
  if (c.available() > 0) {

    input = c.readString();

    serverData = split(input, "\n");
    print("server " + input + "\n");
    for (int i = 0; i < serverData.length; ++i){
      datas = split(serverData[i], "#");
      print("datas\n");
      for(int j = 0; j < datas.length; ++j)
        print("datas["+j+"]: " + datas[j] + "\n");
      
      // server je poslao trenutni score nekog igraca
      if(datas.length >= 9){
        print("dobio sam od servera bodovno stanje\n");
        if(datas[2].compareTo("CurrScores") == 0){
          if(datas[6].compareTo("0") != 0)
            currScores.append(datas[4] + "#" + datas[6] + "#" + datas[8]);
        }
      }
      
      // server salje klijentima score-ove
      // oni dummyu ne trebaju jer ih je vec pokupio
      else if(datas.length >= 8){
        if(datas[2].compareTo("Score") == 0){
           stoperica = null;
           state = 3;
           break;
        }
      }

      // server je poslao sljedece pitanje
      else if (datas.length >= 7) {
        
        if (datas[2].compareTo("Next") == 0) {

          // resetiramo stopericu
          stoperica = null;
        
          currCategory = Integer.parseInt(datas[4]);
          currNumber = Integer.parseInt(datas[6]);

          print("currCategory " + currCategory + "\n");
          print("currNumber " + currNumber + "\n");

          TableRow q = Questions.getPitanje(currCategory, currNumber);
          rightAnswer = q.getString(1);
          
          
          controlP5 = new ControlP5(this);
          t = controlP5.addTextlabel("..", "..", 10, 10);
          stoperica = new ControlTimer();
          stoperica.setSpeedOfTime(1);
          tim = new timer(height, width);

          background(255);
          crtaj_pravokutnikOdgovori();
          crtaj_pravokutnikPitanja();
          showCurrHighScores();
          
          crtaj_pitanje(q.getString(0), q.getString(1), q.getString(2), q.getString(3), q.getString(4));
          
          currScores = new StringList();
          
          // je li pitanje bonus ili ne
          if(currCategory == 1)
            vrijemeZaOdgovor = 5;
          else
            vrijemeZaOdgovor = 10;

          // pitanje je iz kategorije video
          if(currCategory == 4){
            state = 5;
            videoplay = true;
            break;
          }
          
          // pitanje je iz kategorije slika
          else if(currCategory == 3){
            rand_slika = (int) random(3);
            slika_loadana=false;
            state = 4;
            print("state: " + state+"\n");
          }
          
        }
      }
      
      else if(datas.length >= 3){
        // po uspjesnoj poruci od servera, pocni odbrojavanje
        if(datas[2].compareTo("Countdown") == 0){
          state = 6;
        }
      }
    }
  }

  if (stoperica != null){
    tim.timer_draw();
  }
    
}