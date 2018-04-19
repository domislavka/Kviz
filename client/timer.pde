import controlP5.*;
ControlP5 controlP5;
ControlTimer stoperica;
Textlabel t;
color[] colorsTimer = {#FF0000,#FF3300,#ff6600,#ff9900,#FFCC00,#FFFF00,#ccff00,#99ff00,#66ff00,#33ff00};
boolean dozvoljenoVrijeme = true;

class timer{
    float razmak;
    float timer_x;
    float timer_y;
    float timer_w;
    float timer_h;
  
  timer(float visina, float sirina){
    razmak = visina / 60;
    timer_x = 0.6*sirina + visina/5;
    timer_y = razmak + 2*visina/3;
    timer_w = -3*visina/10 + sirina/2.5;
    timer_h = visina/5 + razmak;
  }
  
  void timer_draw(){
    t.setValue(stoperica.toString());
    fill(255);
    stroke(255);
    //ne znam zasto podivlja za i = 100
    if(stoperica.second() != vrijemeZaOdgovor) rect(timer_x, timer_y, timer_w, timer_h, 30);
    rectMode(RADIUS);
    if(stoperica.second() < vrijemeZaOdgovor){
      fill(colorsTimer[(vrijemeZaOdgovor-1) - stoperica.second()]);
      stroke(colorsTimer[(vrijemeZaOdgovor-1) - stoperica.second()]);
    }
    rect(timer_x+timer_w/2,timer_y+timer_h/2,(vrijemeZaOdgovor - stoperica.second())*timer_w/20,timer_h/2,30);
    rectMode(CORNER);
    fill(0);
    textAlign(CENTER,CENTER);
    textSize(timer_h/2);
      if(stoperica.second() < vrijemeZaOdgovor) {
      text(vrijemeZaOdgovor - stoperica.second(),timer_x+timer_w/2,timer_y+timer_h/2);
      dozvoljenoVrijeme = true;
    }
    else
    {
      fill(255);
      rect(timer_x, timer_y, timer_w, timer_h, 30);
      dozvoljenoVrijeme = false;
      textSize(timer_h/4);
      fill(0);
      text("VRIJEME JE\n ISTEKLO",timer_x+timer_w/2,timer_y+timer_h/2);
      crtajTocanOdgovor();
    }
  }
}
