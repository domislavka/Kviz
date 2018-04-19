PImage img, img_original;
int posX,posY;
int smjerX, smjerY;
boolean slika_loadana=false;
int[] original;

PShader maskShader;
PGraphics maskImage;

int i;

void load_slike(int currNumber, int mode)
{
  String image_name="/slike/";
  if(currNumber<10)
    image_name += "slika00"+currNumber;
  else if(currNumber<100)
    image_name += "slika0"+currNumber;
  else
    image_name+="slika"+currNumber;
  image_name+=".jpg";
  
  img = loadImage(image_name);
  img_original = loadImage(image_name);

  switch(mode) {
  case 1:
    smjerX=1;
    smjerY=1;
    //size(800, 800);
    //frameRate(30);
    
    img.loadPixels();
    posX=11;
    posY=11;
    
    original = new int[img.width*img.height];
    original[0]=0;
    for(int i=0; i<img.width*img.height; i++)
      original[i]=img.pixels[i];
    break;
  
  case 2: 
    posX=11;
    posY=11;
    
    smjerX=1;
    smjerY=1;
    //size(800, 800, P2D);
    
    img.loadPixels();
     original = new int[img.width*img.height];
    original[0]=0;
    for(int i=0; i<img.width*img.height; i++)
     {
        original[i]=img.pixels[i];
        img.pixels[i]=0;
      }
      break;
   case 3:
     i=20;
     break;
  }
}


void slika_1(int currNumber)
{
  if(!slika_loadana)
  {  
    load_slike(currNumber, 1);
    slika_loadana=true;
  }
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++ ) {
      // Calculate the 1D location from a 2D grid
      int loc = x + y*img.width;
      // Get the R,G,B values from image
      float r,g,b;
      r = red (original[loc]);
      g = green (original[loc]);
      b = blue (original[loc]);
      // Calculate an amount to change brightness based on proximity to the mouse
      float maxdist = random(60)+20;//dist(0,0,width,height);
      float d = dist(x, y, posX, posY);
      float adjustbrightness = 255*(maxdist-d)/maxdist;
      r += adjustbrightness;
      g += adjustbrightness;
      b += adjustbrightness;
      // Constrain RGB to make sure they are within 0-255 color range
      r = constrain(r, 0, 255);
      g = constrain(g, 0, 255);
      b = constrain(b, 0, 255);
      // Make a new color and set pixel in the window
      color c = color(r, g, b);
      //color c = color(r);
      img.pixels[y*img.width + x] = c;
    }
  }
  imageMode(CENTER);
  img.updatePixels();
  image(img, height/10 + width*0.3, height/10 + 17*height/60,height/2,height/2);
  if(posX>=img.width-10 || posX<=10)
    smjerX*=-1;
  if(posY>=img.height-10 || posY<=10)
    smjerY*=-1;
    
  //posX = (int) random(0,width);
  //posY= (int) random(0,height);
  posX+=smjerX*26;
  posY+=smjerY*4;
  
}

void slika_2(int currNumber)
{
  if(!slika_loadana)
  {  
    load_slike(currNumber, 2);
    slika_loadana=true;
  }
  posX=(int) random(img.width);
  posY=(int) random(img.height);
  int randX = (int) random(10)+10;
  int randY = (int) random(10)+10;
  for (int x = posX-randX; x < posX+randX; x++) {
    for (int y = posY-randY; y < posY+randY; y++ ) {
      if(x>=0 && y>=0 && x<img.width && y<img.height){
      int loc = x + y*img.width;
      // Get the R,G,B values from image
      float r,g,b;
      r = red (original[loc]);
      g = green (original[loc]);
      b = blue (original[loc]);
      
      r = constrain(r, 0, 255);
      g = constrain(g, 0, 255);
      b = constrain(b, 0, 255);
      // Make a new color and set pixel in the window
      color c = color(r, g, b);
      //color c = color(r);
      img.pixels[y*img.width + x] = c;
      }      
    }
  }
  img.updatePixels();
  imageMode(CENTER);
  image(img,height/10 + width*0.3, height/10 + 17*height/60,height/2,height/2);
}


void slika_3(int currNumber)
{
  if(!slika_loadana)
  {  
    load_slike(currNumber, 2);
    slika_loadana=true;
  }
  posX+=smjerX*10;
  posY+=smjerY*26;
  int randX = (int) random(30)+20;
  int randY = (int) random(30)+20;
  for (int x = posX-randX; x < posX+randX; x++) {
    for (int y = posY-randY; y < posY+randY; y++ ) {
      if(x>=0 && y>=0 && x<img.width && y<img.height){
      int loc = x + y*img.width;
      // Get the R,G,B values from image
      float r,g,b;
      r = red (original[loc]);
      g = green (original[loc]);
      b = blue (original[loc]);
      
      r = constrain(r, 0, 255);
      g = constrain(g, 0, 255);
      b = constrain(b, 0, 255);
      // Make a new color and set pixel in the window
      color c = color(r, g, b);
      //color c = color(r);
      img.pixels[y*img.width + x] = c;
      }      
    }
  }
  img.updatePixels();
  imageMode(CENTER);
  image(img,height/10 + width*0.3, height/10 + 17*height/60,height/2,height/2);
  
  if(posX>=img.width-10 || posX<=10)
  {
    smjerX*=-1;
   
  }
  if(posY>=img.height-10 || posY<=10)
  {
    smjerY*=-1;
   
  }
}

void slika_4(int currNumber) {
  
  //------!!!!!-------
  //NE RADI :(
  //------!!!!!-------
  
  
  
  if(!slika_loadana)
  {  
    load_slike(currNumber, 3);
    slika_loadana=true;
  }
  image(img,height/10 + width*0.3, height/10 + 17*height/60,height/2,height/2);  
  if(i>0)
  {
    filter(BLUR,i);  
    i--;
  }
  
}
