void resetPlayer(boolean replay){
  if(replay == false){
    myName = "";
    txtMyName.setText("");
  }
  
  myScore = "0";
  scoreSaved = false;
  begin = false;
  input = "";
  datas = null;
  serverData = null;
  videoplay = false;
  currCategory = -1;
  currNumber = -1;
}