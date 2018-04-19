/*

  kombinacija tipki za izlaz je: CTRL + Q

*/

boolean[] keysForQuit = new boolean[2];


boolean odgovorio_na_pitanje = false;

void keyPressed(){
 
 if(key == ESC){
   key = 0;
   return;
 }
 
 if (keyCode == CONTROL){
   keysForQuit[0] = true;
 }
 
 if(key == 'Q' || key == 'q'){
   keysForQuit[1] = true;
 }
 
 else if(begin == true && !odgovorio_na_pitanje && dozvoljenoVrijeme){
  if((key == 'a' || key == 'A')){
      odgovorio_na_pitanje=true;
      crtaj_pravokutnikA(#FFFF66);
      crtaj_pravokutnikS(#bab8ad);
      crtaj_pravokutnikD(#bab8ad);
      crtaj_pravokutnikF(#bab8ad);
      crtajKomande();
    if(rightContainer.compareTo("0") == 0)
      myAnswer = rightAnswer;
  }
    
  else if((key == 's' || key == 'S')){
      odgovorio_na_pitanje=true;
      crtaj_pravokutnikA(#bab8ad);
      crtaj_pravokutnikS(#FFFF66);
      crtaj_pravokutnikD(#bab8ad);
      crtaj_pravokutnikF(#bab8ad);
      crtajKomande();
    if(rightContainer.compareTo("1") == 0)
      myAnswer = rightAnswer;
  }
    
  else if((key == 'd' || key == 'D')){
      odgovorio_na_pitanje=true;  
      crtaj_pravokutnikA(#bab8ad);
      crtaj_pravokutnikS(#bab8ad);
      crtaj_pravokutnikD(#FFFF66);
      crtaj_pravokutnikF(#bab8ad);
      crtajKomande();
    if(rightContainer.compareTo("2") == 0)
      myAnswer = rightAnswer;
  }
    
  else if((key == 'f' || key == 'F')){
      odgovorio_na_pitanje=true;
      crtaj_pravokutnikA(#bab8ad);
      crtaj_pravokutnikS(#bab8ad);
      crtaj_pravokutnikD(#bab8ad);
      crtaj_pravokutnikF(#FFFF66);
      crtajKomande();
    if(rightContainer.compareTo("3") == 0)
      myAnswer = rightAnswer;
  }

    else if((state == 1 || state==4 || state == 5 || state == 6) && begin == true){
      if(state == 5)
        videos[currNumber].stop();
      /*
      else if(state == 6)
        audios[currNumber].stop();
      */
      
      state = 1;
      myAnswer = rightAnswer + rightAnswer;
        slika_loadana=false;
    }
  }
    
    
  if((state == 1 || state==4 || state == 5 || state == 6) && begin == true && myAnswer.length() > 0 ){
      if(state == 5)
        videos[currNumber].stop();
      /*
      else if(state == 6)
        player[currNumber].pause();
      */
      
      state = 1;
      //posalji moj odgovor serveru
      c.write("myID" + "#" + myID + "#" + "name" +  "#" + myName + "#" + "category" + "#" + currCategory + "#" + "number" +  "#" +  currNumber + "#" + "myAnswer" + "#" + myAnswer);
      print("client: " + "myID" + "#" + myID + "#" + "name" + "#" + myName + "#" + "myAnswer" + "#" + myAnswer + "\n");       
      slika_loadana=false;
    
    keyPressed = false;
  }
  
  else{
    if(keyCode == ENTER || keyCode == RETURN){          // iskomentirano radi Otvorenih dana
      if(state == 0 && txtMyName.getText().length() > 0 /*&& txtServerAddress.getText().length() > 0*/) {
        myName = txtMyName.getText();
        // iskomentirano radi Otvorenih dana
        // serverAddress = txtServerAddress.getText();
        // print("serverAddress: " + serverAddress + "\n");
        spajanjeNaServer();
        //treba provjeriti da je unesena dobra ip adressa
        keyPressed = false;
        state = 1;
        return;
      }
    }
  } //<>//
}

void keyReleased(){
  if(keyCode == CONTROL)
    keysForQuit[0] = false;
  if(key == 'Q' || key == 'q')
    keysForQuit[1] = false;
}
