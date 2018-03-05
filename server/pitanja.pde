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
  IntList potrosene_kategorije = new IntList();
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
    print("kategorija na pocetku " + kategorija + "\n");
    //PROVJERIMO IZ KOJIH KATEOGORIJA SMO POTROSILI PITANJA
    for(int i = 0; i < 5; ++i){
      if(postavljena_pitanja[i].size() == tabs_q[i].getRowCount())
        if(potrosene_kategorije.hasValue(i) == false)
          potrosene_kategorije.push(i);
    }
    
    if(potrosene_kategorije.hasValue(kategorija)){
       int rnd_kategorija;
              do{
         rnd_kategorija = (int) random(0, 5);
       }
       while(potrosene_kategorije.hasValue(rnd_kategorija));
       
       kategorija = rnd_kategorija;
       svaPitanja = tabs_q[rnd_kategorija];
    }
    else svaPitanja = tabs_q[kategorija];
    
    print("kategorija " + kategorija);
    
    int br_pitanja;
    do{
      br_pitanja = (int)random(0, svaPitanja.getRowCount());
    }while(postavljena_pitanja[kategorija].hasValue(br_pitanja));
    
    postavljena_pitanja[kategorija].push(br_pitanja);
    
    prevCategory = currCategory;
    prevNumber = currNumber;

    currCategory = str(kategorija);
    currNumber = str(br_pitanja);
   
    
    return svaPitanja.getRow(br_pitanja);
  }
}