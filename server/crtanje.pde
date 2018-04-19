int razmak; 
int oblost = 30;
float sirina_odg;

void startScreen(){
  background(200);
  fill(0);
  stroke(0);
  textSize(30);
  textAlign(LEFT, CENTER);
  text("Prijavljeni: \n", height/10, height/10);
}

void beginCountdown(){
   fill(128);
   stroke(128);
   rectMode(CENTER);
   rect(width/2, height/2, 50, 50);
   textSize(20);
   stroke(0);
   fill(0);
   textAlign(CENTER, CENTER);
   t.setValue(stoperica.toString());
   text(pocetakOdbrojavanja - stoperica.second(), width/2, height/2, -countdownTextSize + countdownTextSize*sin(radians(frameCount*2)));
}
