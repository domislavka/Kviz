import processing.net.*;
import java.net.InetAddress;

String ipAddr, myID = "1";

Server s;
Client c;
ArrayList<Client> allClients = new ArrayList<Client>();
ArrayList<Player> players = new ArrayList<Player>();

pitanja Questions;
int numQuestions = 10;
String rightAnswer = "";
boolean anyRight = false;
timer tim;
boolean begin = false;
boolean countdown = false;
boolean bonusQ = false;

String currCategory = "-1";
String currNumber = "-1";
String prevCategory = "-1";
String prevNumber = "-1";

// tekst pitanja za prikazat na ekranu
String q = "";

int pocetakOdbrojavanja = 5;
int countdownTextSize = 100;

String input, datas[], playerData[];
StringList clientAnswers = new StringList();

int vrijemeZaOdgovor = 10;

String idOfPlayerWhoHasFirstRightAnswer = "";

void setup(){
  // fullScreen();
  size(600, 600);
  smooth();
  // frameRate(60);
  Questions = new pitanja();
  
  s = new Server(this, 12345);
  InetAddress inet;
  
  startScreen();
  buttonStart();
  buttonClose();
  
  try{
    inet = InetAddress.getLocalHost();
    println(inet);
    println(inet.getHostAddress());
    ipAddr = inet.getHostAddress();
    println(ipAddr);
  }
  catch(Exception e){
    e.printStackTrace();
  }
  
  println("ima " + Questions.tabs_q[0].getRowCount() + " audio pitanja");
  audios = new Minim[Questions.tabs_q[0].getRowCount()];
  player = new AudioPlayer[Questions.tabs_q[0].getRowCount()];
  for(int i = 0; i < Questions.tabs_q[0].getRowCount(); ++i){
    audios[i] = new Minim(this);
    player[i] = audios[i].loadFile("audio" + i + ".mp3");
  }
  
  /*
  videos = new Movie[Questions.tabs_q[4].getRowCount()];
  for(int i = 0;i < Questions.tabs_q[4].getRowCount();++i){
    videos[i] = new Movie(this, "video/video" + i + ".mp4");
  }
  */
  
}

void draw(){

  c = s.available();
  if(c != null){
    input = c.readString();
    playerData = split(input, '\n');

    for(int i = 0; i < playerData.length; ++i){
      datas = split(playerData[i], '#');
      print("klijent: " + playerData[i] + "\n");
      
      if(datas.length >= 10){
          
        print("datas[5]: " + datas[5] + " currCategory: " + currCategory + "\n");
        print("datas[7]: " + datas[7] + " currNumber: " + currNumber + "\n");

        // ako klijent odgovara na prethodno pitanje
        if((datas[5].compareTo(prevCategory) == 0) && 
           (datas[7].compareTo(prevNumber) == 0) )
          break;

        print("id " + datas[1] +"odgovor " + datas[9] + "\n");
        clientAnswers.push(datas[1] + '#' + datas[9]);
              
       print("clientANSWSIZE: " + clientAnswers.size() + "\n");
        
        for(Player p : players){
          if(p.id.compareTo(datas[1]) == 0){
            if(p.answer.length() == 0){  //SAMO JEDNOM BILJEZIMO ODGOVOR
              p.answer = datas[9];
              if(idOfPlayerWhoHasFirstRightAnswer.length() == 0 && datas[9].compareTo(rightAnswer) == 0)
                idOfPlayerWhoHasFirstRightAnswer = p.id;
            }
            break;
          }
        }
            // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            // AKO BUDE PROBLEMA S BONUS PITANJEM GLEDAJ OVDJE !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
            // I NE ZABORAVI NA ONAJ UVJET DOLJE ZA PROVJERU JE LI VRIJEME ISTEKLO
            // !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        if(bonusQ == true){
          //pogledamo jel odgovorio tocno
          //print("rA: " + rightAnswer + " " + "cA: " + clientAnswer + "\n");
          //odgovor ovog je zadnji odgovor dodan
          if(anyRight == false){
            int lastAnswer = clientAnswers.size();
            String[] info = split(clientAnswers.get(lastAnswer - 1), '#');
            
            if(info[1].compareTo(rightAnswer) == 0){
              //povecamo mu bodove
              for(Player p : players){
                print(p.id + " " + datas[1] + "\n");
                if(p.id.compareTo(info[0]) == 0){
                  p.score += 5;  //+5 jer se radi o bonus odgovoru
                  anyRight = true;
                  break;
                }
              }
            }
          }
          println("gotov s bonusom");
        }
      }
        
      else if(datas.length >= 5){
        
        if(datas[4].compareTo("Begin") == 0){
          
          for(Player p : players){
            if(c.ip().compareTo(p.ip) == 0){
              p.name = datas[3];
              p.id = datas[1];
              if(p.id.compareTo("0") == 0){
                p.score = 0;
              }
            }
          }
          
          if(allClients.contains(c) == false){
            allClients.add(c);
            print("Begin je poslao igrac: " + datas[1]+ ' ' +  datas[3]+ ' ' + c.ip() + '\n');
            players.add(new Player(datas[1], datas[3], c.ip()));
          }
          
          //ispisi na ekran tko se prijavio
          textSize(20);
          text(datas[1] + " " + datas[3]+ " " + datas[4] + "\n", width/3, height/10 + 20*(players.size()+1));
          
          //posalji poruku o uspjesnoj prijavi
          c.write("myID" + "#" + myID + "#" + "Success" + "\n");
        }
      }
    }
  }
  
  else{
    if(countdown == true){
       if(stoperica == null){
         controlP5 = new ControlP5(this);
         t = controlP5.addTextlabel("..", "..", 10, 10);
         stoperica = new ControlTimer();
         stoperica.setSpeedOfTime(1);
       }
       else if(stoperica.second() == pocetakOdbrojavanja){
         countdown = false;
         begin = true;
         stoperica = null;
       }
       else{
         beginCountdown();
       }
    }
    
    else if(begin == true){
      if(((stoperica == null || stoperica.second() == (vrijemeZaOdgovor+3)) && clientAnswers != null)
          /*|| (stoperica.second() > 0 && anyRight == true && bonusQ == true)*/){
        anyRight = false;
        stoperica = null;
        
        if(currCategory.compareTo("0") == 0){
          audios[Integer.parseInt(currNumber)].stop();
        }
        
        if(bonusQ == false){
          // dodijelimo bodove svima koji su tocno odgovorili
          print(clientAnswers.size() + "\n");
          for(String odg : clientAnswers){
            fill(128);
            stroke(128);
            rect(100,100, 400, 200);
            String[] info = split(odg, '#');
            for(Player p : players){
              if(p.id.compareTo(info[0]) == 0 
                && info[1].compareTo(rightAnswer) == 0){
                print("dajem score igracu " + info[0] + " " + info[1] + "\n");
                p.score += 10;
                if(p.id.compareTo(idOfPlayerWhoHasFirstRightAnswer) == 0){
                  p.score += 5;
                  idOfPlayerWhoHasFirstRightAnswer = "";
                }
                break;
              }
            }
          }
        }
        int iteracija = 1;
        for(Player p : players){
          if(p.id.compareTo("0") != 0){
            fill(128);
            rect(200, 100, 1000, 200);
            fill(0);
            stroke(0);
            textSize(20);
            text("Igrac " + p.name + " ima trenutno " + p.score + " bodova\n", 200, 100 + 30*iteracija);
            ++iteracija;
            println("Igrac " + p.name + " ima trenutno " + p.score + " bodova");
          }
        }
        
        
         // sortiraj po velicini bodove
        print("currCategory prije slanja dummyClientu " + currCategory + "\n");
        Collections.sort(players);
        print("Igraci sortirani po bodovima\n");
        for(Player p : players){
          print("myID" + "#" + myID + "#" +"CurrScores" + "#" + "name" + "#" + p.name + "#" + "id" + "#" + p.id + "#" + "score" + "#" + p.score + "\n");
        }
        print("saljem trenutno bodovno stanje\n");
        print(allClients.size() + "\n");
        for(Client c : allClients){
          if(c.ip().compareTo("127.0.0.1") == 0){
            for(int i = players.size() - 1; i >= 0; --i){
              c.write("myID" + "#" + myID + "#" +"CurrScores" + "#" + "name" + "#" + players.get(i).name + "#" + "id" + "#" + players.get(i).id + "#" + "score" + "#" + players.get(i).score + "\n");
            }
            break;
          }
        }
        
        //generiraj novo pitanje
        if(numQuestions > 0){
          //resetiramo igraca koji je prvi tocno odgovorio
          idOfPlayerWhoHasFirstRightAnswer = "";
          //resetiramo odgovore klijenata
          for(int i = 0; i < players.size(); ++i){
            players.get(i).answer = "";
          }
          
          // posalji pitanje klijentima
          String qNumber = generateQuestion();
          for(Client c : allClients){
            c.write("myID" + "#" + myID + "#" + "Next" + "#" + qNumber + "\n");
            print("saljem " + "myID" + "#" + myID + "#" + "Next" + "#" + qNumber + '\n');
          }
          
          // ako se radi o pitanju iz kategorije audio, pusti taj audio
          if(currCategory.compareTo("0") == 0){
            player[Integer.parseInt(currNumber)].play();
            
            for(int ispisi = 0; ispisi < 30; ++ispisi)
              println(currNumber);
          }
          
           controlP5 = new ControlP5(this);
           t = controlP5.addTextlabel("..", "..", 10, 10);
           stoperica = new ControlTimer();
           stoperica.setSpeedOfTime(1);
           tim = new timer(height, width);
           
          --numQuestions;
          clientAnswers.clear();
        }
        
        // ako je vrijeme isteklo i nemamo vise pitanja
        else{
          // posalji klijentima njihove bodove
          print("broj igraca: " + players.size() + "\n");
          print("ispisi sve igrace:\n");
          for(Player p : players){
            print(p.id + " " + p.name + " " + p.ip + " " + p.score + "\n");
          }
          print("broj igraca u clients: " + allClients.size() + "\n");
          
          //posalji im score-ove
          for(Client c : allClients){
            for(Player p : players){
              print(p.id + " p " + p.ip + " " + p.name + " " + p.score + "\n");
              print("c " + c.ip() + "\n");
              if((p.ip).compareTo(c.ip()) == 0){
                 c.write("myID" + "#" + myID + "#" + "Score" + "#" + p.score + "#" + "clientID" + "#" + p.id + "#" + "clientName" + "#" + p.name + "\n");
                 print("myID" + "#" + myID + "#" + "Score" + "#" + p.score+ "#" + "clientID" + "#" + p.id + "#" + "clientName" + "#" + p.name);
              }
            }
          }
          
          // posalji da je kraj
          for(Client c : allClients){
            c.write("myID" + "#" + myID + "#" + "TheEnd" + '\n');
          }
     
           //print za provjeru
          for(int i = 0; i < players.size(); ++i){
            print(players.get(i).id + " " + players.get(i).name + " " + players.get(i).score + "\n");
          }
          
          //resetiraj podatke
          resetServer();
        }
      }
    }
  }
  if(stoperica != null && begin == true)
    tim.timer_draw();
}

void serverEvent(Server myServer, Client newClient){
  print("Spojio se klijent: " + newClient.ip() + "\n");
  
  if(allClients.contains(newClient) == false){
    allClients.add(newClient);
    players.add(new Player(newClient.ip()));
  }
  
}

String generateQuestion(){
  //treba stavit random category
   int category = (int) random(BROJKATEGORIJA);
   if(category == 1){
     bonusQ = true;
     vrijemeZaOdgovor = 5;
   }
   else{
     bonusQ = false;
     vrijemeZaOdgovor = 10;
   }
     
   TableRow question = Questions.random_pitanje(category);
   
   //random pitanje je zadnje dodano u postavljena pitanja
   int lastIndex = Questions.postavljena_pitanja[category].size() - 1;
   int number = Questions.postavljena_pitanja[category].get(lastIndex);
   
   rightAnswer = question.getString(1);
   q = question.getString(0);

   print("redni broj pitanja " + number + "\n");
   print("generirano pitanje: " + question.getString(0) + "\n");
   print("tocan odgovor " + rightAnswer + "\n");

   return "category" + "#" + currCategory + "#" + "number" + "#" + currNumber;
}