void resetServer(){
  
  begin = false;
  //tim = null;
  numQuestions = 10;
  players = new ArrayList<Player>();
  allClients = new ArrayList<Client>();
  rightAnswer = "";
  anyRight = false;
  input = null;
  datas = null;
  playerData = null;
  clientAnswers.clear();
  Questions = new pitanja();
  bonusQ = false;
  
  currCategory = "-1";
  currNumber = "-1";
  prevCategory = "-1";
  prevNumber = "-1";
  
  startScreen();
  buttonStart();
  buttonClose();
}