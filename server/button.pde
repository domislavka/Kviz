void buttonStart(){
  stroke(0, 255, 0);
  fill(0, 255, 0);
  rect(2*width/5, 7*height/10, width/5, height/5, 30);
  
  fill(0);
  stroke(0);
  textAlign(CENTER, CENTER);
  textSize(30);
  text("Pokreni!", 0.5*width, 7*height/10 +  height/10);
}

void buttonClose(){
  stroke(255, 0, 0);
  fill(255, 0, 0);
  rect(7*width/10, 7*height/10, width/5, height/5, 30);
  
  fill(0);
  stroke(0);
  textAlign(CENTER, CENTER);
  textSize(30);
  text("Zatvori", 4*width/5, 7*height/10 +  height/10);
}

void mouseClicked(){
  if((mouseX >= 2*width/5 && mouseX <= 2*width/5 + width/5) &&
          (mouseY >= 7*height/10 && mouseY <= 7*height/10 + height/5) ){
      for(Client c : allClients)
        c.write("MyID" + "#" + myID + "#" + "Countdown" + "\n");
      countdown = true;
  }
  
  else if((mouseX >= 7*width/10 && mouseX <= 7*width/10 + width/5) &&
          (mouseY >= 7*height/10 && mouseY <= 7*height/10 + height/5)){
    exit();
  }
}
