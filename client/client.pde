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

Movie[] videos;
Minim[] audios;
AudioPlayer[] player;

ControlP5 cp5, cp6, rBtn1;
Textfield txtMyName;
Textfield txtServerAddress;
RadioButton radio1;
PFont font;

InetAddress inet;
String ipAddr, myID = "3", myName = ""; // Ovo promijeniti kod svakog klijenta!!!
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
String myScore = "0";
boolean begin = false;
boolean scoreSaved = false;
boolean videoplay = false;
int rand_slika=0;
boolean multiplayer = false;

pitanja Questions;

timer tim;

void setup() {
  fullScreen();
  //size(400, 300);
  frameRate(30);

  Questions = new pitanja();

  //CP5 controls
  font = createFont("Lucida Sans", 30);
  cp5 = new ControlP5(this);
  txtMyName = cp5.addTextfield("")
    .setPosition(width/2 - 100, height/3 + 100)
    .setSize(200, 30)
    .setColor(0)
    .setColorBackground(-1)
    .setColorCursor(0)
    .setFont(font)
    .setAutoClear(false)
    .setFocus(true);

  cp6 = new ControlP5(this);
  txtServerAddress = cp6.addTextfield("")
    .setPosition(width/2 - 100, height/3 + 125 + txtMyName.getHeight()*2)
    .setSize(200, 30)
    .setColor(0)
    .setColorBackground(-1)
    .setColorCursor(0)
    .setFont(font)
    .setAutoClear(false);

  rBtn1 = new ControlP5(this);
  radio1 = rBtn1.addRadioButton("")
                .setTitle("Odaberite")
                .setItemsPerRow(1)
                .setPosition(width/2 - 15, height/4 + 60)
                .addItem("Single player", 1)
                .addItem("Multiplayer", 2)
                .setSize(30, 30);
                
  radio1.getItem(0).setState(true);
  radio1.getItem("Single player")
        .setCaptionLabel("Single player")
        .setColorCaptionLabel(0);
  radio1.getItem("Multiplayer")
        .setCaptionLabel("Multiplayer")
        .setColorCaptionLabel(0);
       
  sirina_odg = 0.6*width - height/10;
  sirina_odg /= 2;
  razmak = height/60;

  serverAddress = "127.0.0.1";
  //serverAddress = "10.1.239.104";
  
  videos = new Movie[Questions.tabs_q[4].getRowCount()];
  for(int i = 0;i < Questions.tabs_q[4].getRowCount();++i){
    videos[i] = new Movie(this, "video/video" + i + ".mp4");
  }
  
  audios = new Minim[Questions.tabs_q[0].getRowCount()];
  player = new AudioPlayer[Questions.tabs_q[0].getRowCount()];
  for(int i = 0; i < Questions.tabs_q[0].getRowCount(); ++i){
    audios[i] = new Minim(this);
    player[i] = audios[i].loadFile("audio" + i + ".mp3");
  }
  
}

void controlEvent(ControlEvent theEvent){
  if(theEvent.isFrom(radio1)){
    if(radio1.getItem(0).getState() == true){
      radio1.deactivate(1);
    }
    else{
      radio1.activate(1);
    }
  }
}

void draw() {
  
  if (state > 0){
    txtMyName.hide();
    txtServerAddress.hide();
    radio1.hide();
  }
  else{
    txtMyName.show();
    txtServerAddress.show();
  }
  switch(state) {
    case 0:
      startScreen();
      mouseOver();
      if(radio1.getItem(0).getState() == true){
        multiplayer = false;
        textAlign(CENTER, CENTER);
        fill(255);
        stroke(255);
        rect(width/2, height/2 + txtMyName.getHeight()*1.25, width, txtMyName.getHeight()/2);
        txtServerAddress.hide();
      }
      else if(radio1.getItem(1).getState() == true){
        multiplayer = true;
        textAlign(CENTER, CENTER);
        fill(0);
        textSize(txtMyName.getHeight()/2);
        text("Unesite IP adresu servera:\n", width/2, height/2 + txtMyName.getHeight()*1.25);
        txtServerAddress.show();
      }
      
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
      krajIgre();
      mouseOver();
      break;
    case 4:
      switch(rand_slika) {
      case 0: slika_1(currNumber);
              break;
      case 1: slika_2(currNumber);
              break;
      case 2: slika_3(currNumber);
              break;
      }
      tim.timer_draw();
      if(stoperica.second() == 10){
        state = 1;
        myAnswer = "";
        slika_loadana=false;
        stoperica = null;
      }
      break;
    case 5:
       if(videoplay){
        videos[currNumber].play();
        videoplay = false;
      }
      imageMode(CORNER);
      image(videos[currNumber], height/10 + 15, height/10 + 15, 0.6*width - 15, 17*height/30 - 15);
      tim.timer_draw();
      if(stoperica.second() == 10){
        state = 1;
        myAnswer = "";
        videos[currNumber].stop();
        stoperica = null;
      }
      break;
    case 6:
      player[currNumber].play();
      tim.timer_draw();
      if(stoperica.second() == 10){
        state = 1;
        myAnswer = "";
        audios[currNumber].stop();
        stoperica = null;
      }
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
    
    odgovorio_na_pitanje = false;
    currCategory = -1;
    currNumber = -1;
    
    input = c.readString();

    serverData = split(input, "\n");
    print("server " + input + "\n");
    for (int i = 0; i < serverData.length; ++i){
      datas = split(serverData[i], "#");

      if (datas.length >= 7) {
        if (datas[2].compareTo("Next") == 0) {

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
          showHighScoreInGame();
          
          crtaj_pitanje(q.getString(0), q.getString(1), q.getString(2), q.getString(3), q.getString(4));
          
          if(currCategory == 4){
            state = 5;
            videoplay = true;
            break;
          }
          
          else if(currCategory == 3){
            rand_slika = (int) random(3);
            slika_loadana=false;
            state = 4;
            print(state+"\n");
            //crtaj_pitanje(q.getString(0), q.getString(1), q.getString(2), q.getString(3), q.getString(4));
          }
          
          else if(currCategory == 0){
            state = 6;
            break;
          }
        }
      }
      //kraj igre
      else if (datas.length >= 6) {
        if (datas[2].compareTo("Score") == 0) {
          stoperica = null;

          if (datas[5].compareTo(myID) == 0)
            myScore = datas[3];

          state = 3;
          break;
        }
      }
      //uspjena prijava na igru
      else if (datas.length >= 3) {
        loginSuccessful();
      }
    }
  }

  if (stoperica != null){
    tim.timer_draw();
    //u posljednjoj sekundi nacrtamo tocan odgovor
    //popraviti da radi s bonus pitanjem
  }
    
}