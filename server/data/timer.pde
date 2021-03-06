import controlP5.*;

class timer{
  float timer_x, timer_y, timer_w, timer_h;
  color[] colors={#FF0000,#FF3300,#ff6600,#ff9900,#FFCC00,#FFFF00,#ccff00,#99ff00,#66ff00,#33ff00};
  timer(float visina, float sirina){
    float razmak = visina / 60;
    timer_x = 0.6*sirina + visina/5;
    timer_y = razmak + 2*visina/3;
    timer_w = -3*visina/10 + sirina/2.5;
    timer_h = visina/5 + razmak;
  }
  
  void timer_draw(){
    if(stoperica.second() == 10)
    {
      stoperica.reset();
    }
    else
    { 
      fill(255);
      stroke(255);
      //ne znam zasto podivlja za i = 100
      if(stoperica.second() != 10) rect(timer_x, timer_y, timer_w, timer_h, 30);
      rectMode(RADIUS);
      fill(colors[stoperica.second()]);
      stroke(colors[stoperica.second()]);
      rect(timer_x+timer_w/2,timer_y+timer_h/2,(10 - stoperica.second())*timer_w,timer_h/2,30);
      rectMode(CORNER);
      fill(0);
      textAlign(CENTER,CENTER);
      textSize(timer_h/2);
      text(10 - stoperica.second(),timer_x+timer_w/2,timer_y+timer_h/2);
    }
  }
}