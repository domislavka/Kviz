/*
  KATEGORIJE:
  0 - audio
  1 - bonus
  2 - pitanja
  3 - slike
  4 - video
*/

class pitanja{
  Table[] tabs_q = new Table[5];
  IntList[] postavljena_pitanja = new IntList[5];
  
  pitanja(){
    String[] folder = new String[5];

    folder[0] = "audio/";
    folder[1] = "bonus/";
    folder[2] = "pitanja/";
    folder[3] = "slike/";
    folder[4] = "video/";

    for (int i = 0; i < 5; ++i) {
      tabs_q[i] = new Table();
      tabs_q[i] = loadTable(dataPath(folder[i] + "pitanja.tsv"), "tsv");
      postavljena_pitanja[i] = new IntList();
    }

  }
  
  TableRow random_pitanje(int kategorija){
    Table svaPitanja = null;
    //AKO SMO POTROSILI SVA PITANJA IZ NEKE KATEGORIJE
    if(postavljena_pitanja[kategorija].size() == tabs_q[kategorija].getRowCount() ){
       int rnd_kategorija;
       do{
         rnd_kategorija = (int) random(0, 5);
       }
       while(rnd_kategorija == kategorija);
       
       svaPitanja = tabs_q[rnd_kategorija];
    }
    else svaPitanja = tabs_q[kategorija];
    
    int br_pitanja; 
    do{
      br_pitanja = (int)random(0, svaPitanja.getRowCount());
    }while(postavljena_pitanja[kategorija].hasValue(br_pitanja));
    
    postavljena_pitanja[kategorija].push(br_pitanja);
    
    return svaPitanja.getRow(br_pitanja);
  }
  
  TableRow getPitanje(int category, int number){
    return tabs_q[category].getRow(number);
  }
  
}