void spajanjeNaServer(){

  c = new Client(this, serverAddress, port);
  try {
    inet = InetAddress.getLocalHost();
    ipAddr = inet.getHostAddress();
    print("HOST: "); 
    println(ipAddr);
  } 
  catch (Exception e) {
    e.printStackTrace();
  }
}