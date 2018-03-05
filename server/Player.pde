class Player{
  String id;
  String name;
  int score;
  String answer;
  String ip;
  
  Player(String ip){
    this.name = "";
    this.id = "";
    this.ip = ip;
    
    this.score = 0;
    this.answer = "";
  }
  
  Player(String id, String name, String ip){
    this.name = name;
    this.id = id;
    this.ip = ip;
    
    this.score = 0;
    this.answer = "";
  }
  
  @ Override
  boolean equals(Object player){
    if(!(player instanceof Player)) 
      return false;
    return this.id.compareTo(((Player)player).id) == 0;
  }
  
  void show(){
    print(id + " " + name + " " + score + "\n");
  }
  
}

String find(String ip){
  for(Player p : players){
    if(p.ip.compareTo(ip) == 0)
      return p.id;
  }
  return "";
}

double findScore(String ip){
  for(Player p : players){
    if(p.ip.compareTo(ip) == 0)
      return p.score;
  }
  
  return -1;
}