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
boolean bonusQ = false;

String currCategory = "-1";
String currNumber = "-1";
String prevCategory = "-1";
String prevNumber = "-1";

String input, datas[], playerData[];
StringList clientAnswers = new StringList();

void setup(){
  size(600, 600);
  frameRate(30);
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

          //ako klijent odgovara na prethodno pitanje
          if((datas[5].compareTo(prevCategory) == 0) && 
             (datas[7].compareTo(prevNumber) == 0) )
            break;
          
          //spremimo klijenta i njegov odgovor, SAMO JEDNOM
          if(clientAnswers.size() > 0)
            for(String odg : clientAnswers){
              if(odg.contains(datas[1]) == false)
                clientAnswers.push(datas[1] + '#' + datas[9]);
            }
          else
              clientAnswers.push(datas[1] + '#' + datas[9]);

          
         print(clientAnswers.size() + "\n");
          
          for(Player p : players){
            if(p.id.compareTo(datas[1]) == 0){
              if(p.answer.length() == 0)  //SAMO JEDNOM BILJEZIMO ODGOVOR
                p.answer = datas[9];
              break;
            }
          }
          
          if(bonusQ == true){
            //pogledamo jel odgovorio tocno
            //print("rA: " + rightAnswer + " " + "cA: " + clientAnswer + "\n");
            //odgovor ovog je zadnji odgovor dodan
            int lastAnswer = clientAnswers.size();
            String[] info = split(clientAnswers.get(lastAnswer - 1), '#');
            
            if(info[1].compareTo(rightAnswer) == 0){
              //povecamo mu bodove
              for(Player p : players){
                print(p.id + " " + datas[1] + "\n");
                if(p.id.compareTo(info[0]) == 0){
                  p.score += 5;  //+5 jer se radi o bonus odgovoru
                  break;
                }
              }
              anyRight = true;
            }
            break;
          }
      }
        
      else if(datas.length >= 5){
        
           
        if(datas[4].compareTo("Begin") == 0){
          
          for(Player p : players){
            if(c.ip().compareTo(p.ip) == 0){
              p.name = datas[3];
              p.id = datas[1];
            }
          }
          
          if(allClients.contains(c) == false){
            allClients.add(c);
            print("Begin je poslao igrac: " + datas[1]+ ' ' +  datas[3]+ ' ' + c.ip() + '\n');
            players.add(new Player(datas[1], datas[3], c.ip()));
          }
          
          //ispisi na ekran tko se prijavio
          textSize(20);
          text(datas[1] + " " + datas[3]+ " " + datas[4] + "\n", height/10, height/10 + 20*(players.size()+1));
          
          //posalji poruku o uspjesnoj prijavi
          c.write("myID" + "#" + myID + "#" + "Success");
        }
      }
    }
  }
  
  else{
    if(begin == true){
      if(((stoperica == null || stoperica.second() == 10) && clientAnswers != null)
          || (stoperica.second() > 0 && anyRight == true && bonusQ == true)){
        anyRight = false;
        stoperica = null;
        if(bonusQ == false){
          //dodijelimo bodove svima koji su tocno odgovorili
          print(clientAnswers.size() + "\n");
          for(String odg : clientAnswers){
            String[] info = split(odg, '#');
            for(Player p : players){
              print("dajem score igracu " + info[0] + " " + info[1] + "\n");
              if(p.id.compareTo(info[0]) == 0 
                && info[1].compareTo(rightAnswer)== 0)
                p.score += 10; //postavi da bude proporcionalno
            }
          }
        }
        
        clientAnswers.clear();
        
        //generiraj novo pitanje
        if(numQuestions > 0){
          //resetiramo odgovore klijenata
          for(int i = 0; i < players.size(); ++i){
            players.get(i).answer = "";
          }
          
          String qNumber = generateQuestion();
          for(Client c : allClients){
            c.write("myID" + "#" + myID + "#" + "Next" + "#" + qNumber);
            print("saljem " + "myID" + "#" + myID + "#" + "Next" + "#" + qNumber + '\n');
          }        
           
           controlP5 = new ControlP5(this);
           t = controlP5.addTextlabel("..", "..", 10, 10);
           stoperica = new ControlTimer();
           stoperica.setSpeedOfTime(1);
           tim = new timer(height, width);
           
          --numQuestions;
        }
        
        //ako je vrijeme isteklo i nemamo vise pitanja
        else{ 
          
          //posalji klijentima njihove bodove
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
                 c.write("myID" + "#" + myID + "#" + "Score" + "#" + p.score+ "#" + "clientID" + "#" + p.id);
                 print("myID" + "#" + myID + "#" + "Score" + "#" + p.score+ "#" + "clientID" + "#" + p.id);
              }
            }
  
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
  if(stoperica != null)
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
   int category = (int) random(5);
   if(category == 1)
     bonusQ = true;
   else
     bonusQ = false;
     
   TableRow question = Questions.random_pitanje(category);
   
   //random pitanje je zadnje dodano u postavljena pitanja
   int lastIndex = Questions.postavljena_pitanja[category].size() - 1;
   int number = Questions.postavljena_pitanja[category].get(lastIndex);
   
   rightAnswer = question.getString(1);

   print("redni broj pitanja " + number + "\n");
   print("generirano pitanje: " + question.getString(0) + "\n");
   print("tocan odgovor " + rightAnswer + "\n");

   return "category" + "#" + currCategory + "#" + "number" + "#" + currNumber;
}