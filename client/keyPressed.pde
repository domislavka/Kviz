boolean odgovorio_na_pitanje = false;

void keyPressed(){
 if(begin == true){
  if((key == 'a' || key == 'A')){
    if(!odgovorio_na_pitanje)
    {
      crtaj_pravokutnikA(#FFFF66);
      crtajKomande();
      odgovorio_na_pitanje=true;
    }
    if(rightContainer.compareTo("0") == 0)
      myAnswer = rightAnswer;
  }
    
  else if((key == 's' || key == 'S')){
    if(!odgovorio_na_pitanje)
    {
      crtaj_pravokutnikS(#FFFF66);
      crtajKomande();
      odgovorio_na_pitanje=true;
    }
    if(rightContainer.compareTo("1") == 0)
      myAnswer = rightAnswer;
  }
    
  else if((key == 'd' || key == 'D')){
    if(!odgovorio_na_pitanje)
    {
      crtaj_pravokutnikD(#FFFF66);
      crtajKomande();
      odgovorio_na_pitanje=true;
    }
    if(rightContainer.compareTo("2") == 0)
      myAnswer = rightAnswer;
  }
    
  else if((key == 'f' || key == 'F')){
    if(!odgovorio_na_pitanje)
    {
      crtaj_pravokutnikF(#FFFF66);
      crtajKomande();
      odgovorio_na_pitanje=true;
    }
    if(rightContainer.compareTo("3") == 0)
      myAnswer = rightAnswer;
  }

  else if((state == 1 || state==4 || state == 5 || state == 6) && begin == true){
      if(state == 5)
        videos[currNumber].stop();
      else if(state == 6)
        audios[currNumber].stop();
        
      state = 1;
      myAnswer = rightAnswer + rightAnswer;
        slika_loadana=false;
    }
  }
  
  else{
    if(keyCode == ENTER || keyCode == RETURN){
      if(state == 0 && txtMyName.getText().length() > 0 && txtServerAddress.getText().length() > 0) {
        myName = txtMyName.getText();
        serverAddress = txtServerAddress.getText();
        print("serverAddress: " + serverAddress + "\n");
        spajanjeNaServer();
        //treba provjeriti da je unesena dobra ip adressa
        keyPressed = false;
        state = 1;
        return;
      }
    }
  }
  
  if((state == 1 || state==4 || state == 5 || state == 6) && begin == true && myAnswer.length() > 0 ){
    if(state == 5) //<>//
      videos[currNumber].stop();
    else if(state == 6)
      player[currNumber].pause();
      
    state = 1;
    //posalji moj odgovor serveru
    c.write("myID" + "#" + myID + "#" + "name" +  "#" + myName + "#" + "category" + "#" + currCategory + "#" + "number" +  "#" +  currNumber + "#" + "myAnswer" + "#" + myAnswer);
    print("client: " + "myID" + "#" + myID + "#" + "name" + "#" + myName + "#" + "myAnswer" + "#" + myAnswer + "\n");       
    slika_loadana=false;  
  }
  
  keyPressed = false;
}