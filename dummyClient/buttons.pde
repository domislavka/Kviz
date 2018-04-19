color[] colors = {#DA70D6, #64EE64, #DC143C, #C0C0C0, #FFFF66};

void buttonHighScore(color fillColor){
  stroke(255);
  fill(fillColor);
  rect(width/10, 7*height/10, width/5, height/5, oblost);
  
  fill(0);
  stroke(0);
  textAlign(CENTER, CENTER);
  textSize(30);
  text(highScoreText, width/5, 7*height/10 +  height/10);
}

void buttonStart(color fillColor){
  stroke(255);
  fill(fillColor);
  rect(2*width/5, 7*height/10, width/5, height/5, oblost);
  
  fill(0);
  stroke(0);
  textAlign(CENTER, CENTER);
  textSize(30);
  text(startText, 0.5*width, 7*height/10 +  height/10);
}

void buttonGoBack(color fillColor){
  stroke(255);
  fill(fillColor);

  if(state == 2 || state == 7)
    rect(7*width/10, 7*height/10, width/5, height/5, oblost);
  else if (state == 3)
    rect(width/10, 7*height/10, width/5, height/5, oblost);

  fill(0);
  stroke(0);
  textAlign(CENTER, CENTER);
  textSize(25);
  if(state == 2 || state == 7)
    text(goBackText, 4*width/5, 7*height/10 +  height/10);
  else if (state == 3)
    text(goBackText, width/5, 7*height/10 +  height/10);

}

void buttonReplay(color fillColor){
  stroke(255);
  fill(fillColor);
  rect(2*width/5, 7*height/10, width/5, height/5, oblost);
  
  fill(0);
  stroke(0);
  textAlign(CENTER, CENTER);
  textSize(30);
  text(replayText, 0.5*width, 7*height/10 +  height/10);
}

void buttonClose(color fillColor){
  stroke(fillColor);
  fill(fillColor);
  rect(7*width/10, 7*height/10, width/5, height/5, oblost);
  
  fill(0);
  stroke(0);
  textAlign(CENTER, CENTER);
  textSize(30);
  text(closeText, 4*width/5, 7*height/10 +  height/10);
}