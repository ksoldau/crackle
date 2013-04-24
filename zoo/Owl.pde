class Owl { 
    
  Owl() {
  }
  
  void displayOwl() {
    image(LIST_OF_HELP[HELP], 520, 200);
  }
  
  void talkOwl() {
    LIST_OWL_AUDIO[HELP].trigger();
     OWL_TALKING_START_TIME = millis();
  }
}
