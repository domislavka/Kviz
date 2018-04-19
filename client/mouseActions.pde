void mouseOver(){
  
  switch(state){
    case 0:
      if((mouseX >= width/10 && mouseX <= width/10 + width/5) &&
          (mouseY >= 7*height/10 && mouseY <= 7*height/10 + height/5) ){
            buttonHighScore(colors[3]);
      }
         
      else if((mouseX >= 2*width/5 && mouseX <= 2*width/5 + width/5) &&
          (mouseY >= 7*height/10 && mouseY <= 7*height/10 + height/5) ){
            buttonStart(colors[3]);
      }
      
      else if((mouseX >= 7*width/10 && mouseX <= 7*width/10 + width/5) &&
          (mouseY >= 7*height/10 && mouseY <= 7*height/10 + height/5) ){
            buttonClose(colors[3]);
      }
    break;
    case 2:
      if((mouseX >= 7*width/10 && mouseX <= 7*width/10 + width/5) &&
        (mouseY >= 7*height/10 && mouseY <= 7*height/10 + height/5) ){
          buttonGoBack(colors[3]);
      }
      break;
    case 3:
      if((mouseX >= width/10 && mouseX <= width/10 + width/5) &&
          (mouseY >= 7*height/10 && mouseY <= 7*height/10 + height/5) ){
            buttonGoBack(colors[3]);
      }
         
      else if((mouseX >= 2*width/5 && mouseX <= 2*width/5 + width/5) &&
          (mouseY >= 7*height/10 && mouseY <= 7*height/10 + height/5) ){
            buttonReplay(colors[3]);
      }
      break;
    case 7:
      if((mouseX >= 7*width/10 && mouseX <= 7*width/10 + width/5) &&
        (mouseY >= 7*height/10 && mouseY <= 7*height/10 + height/5) ){
          buttonGoBack(colors[3]);
      }
      break;
  }
  
}

void mousePressed(){
  
  //pritisnuli smo "prvi" button
  if((mouseX >= width/10 && mouseX <= width/10 + width/5) &&
      (mouseY >= 7*height/10 && mouseY <= 7*height/10 + height/5) ){
      //highScore
      if(state == 0)
        state = 2;
      //go back u pocetni zaslon
      else if(state == 3){
        state = 0;
        resetPlayer(false);
      }
  }

  else if((mouseX >= 2*width/5 && mouseX <= 2*width/5 + width/5) &&
      (mouseY >= 7*height/10 && mouseY <= 7*height/10 + height/5) ){
      //pritisnuli smo buttonStart                      // iskomentirano radi Otvorenih dana
      if(state == 0 && txtMyName.getText().length() > 0 /*&& txtServerAddress.getText().length() > 0*/){
        myName = txtMyName.getText();
        // iskomentirano radi Otvorenih dana
        // serverAddress = txtServerAddress.getText();
        // print("serverAddress: " + serverAddress + "\n");
        spajanjeNaServer();
        //treba provjeriti da je unesena dobra ip adressa
        state = 1;
      }
      //pritisnuli smo buttonReplay, myName ostavljamo isto
      else if(state == 3){
        state = 1;
        replayButton = true;
        resetPlayer(true);
      }
        
  }
  
  //pritisnuli smo buttonClose
  else if((mouseX >= 7*width/10 && mouseX <= 7*width/10 + width/5) &&
      (mouseY >= 7*height/10 && mouseY <= 7*height/10 + height/5) ){  
      //pritisnuli smo buttonClose u pocetnom zaslonu ili na kraju igre
      if(state == 0){
       state = 7;
      }
      //pritisnuli smo buttonGoBack u highScoreu
      else if(state == 2 || state == 7){
        state = 0;
      }
  }

}
